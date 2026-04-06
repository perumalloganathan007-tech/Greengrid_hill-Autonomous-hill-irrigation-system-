import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'lib/firebase_options.dart';

void main() async {
  debugPrint('🔥 Testing Firebase Connection...\n');

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized successfully!');
    debugPrint('📱 App Name: ${Firebase.app().name}');
    debugPrint('🔑 Project ID: ${Firebase.app().options.projectId}');

    // Test Realtime Database connection
    final database = FirebaseDatabase.instance;
    debugPrint('\n🔧 Testing Realtime Database...');
    debugPrint('📍 Database URL: ${database.databaseURL}');

    // Try to read from database
    final ref = database.ref('sensors');
    debugPrint('\n📡 Attempting to read from /sensors...');

    final snapshot = await ref.get();
    if (snapshot.exists) {
      debugPrint('✅ Successfully connected to Realtime Database!');
      debugPrint('📊 Data found at /sensors: ${snapshot.value}');
    } else {
      debugPrint('⚠️  Database is empty but connection successful!');
      debugPrint('💡 Tip: Add test data to Firebase Realtime Database at /sensors');
    }

    debugPrint('\n🎉 Firebase connection test completed successfully!');
    debugPrint('🚀 Your app is ready to use Firebase!');
  } catch (e) {
    debugPrint('❌ Error connecting to Firebase: $e');
    debugPrint('\n📋 Troubleshooting steps:');
    debugPrint('1. Check your internet connection');
    debugPrint('2. Verify Firebase project exists at console.firebase.google.com');
    debugPrint('3. Ensure firebase_options.dart has correct configuration');
    debugPrint('4. Check Firebase Realtime Database is enabled');
  }
}
