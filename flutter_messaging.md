# Flutter Messaging

## Installation

### Flutterfire installation and setup

Follow the steps listed in this link: https://firebase.google.com/docs/flutter/setup?platform=android

### Install firebase-messaging package

- Run the following command in your terminal to install firebase-messaging

  ```
  flutter pub add firebase_messaging
  ```

- Then run the following command as suggested in firebase docs after each Firebase Flutter plugin package install

  ```
  flutterfire configure
  ```

## Notification setup

### Creating a service class

- Create a dart file that will contain your service class. For example:
  
  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/b0610c7b-367d-4c6f-9c7c-2f8d08463369)

- Create initNotifications method which will initialize the notifications for the app

  ```dart
  Future<void> initNotifications() async {
    // This will request for notification permission when we first opened the app
    await _firebaseMessaging.requestPermission();

    // This will get our token for testing notifications
    final fCMToken = await _firebaseMessaging.getToken();

    // Printing the token to help us test the notifications
    print('firebase messaging token: $fCMToken');
  }
  ```

- Add the following line to your main.dart inside the main function to run initNotifications method

  ```dart
  await FirebaseMessagingAPI().initNotifications();
  ```

  Now your main function may look like this:

  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessagingAPI().initNotifications();
    runApp(const MyApp());
  }
  ```

  


