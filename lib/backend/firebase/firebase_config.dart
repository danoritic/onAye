import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBv9t28c8pQfClRP6dWm1VRqTTJnPjSQ7c",
            authDomain: "onlife-3l26ul.firebaseapp.com",
            projectId: "onlife-3l26ul",
            storageBucket: "onlife-3l26ul.appspot.com",
            messagingSenderId: "683040158819",
            appId: "1:683040158819:web:9dc653448e1b3091c5f456"));
  } else {
    await Firebase.initializeApp();
  }
}
