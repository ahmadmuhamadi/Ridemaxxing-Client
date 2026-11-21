# Ridemaxxing-Client

## Firebase authentication setup

The app uses Firebase Authentication for email/password accounts and Cloud Firestore for each account's basic profile document (`users/{uid}`). Passwords are handled by Firebase Authentication and are never written to Firestore.

1. Create a Firebase project and register the Android app with application ID `com.example.ridemaxxing_client` (and register any other target platforms).
2. Enable **Authentication → Sign-in method → Email/Password** and create a Cloud Firestore database.
3. Install and sign in to the Firebase CLI, then install FlutterFire CLI and run `flutterfire configure` from this directory. Select the platforms you intend to run. For Android, this generates `android/app/google-services.json`; for other platforms it generates their Firebase configuration.
4. Run `flutter pub get` and launch the app.
5. Publish `firestore.rules` to Firestore so each signed-in user can access only their own profile document.

Until Firebase is configured for the selected platform, the app displays a setup screen instead of opening the auth flow.

## Design shit
[figma](https://www.figma.com/design/x5KdFDrs8wprMEj48sLR3q/PoolCar?node-id=0-1&t=hAzEFhK8FcaVKepO-1)


![logo](assets/images/route66.png)

## Color Scheme

<table>
  <thead>
    <tr><th>Swatch</th><th>Color</th><th>Hex</th><th>Used for</th></tr>
  </thead>
  <tbody>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#E8A33D'}} /></td><td>Mustard gold</td><td><code>#E8A33D</code></td><td>Logo frame, top sunset stripe, odometer, Pay button</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#A63D24'}} /></td><td>Rust red</td><td><code>#A63D24</code></td><td>Main buttons, prices, active tab, end point</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#2E8B8B'}} /></td><td>Motel turquoise</td><td><code>#2E8B8B</code></td><td>Start point, avatars, route cards</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#211C19'}} /></td><td>Asphalt</td><td><code>#211C19</code></td><td>Text, outlines, hard shadows, dark headers</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#1F1A17'}} /></td><td>Asphalt (original set)</td><td><code>#1F1A17</code></td><td>Same role in the first Mother Road screens; logo "66"</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#F6EEDD'}} /></td><td>Cream</td><td><code>#F6EEDD</code></td><td>App background</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#FFFBF2'}} /></td><td>Paper</td><td><code>#FFFBF2</code></td><td>Cards, inputs, text on dark and rust</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#5E4F42'}} /></td><td>Dusty brown</td><td><code>#5E4F42</code></td><td>Secondary text, labels, inactive tabs</td></tr>
    <tr><td><div style={{width: 48, height: 24, borderRadius: 4, border: '1px solid #0003', background: '#EBD9B8'}} /></td><td>Desert sand</td><td><code>#EBD9B8</code></td><td>Map background</td></tr>
  </tbody>
</table>
