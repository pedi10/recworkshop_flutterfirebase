
<div align="center">
  <div style="background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%); 
              padding: 40px 20px; 
              border-radius: 15px; 
              margin: 20px 0; 
              box-shadow: 0 10px 30px rgba(0,0,0,0.3);">
    <h1 style="color: white; 
               font-size: 2.5em; 
               font-weight: bold; 
               margin: 0; 
               text-shadow: 2px 2px 4px rgba(0,0,0,0.3); 
               letter-spacing: 1px;">
      🔥 Firebase Integration
    </h1>
    <h2 style="color: rgba(255,255,255,0.9); 
               font-size: 1.2em; 
               font-weight: 300; 
               margin: 10px 0 0 0; 
               text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">
      Part 2 - Cheat Sheet
    </h2>
  </div>
</div>

---

## 📋 Table of Contents

| Step | Topic | Description |
|------|-------|-------------|
| [Step 1](#step-1-create-firebase-project) | **Firebase Setup** | Create Firebase project in console |
| [Step 2](#step-2-integrate-firebase-with-script) | **Integration** | Use FlutterFire CLI to configure and download files |
| [Step 3](#step-3-firestore-database-setup) | **Firestore** | Set up Cloud Firestore and implement data fetching |
| [Step 4](#step-4-realtime-database-setup) | **Realtime DB** | Configure Realtime Database for control features |
| [Step 5](#step-5-google-maps-integration) | **Google Maps** | Implement interactive map with location services |
| [Step 6](#step-6-deployment) | **Deploy** | Deploy app to Firebase Hosting |

---

## Step 1: Create Firebase Project

Create a new Firebase project from the Firebase Console to host your app's backend services.

**Console Setup**:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter your project name
4. Disable Google Analytics
5. Click "Create project"

---

## Step 2: Integrate Firebase with Script

### Part A: Firebase Setup

**One-liner (Replace PROJECT_ID):**
```bash
dart pub global activate flutterfire_cli && flutterfire configure --project=PROJECT_ID && flutter pub add firebase_core cloud_firestore firebase_database google_maps_flutter fl_chart && flutterfire configure
```
when prompted, select web only.
when prompted, select yes to reuse the firebase.json.


**Step-by-step explanation:**
1. `dart pub global activate flutterfire_cli` - Installs FlutterFire CLI globally for Firebase integration
2. `flutterfire configure --project=PROJECT_ID` - Links your Flutter app to your Firebase project (replace PROJECT_ID)
3. `flutter pub add firebase_core cloud_firestore google_maps_flutter` - Adds Firebase dependencies to pubspec.yaml
4. `flutterfire configure` - Generates firebase_options.dart with your project configuration

### Part B: Download Project Files

**One-liner:**
```bash
curl -o lib/main.dart "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/main.dart" && curl -o lib/map_page.dart "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/map_page.dart" && curl -o lib/remote_control_page.dart "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/remote_control_page.dart" && curl -o lib/dashboard_page.dart "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/dashboard_page.dart" && curl -o lib/config_page.dart "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/config_page.dart" && curl -o web/index.html "https://raw.githubusercontent.com/pedi10/recworkshop_flutterfirebase/main/codes/index.html"
```

**Step-by-step explanation:**
1. `curl -o lib/main.dart "..."` - Downloads the main app entry point with Firebase initialization
2. `curl -o lib/map_page.dart "..."` - Downloads the Google Maps integration page
3. `curl -o lib/remote_control_page.dart "..."` - Downloads the robot control interface with Realtime Database
4. `curl -o lib/dashboard_page.dart "..."` - Downloads the dashboard with Firestore data visualization
5. `curl -o lib/config_page.dart "..."` - Downloads configuration file with app constants
6. `curl -o web/index.html "..."` - Downloads web HTML file with Firebase and Maps SDK scripts

**Verification**:
- Check `pubspec.yaml` for new dependencies
- Verify `firebase_options.dart` was created
- Confirm `web/index.html` has Firebase and Maps scripts
---

## Step 3: Firestore Database Setup

**Firebase Console Setup**:
1. In Firebase Console, go to **"Firestore Database"**
2. Click **"Create database"**
3. **Start in test mode** (for development)
4. Choose location: `us-central1` (or closest to you)
5. Click **"Done"**
6. Create collection: `robots`

**Verification**:
- Temperature chart updates by refresh button
- Battery level displays live data
- Button randomize battery level in firestore

---

## Step 4: Realtime Database Setup

**Firebase Console Setup**:
1. In Firebase Console, go to **"Realtime Database"**
2. Click **"Create Database"**
3. **Start in test mode**
4. Choose location: `us-central1`
5. Click **"Done"**

**Verification**:
- Realtime database responds to input changes

---

## Step 5: Google Maps Integration

**Enable Maps API**:
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Go to **"APIs & Services" > "Library"**
4. Search and enable **"Maps JavaScript API"**
5. Go to **"Credentials"** and copy API key

---

## Step 6: Deployment

**Deploy to Firebase Hosting for first time**:

```bash
flutter build web && firebase init hosting && firebase deploy
```

for initializing the firebase hosting, follow this:
1. Select existing project
2. Set public directory: `build/web`
3. Configure as single-page app: **Yes**
4. Set up automatic builds: **No**

**Deploy to Firebase Hosting - updating the webapp**:

```bash
flutter build web && firebase deploy
```

**Verification**:
- Visit your live app URL
- Test all features work online
---


🚀 **Congratulations!** You've built a Flutter app with Firebase!
