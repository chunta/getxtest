import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxapptest/counter_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  // Register Controller Once in Memory
  Get.put<ICounterController>(CounterController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/first', page: () => HomeScreen(key: UniqueKey())),
        GetPage(name: '/second', page: () => SecondScreen(key: UniqueKey())),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the controller (if not already registered)
    final ICounterController controller = Get.find<ICounterController>();

    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
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

/*
class HomeScreen extends StatelessWidget {
  // 不使用 GetxController，而直接在這裡定義一個 Rx 變數
  final RxInt count = 0.obs;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Counter: $count', style: TextStyle(fontSize: 24))),
            ElevatedButton(
              onPressed: () {
                count.value++;  // 直接修改 Rx 變數
              }, 
              child: Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 註冊控制器
    final CounterController controller = Get.find<CounterController>();

    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Counter: ${controller.count}', style: TextStyle(fontSize: 24))),
            ElevatedButton(
              onPressed: () {
                controller.increment;
                //Get.offNamed('/second');
              }, // 當按鈕被點擊時增量計數器
              child: Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}

*/

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key) {
    print(key);
  }

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late CounterController controller;

  @override
  void initState() {
    super.initState();
    // Register the controller with GetX
    controller = Get.find<CounterController>();
  }

  @override
  void dispose() {
    // GetX will automatically dispose of the controller when the screen is disposed
    print('SecondScreen is being disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the first screen
            Get.offNamed('/first');
          },
          child: Text('Back to First Screen'),
        ),
      ),
    );
  }
}
