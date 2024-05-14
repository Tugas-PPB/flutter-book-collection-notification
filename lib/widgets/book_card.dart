import 'package:firebase_test_app/db/books_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_test_app/model/book.dart';
import 'package:firebase_test_app/pages/book_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class BookCard extends StatelessWidget {
  final BooksFirestoreService booksFirestoreService;
  final Book book;
  final String docID;
  final Function? update;
  final int index;
  const BookCard(this.book, this.docID, {
    required this.index,
    required this.booksFirestoreService,
    this.update,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailPage(noteId: docID, booksFirestoreService: booksFirestoreService,)
          )
        );
        if(update != null) update!();
      },
      child: Card(
        color: getColor(index),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMd().format(book.createdTime),
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5,),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: book.coverImageUrl,
                  imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/no-image.png'),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(int index) {
    switch(index % 5) {
      case 0: 
        return const Color.fromARGB(255, 241,245,143);
      case 1: 
        return const Color.fromARGB(255, 255,169,48);
      case 2: 
        return const Color.fromARGB(255, 255,50,178);
      case 3: 
        return const Color.fromARGB(255, 169,237,241);
      case 4: 
        return const Color.fromARGB(255, 116,237,75);
    }
    return Colors.white;
  }
}