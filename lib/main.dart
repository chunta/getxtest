import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxapptest/counter_controller.dart';

void main() {
  // Register Controller Once in Memory
  Get.put(CounterController());

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
    final CounterController controller = Get.put(CounterController());

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
            TweenAnimationBuilder(
              duration: Duration(seconds: 22),
              tween: Tween<double>(
                  begin: 50, end: 150), // Starting and ending size
              onEnd: () {
                // Reverse the animation to make it loop forever
              },
              builder: (context, size, child) {
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                  ),
                );
              },
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
