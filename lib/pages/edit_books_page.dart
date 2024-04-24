import 'package:flutter/material.dart';
import 'package:ets_ppb/db/books_database.dart';
import 'package:ets_ppb/model/book.dart';
import 'package:path/path.dart' as Path;

class AddEditBookPage extends StatefulWidget {
  final Book? note;
  const AddEditBookPage({this.note, super.key});

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formkey = GlobalKey<FormState>();
  late String onChangedTitle;
  late String onChangedCoverUrl;
  late String onChangedDescription;

  @override
  void initState() {
    super.initState();
    onChangedTitle = widget.note?.title ?? '';
    onChangedCoverUrl = widget.note?.coverImageUrl ?? '';
    onChangedDescription = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarTextStyle: const TextStyle(color: Colors.white),
        actions: [

          saveButton(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.note?.title,
                  validator: (value) {
                    if(value != null && value.isEmpty) return 'Title cannot be empty';
                    return null;
                  },
                  onChanged: (title) {
                    setState(() {
                      onChangedTitle = title;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white30
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  initialValue: widget.note?.coverImageUrl.toString(),
                  validator: (value) {
                    if(value != null && value.isEmpty) return 'Cover URL cannot be empty';
                    return null;
                  },
                  onChanged: (coverUrl) {
                    setState(() {
                      onChangedCoverUrl = coverUrl;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Cover Url...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white30
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  initialValue: widget.note?.description,
                  validator: (value) {
                    if(value != null && value.isEmpty) return 'Book cannot be empty';
                    return null;
                  },
                  onChanged: (descrption) {
                    setState(() {
                      onChangedDescription = descrption;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Your Book Here...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white30
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget saveButton() {
    return IconButton(
      onPressed: () {
        bool isValid = _formkey.currentState!.validate();
        if(isValid) {
          if(widget.note != null) {
            Book updated = widget.note!.copy(
              title: onChangedTitle,
              coverImageUrl: onChangedCoverUrl,
              description: onChangedDescription,
            );

            print({'updated note is: id ${widget.note!.id}'});
            print(widget.note!.toJson());

            BooksDatabase.instance.update(updated);
          } else {
            BooksDatabase.instance.create(
              Book(title: onChangedTitle, coverImageUrl: onChangedCoverUrl, description: onChangedDescription, createdTime: DateTime.now())
            );
          }
          Navigator.pop(context);
        }
      },
      icon: const Icon(Icons.save)
    );
  }
}