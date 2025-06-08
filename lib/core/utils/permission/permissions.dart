import 'package:permission_handler/permission_handler.dart';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  if (await Permission.storage.isGranted) return true;

  final status = await Permission.storage.request();
  if (status.isGranted) return true;

  // Optional for Android 11+ (Scoped Storage)
  if (await Permission.manageExternalStorage.isDenied) {
    final manageStatus = await Permission.manageExternalStorage.request();
    return manageStatus.isGranted;
  }

  return false;
}
