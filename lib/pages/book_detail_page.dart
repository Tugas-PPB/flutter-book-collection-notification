import 'package:firebase_test_app/db/books_firestore.dart';
import 'package:firebase_test_app/widgets/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:firebase_test_app/db/books_database.dart';
import 'package:firebase_test_app/model/book.dart';
import 'package:firebase_test_app/pages/edit_books_page.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailPage extends StatefulWidget {
  final String noteId;
  final Function? update;
  final BooksFirestoreService booksFirestoreService;

  const BookDetailPage({this.update, required this.noteId, required this.booksFirestoreService, super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isLoading = true;
  late Book note;

  @override
  void initState() {
    super.initState();
    updateBook();
  }

  void updateBook() async {
    setState(() {
      isLoading = true;
    });
    Book loaded = await widget.booksFirestoreService.readBook(widget.noteId);
    setState(() {
      isLoading = false;
      note = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          deleteButton(),
          editButton(),
        ],
      ),
      body: isLoading ? const CircularProgressIndicator()
            : BookDetail(note: note),
    );
  }

  Widget deleteButton() {
    return IconButton(
      onPressed: () {
        // BooksDatabase.instance.delete(note.id!);
        widget.booksFirestoreService.deleteBook(widget.noteId);
        Navigator.pop(context);
      },
      icon: const Icon(Icons.delete)
    );
  }

  Widget editButton() {
    return IconButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddEditBookPage(note: note, docID: widget.noteId, update: widget.update,)
          )
        );
        updateBook();
      },
      icon: const Icon(Icons.edit)
    );
  }
}

