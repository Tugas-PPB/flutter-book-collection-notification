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

### Creating a service class and sending first notification

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

- Rebuild your app

  Simply rebuild your app by stopping your previous debug session and starting a new one by clicking the run and debug button (in vscode)

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/09f11d83-33e6-47b8-bdb5-b75ace31ba2e)

  Find and copy your token in the debug console

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/51bb1416-0c73-410c-8b4c-b6e5cc666511)

- Create test notification in firebase console

  Open your firebase console and click on Engage > Messaging inside Product Categories to access Firebase Cloud Messaging feature

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/5f3c31ce-d5e4-443d-9102-eb22a555f1e2)

  Click on create your first campaign

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/c25f5cb4-84f5-47e9-b914-a77c39629abe)

  A popup will open and select firebase notification messages

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/5008bb86-c18b-4f47-b6e7-b18e18aa9805)

  Add notification title and text (inside red box) and click send test message (inside green box)

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/40fe38eb-11be-4bf9-8ef3-0754e093b5fe)

  A popup will open and click `Add an FCM registration token` then paste your token from earlier here

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/104bec9b-97ee-4585-93e4-b38a05a7221c)

  Click on the plus icon

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/98640a51-64e4-4875-97f9-3e86ed4f58d6)

  Make sure your token is checked here

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/06cee1e7-2da4-4435-b4a9-a17729f3a754)

  Make sure that your app is closed in your emulator, then click test

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/28d0ff10-bfd7-4c25-942b-6c30c96ebf33)

  Congrats on your first notification!

  ![image](https://github.com/Tugas-PPB/flutter-book-collection-notification/assets/114855785/e496244b-7d88-484c-8725-d0149ed32bb0)








  





  



  


