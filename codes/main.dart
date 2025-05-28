// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dashboard_page.dart';
import 'map_page.dart';
import 'remote_control_page.dart';
import 'config_page.dart';

void main() async {
  // Ensure Flutter bindings are initialized before using Firebase
  // This is necessary for Flutter to work properly with Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the title of the app
      title: 'REC Robot Telemetry Demo App',

      // Use the dark theme for the app
      theme: ThemeData.dark(),

      // Define the Customized Dark theme
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        cardTheme: CardThemeData(
          color: const Color(0xFF2C2C30),
          surfaceTintColor: const Color(0xFF2C2C30),
          elevation: 3,
        ),
        primaryColor: const Color(0xFF007BFF),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),

      // Disable the debug banner in the top right corner
      debugShowCheckedModeBanner: false,

      // Set the home page of the app
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  This page serves as the main entry point for the app,
  it doesn't contain any specific visual elements or functionality.
  Instead, it initializes the app and sets up the main navigation structure.
  The main navigation is handled by a bottom navigation bar that allows users
  to switch between different screens: Dashboard, Control, Map, and Config.
  The screens are defined in a list and displayed based on the current index
  of the bottom navigation bar.

  Each screen is a WIDGET that represents a different feature of the app:
  - DashboardScreen: Displays the main dashboard with telemetry data. Interacting with Firebase Firestore.
  - ControlScreen: Provides remote control functionality for the robot. Interacting with Firebase Realtime database.
  - MapScreen: Shows the robot's location on a map. Interacting with Google Maps API.
  - ConfigScreen: Allows Resetting the Firebase's Firestore Database. 
  */

  // ------- VARIABLES ------- //

  // Define the current index for the bottom navigation bar
  int currentIndex = 0;

  // List of screens to display based on the bottom navigation bar index
  final List<Widget> screens = [
    const DashboardScreen(),
    const ControlScreen(),
    const MapScreen(),
    const ConfigScreen(),
  ];

  // ------- BUILD ------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the current screen based on the selected bottom navigation index
      body: screens[currentIndex],

      // Create a custom bottom navigation bar with rounded corners
      bottomNavigationBar: Container(
        // Add margin around the navigation bar
        margin: const EdgeInsets.all(16),

        // Style the container with rounded corners and theme-based color
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).cardColor,
        ),

        child: ClipRRect(
          // Clip the container to have rounded corners
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            // Use fixed type to show all tabs equally
            type: BottomNavigationBarType.fixed,

            // Make background transparent to show container decoration
            backgroundColor: Colors.transparent,
            elevation: 3,

            // Track which tab is currently selected
            currentIndex: currentIndex,

            // Style selected and unselected items
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),

            // Handle tab selection - update current index and rebuild UI
            onTap: (index) {
              // Update the current index when a tab is tapped by setting state
              // Remember UI = f(State), so changing state rebuilds the UI
              setState(() {
                currentIndex = index;
              });
            },

            // Define the navigation tabs with icons and labels
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                label: 'Control',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Config',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
