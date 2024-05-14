import 'package:firebase_test_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({
    super.key,
    required this.note,
  });

  final Book note;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat.yMd().format(note.createdTime),
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: note.coverImageUrl,
                    imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/no-image.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                note.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
      ),
    );
  }
}