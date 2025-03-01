import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

abstract class ICounterController extends GetxController {
  var count = 0.obs;

  Future<void> fetchDataFromApi();
}

class CounterIncrementController extends ICounterController {
  late Dio dio; // Dio instance

  // Constructor
  CounterIncrementController() {
    logger.d('CounterIncrementController is being created!');
    dio = Dio();
    dio.httpClientAdapter = NativeAdapter(
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            ..allowsCellularAccess = true
            ..allowsConstrainedNetworkAccess = true
            ..allowsExpensiveNetworkAccess = true,
    );
  }

  @override
  Future<void> fetchDataFromApi() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

      if (response.statusCode == 200) {
        logger.d("Data arrived");

        // Parse the response and get the number of rows returned
        final List<dynamic> data = response.data;
        count.value += data.length;
      } else {
        logger.d('Failed to load data');
      }
    } catch (e) {
      logger.d('Error occurred: $e');
    }
  }

  @override
  void onClose() {
    logger.d('CounterIncrementController is being destroyed!');
    super.onClose();
  }

  @override
  void dispose() {
    logger.d('CounterIncrementController is being disposed!');
    super.dispose();
  }
}

class CounterDecrementController extends ICounterController {
  late Dio dio; // Dio instance

  // Constructor
  CounterDecrementController() {
    logger.d('CounterDecrementController is being created!');
    dio = Dio();
    dio.httpClientAdapter = NativeAdapter(
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            ..allowsCellularAccess = true
            ..allowsConstrainedNetworkAccess = true
            ..allowsExpensiveNetworkAccess = true,
    );
  }

  @override
  Future<void> fetchDataFromApi() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

      if (response.statusCode == 200) {
        logger.d("Data arrived");

        // Parse the response and get the number of rows returned
        final List<dynamic> data = response.data;
        count.value -= data.length;
      } else {
        logger.d('Failed to load data');
      }
    } catch (e) {
      logger.d('Error occurred: $e');
    }
  }

  @override
  void onClose() {
    logger.d('CounterDecrementController is being destroyed!');
    super.onClose();
  }

  @override
  void dispose() {
    logger.d('CounterDecrementController is being disposed!');
    super.dispose();
  }
}