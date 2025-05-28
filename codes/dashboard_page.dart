// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /*
  This is the main dashboard screen for the REC Robot Telemetry Demo App.
  It displays the robot's battery level and temperature data in a user-friendly interface.
  The battery level is updated in real-time using a StreamBuilder, while the temperature data
  is fetched using a FutureBuilder. The temperature data is visualized using a line chart.
  The app uses Firebase Firestore to store and retrieve the robot's telemetry data.
  The dashboard includes:
  - A greeting text
  - A battery card that shows the current battery level and its status
  - A temperature card that displays a line chart of temperature readings over time

  The battery card allows users to generate a random battery level for demonstration purposes.
  */

  // ------- VARIABLES ------- //

  // Firebase Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ------- BUILD ------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // instead of using padding directly as body, we use SingleChildScrollView to allow scrolling.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Text
              greetingText(),
              const SizedBox(height: 16),

              // Battery Card with StreamBuilder
              // StreamBuilder is a widget that listens to a stream of data -> in this case, the battery level from Firestore
              StreamBuilder<DocumentSnapshot>(
                // Listen to the 'battery' document in the 'robots' collection
                stream: firestore
                    .collection('robots')
                    .doc('battery')
                    .snapshots(), // snapshots() returns a stream of data
                // Build the UI based on the stream data
                builder: (context, snapshot) {
                  // Check for errors in the stream
                  if (snapshot.hasError) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Error loading battery data'),
                      ),
                    );
                  }
                  // Check if the stream has data and the document exists
                  if (snapshot.hasData && snapshot.data!.exists) {
                    // define the battery level variable
                    int batteryLevel = 0;
                    // Get the battery level from the document data
                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    batteryLevel = data?['battery'] ?? 0;
                    // Call the batteryCard function to build the UI -> Pass the battery level retrieved from Firestore
                    // If the battery level is null, default to 0
                    return batteryCard(batteryLevel);
                  }

                  // If the stream is still loading, show a loading indicator for default
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Temperature Card with FutureBuilder
              // We could also write the FutureBuilder here instead of calling in the temperatureCard() function
              // Difference is, now the read operation is inside the temperatureCard() function, doesn't affect the card UI.
              temperatureCard(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ------- UI FUNCTIONS ------- //

  // Greeting Text
  Widget greetingText() {
    return const Text('Hi User!', style: TextStyle(fontSize: 20));
  }

  // Battery Card
  Widget batteryCard(int batteryLevel) {
    // Pass the battery level as a parameter
    // Changed card to Container so we can have a gradient background
    return Container(
      // Decoration property to apply gradient background
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Color(0xFF001F3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      // intead of .all, we use fromLTRB to have different padding values for each side
      padding: const EdgeInsets.fromLTRB(16, 16, 25, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.battery_charging_full_outlined,
                  size: 25,
                  color: Colors.white,
                ),
                const Text(
                  'Robot Battery',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Display battery level status text based on the battery level
                Text(
                  // Convert battery level to status text within the card, using inline conditional expressions
                  batteryLevel > 75
                      ? 'Battery level is in good condition'
                      : batteryLevel >= 25
                      ? 'Battery level is normal'
                      : 'Battery level is warning',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                // A button to generate a random battery level
                IconButton(
                  // When pressed, call the _updateBatteryLevel function to write a random value to Firestore
                  onPressed: _updateBatteryLevel,
                  icon: const Icon(
                    Icons.auto_fix_high_rounded,
                    color: Colors.white,
                  ),
                  tooltip: 'Generate random battery level',
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: batteryLevel / 100,
                  color: Colors.white,
                  strokeWidth: 6,
                  backgroundColor: Colors.white.withOpacity(0.3),
                ),
              ),
              Text(
                '$batteryLevel%',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Temperature Card
  Widget temperatureCard() {
    return Card(
      surfaceTintColor: const Color(0xFF2C2C30),
      color: const Color(0xFF2C2C30),
      // default margin is 16, but we want to remove it, so it can fill the screen width
      margin: const EdgeInsets.all(0),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and refresh button. we can have lots of nested widgets, like now we have a row within a column
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Temperature',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // The job of this button is to read the temperature data from Firestore again
                // When pressed, it will reset the state of the widget to trigger a rebuild
                IconButton(
                  onPressed: () {
                    // Reset State to Activate FutureBuilder to refresh temperature data
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh temperature data',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              // Use FutureBuilder to fetch temperature data from Firestore
              // FutureBuilder is a widget that fetches data asynchronously. Means it will wait for the data to be available before building the UI.
              // In contrast to StreamBuilder, which listens to a stream of data, FutureBuilder fetches data once.
              // parameter of build is same as StreamBuilder, but we use future instead of stream
              child: FutureBuilder<DocumentSnapshot>(
                // Specify the future to fetch temperature data from Firestore
                future: firestore
                    .collection('robots')
                    .doc('temperature')
                    .get(), // get() fetches the document once
                // Build the UI based on the future data
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading temperature data'),
                    );
                  }

                  // if there's no data or the document doesn't exist, show a message
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                      child: Text('No temperature data available'),
                    );
                  }

                  // if the read is successful, we can proceed to build the chart
                  if (snapshot.hasData) {
                    // Get temperature data from Firestore
                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    final temperatureArray =
                        data?['data'] as List<dynamic>? ?? [];

                    if (temperatureArray.isEmpty) {
                      return const Center(
                        child: Text('No temperature readings'),
                      );
                    }

                    // Convert data to chart points
                    List<FlSpot> spots = [];
                    print(temperatureArray.length);
                    for (int i = 0; i < temperatureArray.length; i++) {
                      final item = temperatureArray[i] as Map<String, dynamic>;
                      final double value = (item['value'] as num).toDouble();
                      spots.add(FlSpot(i.toDouble(), value));
                    }

                    // Sort the spots by x value (time)
                    spots.sort((a, b) => a.x.compareTo(b.x));

                    // Create simple line chart
                    return LineChart(
                      LineChartData(
                        gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 2, // Show every 2nd data point
                              getTitlesWidget: (double value, TitleMeta meta) {
                                // Only show labels for even indices (0, 2, 4, 6, etc.)
                                if (value % 2 != 0) {
                                  return const Text('');
                                }

                                if (value < 0 ||
                                    value >= temperatureArray.length) {
                                  return const Text('');
                                }

                                final item =
                                    temperatureArray[value.toInt()]
                                        as Map<String, dynamic>;
                                final DateTime dateTime =
                                    (item['datetime'] as Timestamp).toDate();
                                return Text(
                                  '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Text(
                                  '${value.toInt()}°C',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                );
                              },
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        minX: 0,
                        maxX: (spots.length - 1).toDouble(),
                        minY:
                            spots
                                .map((spot) => spot.y)
                                .reduce((min, y) => y < min ? y : min) -
                            2,
                        maxY:
                            spots
                                .map((spot) => spot.y)
                                .reduce((max, y) => y > max ? y : max) +
                            2,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Theme.of(context).primaryColor,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // If the future is still loading, show a loading indicator
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------- LOGIC FUNCTIONS ------- //

  // Write random battery value to Firestore
  Future<void> _updateBatteryLevel() async {
    // Generate a random battery level between 0 and 100
    final randomValue = Random().nextInt(101); // 0-100
    // Write the random value to Firestore in the 'robots' collection, 'battery' document
    // we uset await to ensure the write operation completes before proceeding
    // set overwrites the document, so it will always update the battery level
    await firestore.collection('robots').doc('battery').set({
      'battery': randomValue,
    });
  }
}
