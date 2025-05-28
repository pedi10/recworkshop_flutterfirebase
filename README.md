# Flutter & Firebase Workshop

Welcome to the **Flutter & Firebase Workshop**! This repository contains the guides and code for a two-part workshop where you'll build a Flutter dashboard app and integrate it with Firebase services. This workshop will guide you through creating a functional app with a user interface, real-time data, and maps integration.



## 📖 Workshop Overview

This workshop is divided into two parts:

- **Part 1: Building a Flutter Dashboard UI**  
  Learn to create a Flutter app with a dark-themed dashboard, including a greeting text, battery status card, and temperature chart using the `fl_chart` package.  
  📄 [Read the Guide](./docs/Part%201%20-%20Cheat%20Sheet.md)

- **Part 2: Firebase Integration**  
  Add Firebase services to your Flutter app, including Firestore for data storage, Realtime Database for live updates, Google Maps for location visualization, and deploy your app to Firebase Hosting.  
  📄 [Read the Guide](./docs/Part%202%20-%20Cheat%20Sheet.md)

---

## 🛠️ Prerequisites
Before starting, 
Follow the [installation guide](./resources/Installation%20Guideline.pdf) to ensure you have the following installed:
- **Flutter SDK**: Version 3.32.0
- **Dart**: Included with Flutter
- **Visual Studio Code**: Recommended IDE for Flutter development 
- **Firebase Account**: Sign in to your console with google account ([Firebase Console](https://console.firebase.google.com/))
- **Google Cloud Account**: For Google Maps API
- **Node.js**: For Firebase CLI
- **FlutterFire CLI**: Installed for Firebase Integration

---

## 📂 Repository Structure
```
recworkshop_flutterfirebase/
├── docs/
│   ├── Part 1 - Cheat Sheet.md      # Guide for building the Flutter UI
│   └── Part 2 - Cheat Sheet.md      # Guide for Firebase integration
├── codes/
│   ├── main.dart                    # Main app entry point
│   ├── dashboard_page.dart          # Dashboard UI implementation
│   ├── map_page.dart                # Google Maps integration
│   ├── remote_control_page.dart     # Realtime Database controls
│   ├── config_page.dart             # App configuration page
│   └── index.html                   # Web app HTML with Firebase/Maps scripts
├── resources/
│   └── Installation Guideline.pdf   # Installation instructions
└── README.md                        # This file
```

---

*Created for the REC Workshop: Flutter & Firebase</br>
Pedram Moshiri</br>
May 2025*
