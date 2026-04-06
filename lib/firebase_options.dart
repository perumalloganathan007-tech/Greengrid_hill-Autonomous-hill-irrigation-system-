import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for GreenGrid Hill
///
/// SETUP INSTRUCTIONS:
/// 1. Go to https://console.firebase.google.com/
/// 2. Create a new project named "greengrid-hill"
/// 3. Add your app for each platform (Web, Android, iOS)
/// 4. Copy the configuration values below
/// 5. Replace 'YOUR_XXX' placeholders with actual values
///
/// To enable Firebase in the app:
/// - Uncomment the Firebase initialization in lib/main.dart

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2tjiYP4KgFh_ClomJMtLFBn_4Y9M_eT4',
    appId: '1:100159620207:web:50cf0ed26bc98a14c48d6a',
    messagingSenderId: '100159620207',
    projectId: 'greengrid-hill',
    authDomain: 'greengrid-hill.firebaseapp.com',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.firebasestorage.app',
    measurementId: 'G-4XXJJQXG60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'greengrid-hill',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'greengrid-hill',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.appspot.com',
    iosBundleId: 'com.greengrid.greengridhill',
  );
}
