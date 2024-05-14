import 'package:firebase_test_app/api/firebase_messaging_api.dart';
import 'package:firebase_test_app/pages/edit_books_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test_app/pages/books_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingAPI().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        useMaterial3: true,
      ),
      home: const BooksPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/add_book_page': (context) => const AddEditBookPage()
      },
    );
  }
}