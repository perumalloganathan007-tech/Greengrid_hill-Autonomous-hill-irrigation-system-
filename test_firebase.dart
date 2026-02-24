import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'lib/firebase_options.dart';

void main() async {
  print('🔥 Testing Firebase Connection...\n');
  
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully!');
    print('📱 App Name: ${Firebase.app().name}');
    print('🔑 Project ID: ${Firebase.app().options.projectId}');
    
    // Test Realtime Database connection
    final database = FirebaseDatabase.instance;
    print('\n🔧 Testing Realtime Database...');
    print('📍 Database URL: ${database.databaseURL}');
    
    // Try to read from database
    final ref = database.ref('sensors');
    print('\n📡 Attempting to read from /sensors...');
    
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print('✅ Successfully connected to Realtime Database!');
      print('📊 Data found at /sensors: ${snapshot.value}');
    } else {
      print('⚠️  Database is empty but connection successful!');
      print('💡 Tip: Add test data to Firebase Realtime Database at /sensors');
    }
    
    print('\n🎉 Firebase connection test completed successfully!');
    print('🚀 Your app is ready to use Firebase!');
    
  } catch (e) {
    print('❌ Error connecting to Firebase: $e');
    print('\n📋 Troubleshooting steps:');
    print('1. Check your internet connection');
    print('2. Verify Firebase project exists at console.firebase.google.com');
    print('3. Ensure firebase_options.dart has correct configuration');
    print('4. Check Firebase Realtime Database is enabled');
  }
}
