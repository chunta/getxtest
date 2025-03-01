import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

abstract class ICounterController extends GetxController {
  var count = 0.obs;

  Future<void> fetchDataFromApi();
}

class CounterController extends ICounterController {
  late Dio dio; // Dio instance

  // Constructor
  CounterController() {
    print('CounterController is being created!');
    dio = Dio();
    dio.httpClientAdapter = NativeAdapter(
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            ..allowsCellularAccess = true
            ..allowsConstrainedNetworkAccess = true
            ..allowsExpensiveNetworkAccess = true,
    ); // Set the native Dio adapter
  }

  // Method to fetch data from a remote API using Dio with native adapter
  Future<void> fetchDataFromApi() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

      if (response.statusCode == 200) {
        print("Data arrived");

        // Parse the response and get the number of rows returned
        final List<dynamic> data = response.data;
        count.value += data.length; // Set count to the number of posts
      } else {
        // Handle the error when the request fails
        print('Failed to load data');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  void onClose() {
    print('CounterController is being destroyed!');
    super.onClose();
  }

  @override
  void dispose() {
    // Clean up resources when the controller is disposed
    print('CounterController is being disposed!');
    super.dispose();
  }
}
