// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  /*
  This screen provides remote control functionality for a robot.
  It allows users to control the robot's movement and actions such as turning on/off lights and fire.
  The screen uses Firebase Realtime Database to send commands to the robot.
  The controls include buttons for moving the robot forward, backward, left, right, and stop,
  as well as toggling the light and fire actions.
  The state of the robot's light and fire is tracked using boolean variables,
  and the commands are sent to Firebase when the buttons are pressed.
  */

  // ------- VARIABLES ------- //

  // Firebase database reference
  final database = FirebaseDatabase.instance.ref();

  // Variables to track robot state
  bool lightOn = false;
  bool fireOn = false;

  // ------- BUILD ------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title
      appBar: AppBar(title: const Text('Robot Control')),
      // instead of using padding directly as body, we use SingleChildScrollView to allow scrolling.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Movement Controls Buttons
              movementControls(),

              SizedBox(height: 40),

              // Action Controls for Light and Fire
              actionControls(),
            ],
          ),
        ),
      ),
    );
  }

  // ------- UI FUNCTIONS ------- //

  // Movement Controls with Forward, Backward, Left, Right, and Stop buttons
  Widget movementControls() {
    return Column(
      children: [
        Text(
          'Movement',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),

        // Forward Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: Size(80, 80),
          ),
          onPressed: () => sendCommand('forward'),
          child: Icon(Icons.keyboard_arrow_up, size: 30),
        ),

        SizedBox(height: 10),

        // Left, Stop, Right Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(80, 80),
              ),
              onPressed: () => sendCommand('left'),
              child: Icon(Icons.keyboard_arrow_left, size: 30),
            ),

            SizedBox(width: 10),

            // Stop Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(80, 80),
              ),
              onPressed: () => sendCommand('stop'),
              child: Icon(Icons.stop, size: 30),
            ),

            SizedBox(width: 10),

            // Right Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(80, 80),
              ),
              onPressed: () => sendCommand('right'),
              child: Icon(Icons.keyboard_arrow_right, size: 30),
            ),
          ],
        ),

        SizedBox(height: 10),

        // Backward Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: Size(80, 80),
          ),
          onPressed: () => sendCommand('backward'),
          child: Icon(Icons.keyboard_arrow_down, size: 30),
        ),
      ],
    );
  }

  // Action Controls for Light and Fire
  Widget actionControls() {
    return Column(
      children: [
        Text(
          'Actions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Light Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: lightOn ? Colors.yellow[700] : Colors.grey,
                foregroundColor: Colors.white,
                minimumSize: Size(100, 80),
              ),
              onPressed: () {
                setState(() {
                  lightOn = !lightOn; // Toggle light on/off
                });
                sendCommand('light_toggle');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    lightOn ? Icons.lightbulb : Icons.lightbulb_outline,
                    size: 30,
                  ),
                  Text(lightOn ? 'ON' : 'OFF'),
                ],
              ),
            ),

            SizedBox(width: 20),

            // Fire Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: fireOn ? Colors.orange : Colors.grey,
                foregroundColor: Colors.white,
                minimumSize: Size(100, 80),
              ),
              onPressed: () {
                setState(() {
                  fireOn = !fireOn; // Toggle fire on/off
                });
                sendCommand('fire_toggle');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    fireOn ? Icons.whatshot : Icons.whatshot_outlined,
                    size: 30,
                  ),
                  Text(fireOn ? 'ON' : 'OFF'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ------- LOGIC FUNCTIONS ------- //

  // Function to send commands to Firebase
  void sendCommand(String command) {
    // Update the Firebase database with the command and current state of light and fire
    // using the 'robot' node, use set to overwrite existing data
    database.child('robot').set({
      'command': command,
      'light': lightOn,
      'fire': fireOn,
    });
  }
}
