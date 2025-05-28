// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => ConfigScreenState();
}

class ConfigScreenState extends State<ConfigScreen> {
  /*
  This screen allows users to reset the robot's dashboard data to default values.
  It provides two main functionalities:
  1. Resetting the battery data to a default level of 85%.
  2. Resetting the temperature data to a default 24-hour pattern.
  The screen uses Firebase Firestore to store and retrieve the data.
  The UI consists of two cards, each with a button to perform the reset action.
  The battery reset card displays a battery icon and a button to reset the battery level,
  while the temperature reset card displays a temperature icon and a button to reset the temperature readings.
  When the reset buttons are pressed, the corresponding data is updated in Firebase,
  and a success message is shown to the user.
  */

  // ------- VARIABLES ------- //

  // Create connection to Firebase database
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ------- BUILD ------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar with title
      appBar: AppBar(title: const Text('Config')),

      // Scrollable page content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page title
              const Text('Reset dashboard data to default values'),
              const SizedBox(height: 32),

              // Button to reset battery data only
              batteryResetCard(),
              const SizedBox(height: 16),

              // Button to reset temperature data only
              temperatureResetCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ------- UI FUNCTIONS ------- //

  // Simple function to create battery reset card
  Widget batteryResetCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Blue battery icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.battery_charging_full,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Title and description
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reset Battery Data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Reset robot battery level to 85%',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Reset button
            IconButton(
              onPressed: resetBatteryData,
              icon: const Icon(Icons.refresh),
              style: IconButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.1),
                foregroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simple function to create temperature reset card
  Widget temperatureResetCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Orange temperature icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.thermostat,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Title and description
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reset Temperature Data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Reset temperature readings to default 24-hour pattern',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Reset button
            IconButton(
              onPressed: resetTemperatureData,
              icon: const Icon(Icons.refresh),
              style: IconButton.styleFrom(
                backgroundColor: Colors.orange.withOpacity(0.1),
                foregroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------- LOGIC FUNCTIONS ------- //

  // Function to reset battery data back to 85%
  Future<void> resetBatteryData() async {
    // using a try-catch block to handle any errors
    try {
      // Save battery level of 85% to Firebase
      await firestore.collection('robots').doc('battery').set({
        'battery': 85, // Set battery to 85%
      });

      // Show success message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Battery data reset to default (85%)'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Show error message if something goes wrong
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error resetting battery data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Function to reset temperature data with 24 hours of fake data
  Future<void> resetTemperatureData() async {
    try {
      // Create empty list to store temperature data
      List<Map<String, dynamic>> temperatureList = [];
      DateTime currentTime = DateTime.now();

      // Make 24 temperature readings (one for each 2 hour)
      for (int hour = 0; hour < 12; hour++) {
        // Calculate time for each 2-hour interval with .00 minutes
        DateTime timeForThisHour = DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          hour * 2, // Every 2 hours (0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22)
          0, // .00 minutes
        );

        // Create random temperature between 20-30 degrees
        double fakeTemperature = 20.0 + (20.0 * math.Random().nextDouble());

        // Add this temperature reading to our list
        temperatureList.add({
          'value': fakeTemperature.round(), // Round to whole number
          'datetime': Timestamp.fromDate(timeForThisHour),
        });
      }

      // Save all temperature data to Firebase
      await firestore.collection('robots').doc('temperature').set({
        'data': temperatureList,
      }); // Show success message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Temperature data reset to default values'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Show error message if something goes wrong
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error resetting temperature data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
