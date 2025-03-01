import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxapptest/counter_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  // Register Controller Once in Memory
  Get.put<ICounterController>(CounterIncrementController(), tag: "+");
  Get.put<ICounterController>(CounterDecrementController(), tag: "-");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FirstScreen(),
      getPages: [
        GetPage(name: '/first', page: () => FirstScreen(key: UniqueKey())),
        GetPage(name: '/second', page: () => SecondScreen(key: UniqueKey())),
      ],
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the controller (if not already registered)
    final ICounterController controller = Get.find<ICounterController>(tag: "+");

    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the Counter Value
            Obx(() => Text('Counter: ${controller.count}',
                style: TextStyle(fontSize: 24))),

            SizedBox(height: 20),

            // Button to trigger the API data fetch
            ElevatedButton(
              onPressed: () {
                // Fetch data from the API and update the count
                Get.toNamed('/second');
              },
              child: Text('To Second Screen'),
            ),

            // Button to trigger the API data fetch
            ElevatedButton(
              onPressed: () async {
                // Fetch data from the API and update the count
                await controller.fetchDataFromApi();
              },
              child: Text('Fetch Data and Update Counter'),
            ),

            // Animation for a growing and shrinking circular shape
            SizedBox(height: 40),
            SizedBox(
              width: 100,
              height: 100,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                  colors: const [Colors.white],       /// Optional, The color collections
                  strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.black,      /// Optional, Background of the widget
                  pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the controller (if not already registered)
    final ICounterController controller = Get.find<ICounterController>(tag: "-");

    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the Counter Value
            Obx(() => Text('Counter: ${controller.count}',
                style: TextStyle(fontSize: 24))),

            SizedBox(height: 20),

            // Button to trigger the API data fetch
            ElevatedButton(
              onPressed: () {
                // Fetch data from the API and update the count
                Get.toNamed('/first');
              },
              child: Text('To First Screen'),
            ),

            // Button to trigger the API data fetch
            ElevatedButton(
              onPressed: () async {
                // Fetch data from the API and update the count
                await controller.fetchDataFromApi();
              },
              child: Text('Fetch Data and Update Counter'),
            ),

            // Animation for a growing and shrinking circular shape
            SizedBox(height: 40),
            SizedBox(
              width: 100,
              height: 100,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                  colors: const [Colors.black],       /// Optional, The color collections
                  strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.black,      /// Optional, Background of the widget
                  pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
