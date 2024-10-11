import 'dart:convert';

import 'package:coincap/models/app_config.dart';
import 'package:coincap/pages/home_page.dart';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This should be before the app starts running
  //this ensures that the flutter app and platform specific code is set up proper before anything happens bcz now the functionalioty implemented is going to be accessing the platform specific code
  //this makes sure that the bridge has been initialized
  await loadConfig();
  registerHTTPService();
  await GetIt.instance.get<HttpService>().get('/coins/bitcoin');
  runApp(const MyApp());
}

//to load the file in flutter (APIs, assets, etc) we use rootBundle.loadString
Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString('assets/config/main.json');
  Map _configData = jsonDecode(_configContent);
  //this is the json file that we are going to load
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],
    ),
  );
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HttpService>(
    HttpService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
      ),
      home: HomePage(),
    );
  }
}
