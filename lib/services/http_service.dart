import 'package:dio/dio.dart';
import '../models/app_config.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio(); // Dio class is used to get requests

  AppConfig? _appConfig;
  String? _base_url;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
    // print(_base_url);
  }

  Future<Response?> get(String path) async {
    try {
      final url = "$_base_url$path";
      print("Sending GET request to: $url");

      final response = await dio.get(url);
      print("Response received: ${response.statusCode}");
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        print('Connection error: ${e.message}');
      } else {
        print('HTTPService: Unable to perform GET request. Error: $e');
      }
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
}
