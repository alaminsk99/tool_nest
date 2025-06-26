import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';


/// Main Function is here....

void main()async{
  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Load environment variables before app starts
  //await dotenv.load(fileName: '.env');

  /// GetX Local Storage
  //await GetStorage.init();
  await SharedPreferences.getInstance();
  /// Theme changer
  ///  Get.put(ThemeController());

  /// Await Native Splash
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize Firebase & Authentication





  runApp(const App());
}