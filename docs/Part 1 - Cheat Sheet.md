
<div align="center">
  <div style="background: linear-gradient(135deg, #007BFF 0%, #001F3F 100%); 
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
      Dashboard UI
    </h1>
    <h2 style="color: rgba(255,255,255,0.9); 
               font-size: 1.2em; 
               font-weight: 300; 
               margin: 10px 0 0 0; 
               text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">
      Part 1 - Cheat Sheet
    </h2>  </div>
</div>

---

## 📋 Table of Contents

| Step | Topic | Description |
|------|-------|-------------|
| [Step 1](#step-1-set-up-a-new-flutter-project) | **Project Setup** | Create a new Flutter project and configure dark theme |
| [Step 2](#step-2-clean-up-maindart-with-empty-scaffold) | **Clean Scaffold** | Remove default counter, set up StatefulWidget foundation |
| [Step 3](#step-3-add-column-and-empty-ui-functions) | **UI Structure** | Add Column layout and define empty UI component functions |
| [Step 4](#step-4-implement-greeting-text-and-add-padding) | **Greeting & Padding** | Create styled greeting text and add proper spacing |
| [Step 5](#step-5-implement-battery-card-with-variable) | **Battery Card** | Build battery status card with percentage display |
| [Step 6](#step-6-add-temperature-card-with-fl_chart) | **Chart Integration** | Implement temperature visualization with fl_chart |

---

## Step 1: Set Up a New Flutter Project
Open Visual Studio Code, create a new Flutter project, run the app, and explore hot reload to understand dynamic updates. Configure the app to use a dark theme for the UI.  
- Checklist:
  - Go to `View` > `Command Palette` in VS Code.
  - Select `Flutter: New Project`.
  - Choose `Application`.
  - Select a folder and name the project.
  - Press `F5` to run the app once ready.

---

## Step 2: Clean Up main.dart with Empty Scaffold
Edit `main.dart` to remove the default counter example, setting up a `StatefulWidget` with an empty `Scaffold` as a foundation for building the UI.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REC Workshop - Flutter Demo',
      theme: ThemeData.dark(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}
```

---


## Step 3: Add Column and Empty UI Functions
Modify `_MyHomePageState` to include a `Column` in the `Scaffold` body. Define empty `greetingText`, `batteryCard`, and `temperatureCard` functions outside `build` to structure UI components.

```dart
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // Greeting Text
            greetingText(),
            SizedBox(height: 16),

            // Battery Card
            batteryCard(),
            SizedBox(height: 16),

            // Temperature Card
            temperatureCard(),
            SizedBox(height: 16),
        ],
      ),
    );
  }

  // Greeting Text
  Widget greetingText() {
    return Container();
  }

  // Battery Card
  Widget batteryCard() {
    return Container();
  }

  // Temperature Card
  Widget temperatureCard() {
    return Container();
  }
}
```
---

## Step 4: Implement Greeting Text and Add Padding
Update the `greetingText` function to display a styled "Hi Ken!" text. Then wrap the `Column` in a `Padding` widget to add spacing around the UI.

**greetingText Function**:
```dart
Widget greetingText() {
  return Text('Hi User!', style: TextStyle(fontSize: 20));
}
```

**Scaffold with Padding**:
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Text
            greetingText(),
            SizedBox(height: 16),

            // Battery Card
            batteryCard(),
            SizedBox(height: 16),

            // Temperature Card
            temperatureCard(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
```
---

## Step 5: Implement Battery Card with Variable
Define a `battery` variable above the `build` and update the `batteryCard` function to display a `Card` with a `Row` showing a title and battery percentage as text, setting up for a visual upgrade.

```dart
// Battery Card
Widget batteryCard() {
  // Battery percentage variable
  int battery = 85;

  return Card(
    // Card properties - Style
    color: Colors.blue,
    surfaceTintColor: Colors.blue,
    elevation: 3,
    // Child of the card
    child: Padding(
      // Padding for the card content
      padding: EdgeInsets.fromLTRB(16, 16, 25, 16),
      // Row to align the content
      child: Row(
        // Main axis and cross axis alignment -> Space between the title and battery percentage
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        // Children of the row
        children: [
          // Title of the card
          Text(
            'Robot Battery',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // Cutomized Widget - Stack of CircularProgressIndicator and Text
          Stack(
            alignment: Alignment.center,
            children: [
              // SizedBox to hold the CircularProgressIndicator space
              // if not specified, it will render the default size of the CircularProgressIndicator
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  // CircularProgressIndicator properties
                  value: battery / 100, // battery percentage
                  strokeWidth: 6, // width of the progress indicator stroke
                  color: Colors.white, // color of the progress indicator
                  backgroundColor: Colors
                      .white24, // background color of the progress indicator
                ),
              ),
              // Text widget to display the battery percentage
              Text(
                '$battery%', // use $ for variable interpolation
                // Text properties - Style
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
```
---

## Step 6: Add Temperature Card with fl_chart
Add the `fl_chart` package to `pubspec.yaml` to enable charting. Implement the temperature card with a line chart using provided data to visualize temperature trends.

**pubspec.yaml**:
```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  fl_chart: ^1.0.0
```

**fl_chart Import**: </br>
import this line at the top of the file to add the package to the page.
```dart
import 'package:fl_chart/fl_chart.dart';
```


**temperatureCard Function**:
```dart
// Temperature Card
Widget temperatureCard() {
  // temperature data (hour vs temperature in Celsius)
  List<FlSpot> temperatureData = [
    const FlSpot(0, 18), // 00:00 - 18°C
    const FlSpot(2, 17), // 02:00 - 17°C
    const FlSpot(4, 16), // 04:00 - 16°C
    const FlSpot(6, 19), // 06:00 - 19°C
    const FlSpot(8, 22), // 08:00 - 22°C
    const FlSpot(10, 26), // 10:00 - 26°C
    const FlSpot(12, 29), // 12:00 - 29°C
    const FlSpot(14, 32), // 14:00 - 32°C
    const FlSpot(16, 30), // 16:00 - 30°C
    const FlSpot(18, 27), // 18:00 - 27°C
    const FlSpot(20, 24), // 20:00 - 24°C
    const FlSpot(22, 21), // 22:00 - 21°C
    const FlSpot(24, 19), // 24:00 - 19°C
  ];

  return Card(
    elevation: 3,
    // Using a container in the card to set height and padding. if we don't have to set size, we could use Padding directly
    child: Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      // Column to align the title and chart vertically
      child: Column(
        // Making the column start from the top
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Temperature',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 35),
          // Using FlChart package to create a line chart
          // Expanded widget (layout) is used to take all the available space in the column
          // This is important to make the chart fill the available space
          Expanded(
            child: LineChart(
              // LineChartData contains all the configuration for our chart
              LineChartData(
                // Grid configuration - shows horizontal lines but hides vertical lines
                gridData: FlGridData(show: true, drawVerticalLine: false),

                // Configuration for axis titles (labels on each side of the chart)
                titlesData: FlTitlesData(
                  show: true,
                  // Hide titles on the right side
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Hide titles on the top side
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Bottom titles configuration (X-axis - shows hours)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30, // Space reserved for the titles
                      interval:
                          2, // Show a title every 2 hours (0, 2, 4, 6, etc.)
                    ),
                  ),
                  // Left titles configuration (Y-axis - shows temperature)
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval:
                          5, // Show a title every 5 degrees (15, 20, 25, 30, 35)
                      // Custom function to format the temperature labels
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '${value.toInt()}°C', // Convert to integer and add °C
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                      reservedSize:
                          42, // Space reserved for the temperature labels
                    ),
                  ),
                ),
                // Border configuration - we're hiding the border around the chart
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                // Chart boundaries - defines the visible range of data
                minX: 0, // Start at hour 0 (midnight)
                maxX: 24, // End at hour 24 (next midnight)
                minY: 15, // Minimum temperature to show (15°C)
                maxY: 35, // Maximum temperature to show (35°C)
                // Configuration for the actual line(s) on the chart
                lineBarsData: [
                  LineChartBarData(
                    spots:
                        temperatureData, // The data points we defined earlier
                    isCurved:
                        true, // Makes the line curved instead of straight segments
                    curveSmoothness:
                        0.3, // How smooth the curve should be (0-1)
                    color: Theme.of(
                      context,
                    ).primaryColor, // Line color from app theme
                    barWidth: 3, // Thickness of the line
                    isStrokeCapRound: true, // Rounded ends for the line
                    // Configuration for the dots on each data point
                    dotData: FlDotData(
                      show: true, // Show dots on data points
                      getDotPainter: (spot, percent, barData, index) {
                        // Custom dot appearance
                        return FlDotCirclePainter(
                          radius: 4, // Size of the dot
                          color: Theme.of(context).primaryColor, // Dot color
                          strokeWidth: 2, // Border thickness around the dot
                          strokeColor:
                              Colors.white, // Border color around the dot
                        );
                      },
                    ),

                    // Configuration for the area below the line
                    belowBarData: BarAreaData(
                      show: true, // Show the filled area below the line
                      color: Theme.of(context).primaryColor.withOpacity(
                        0.1,
                      ), // Semi-transparent fill
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
```
---
🚀 **Congratulations!** You've built a simple dashboard Flutter app!