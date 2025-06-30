import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/services/image/image_service_for_profile.dart';
import 'domain/repositories/auth_repositories/auth_repository.dart';
import 'firebase_options.dart';


/// Main Function is here....

void main()async{
  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  /// Load environment variables before app starts
  //await dotenv.load(fileName: '.env');

  /// GetX Local Storage
  //await GetStorage.init();
  final prefs = await SharedPreferences.getInstance();
  final imageService = ImageService(prefs);
  /// Theme changer
  ///  Get.put(ThemeController());

  /// Await Native Splash
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize Firebase & Authentication

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => AuthRepository(),
      ),
    ],
    child: const App(),
  ),);
}