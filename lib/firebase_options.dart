// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCvjHJww4abGZyR1RA8hfXZ9-fibwgtq-s',
    appId: '1:850729295917:web:f47059d40f86f9df5258a4',
    messagingSenderId: '850729295917',
    projectId: 'ridemaxxing-8584a',
    authDomain: 'ridemaxxing-8584a.firebaseapp.com',
    storageBucket: 'ridemaxxing-8584a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDn01Fe9XfbJg-gZQSdT0i4tL7z8VG9mMc',
    appId: '1:850729295917:android:0be0d1d3401a6bbb5258a4',
    messagingSenderId: '850729295917',
    projectId: 'ridemaxxing-8584a',
    storageBucket: 'ridemaxxing-8584a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBi0_IVtqLSttPwa7-LAubY5IIycZUYAJQ',
    appId: '1:850729295917:ios:9ec59d5539e62e7d5258a4',
    messagingSenderId: '850729295917',
    projectId: 'ridemaxxing-8584a',
    storageBucket: 'ridemaxxing-8584a.firebasestorage.app',
    iosBundleId: 'com.example.ridemaxxingClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBi0_IVtqLSttPwa7-LAubY5IIycZUYAJQ',
    appId: '1:850729295917:ios:9ec59d5539e62e7d5258a4',
    messagingSenderId: '850729295917',
    projectId: 'ridemaxxing-8584a',
    storageBucket: 'ridemaxxing-8584a.firebasestorage.app',
    iosBundleId: 'com.example.ridemaxxingClient',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCvjHJww4abGZyR1RA8hfXZ9-fibwgtq-s',
    appId: '1:850729295917:web:dbc82c153adefee45258a4',
    messagingSenderId: '850729295917',
    projectId: 'ridemaxxing-8584a',
    authDomain: 'ridemaxxing-8584a.firebaseapp.com',
    storageBucket: 'ridemaxxing-8584a.firebasestorage.app',
  );
}
