import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test_app/db/books_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_test_app/db/books_database.dart';
import 'package:firebase_test_app/model/book.dart';
import 'package:firebase_test_app/pages/edit_books_page.dart';
import 'package:firebase_test_app/widgets/book_card.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<Map<String, Object?>> books;

  bool isLoading = false;
  bool isDatabaseError = false;
  final booksFirestoreService = BooksFirestoreService();

  void refreshBooks() {
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditBookPage(),
            )
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(stream: booksFirestoreService.getBooksStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Database Error',
                    style: TextStyle(
                      color: Colors.white
                    ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            
            if(snapshot.hasData) {
              books = snapshot.data!.docs.map((book) => {"docID": book.id, "book": Book.fromJson(book.data() as Map<String, Object?>)}).toList();
              
              if(books.length == 0) {
                return const Center(
                  child: Text(
                      'No Books',
                      style: TextStyle(
                        color: Colors.white
                      ),
                  ),
                );
              }

              return StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: List.generate(books.length, (index) {
                  return StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: BookCard(books[index]["book"] as Book, books[index]["docID"] as String, booksFirestoreService: booksFirestoreService, index: index, update: refreshBooks,),
                  );
                }),
              );
            }

            return const Center(
              child: Text(
                  'Database Error',
                  style: TextStyle(
                    color: Colors.white
                  ),
              ),
            );
          },
        )
      ),
    );
  }

  // Widget buildBooks() => StaggeredGrid.count(
  //   crossAxisCount: 2,
  //   mainAxisSpacing: 2,
  //   crossAxisSpacing: 2,
  //   children: List.generate(books.length, (index) {
  //     Book book = books[index];
  //     return StaggeredGridTile.fit(
  //       crossAxisCellCount: 1,
  //       child: BookCard(book, index: index, update: refreshBooks,),
  //     );
  //   }),
  // );
}