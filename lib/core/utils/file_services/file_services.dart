import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';

class FileServices {
  /// Request storage permission if on Android
  static Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.storage.request();
    if (status.isGranted) return true;

    // Optionally guide user to settings
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  /// Save any file to Downloads directory
  Future<String?> saveToDownloads(String filePath) async {
    final file = File(filePath);
    final fileName = filePath.split('/').last;

    try {
      if (!await requestStoragePermission()) return null;

      final downloadsDir = Directory(TNTextStrings.downloadDirectory);
      if (!downloadsDir.existsSync()) downloadsDir.createSync(recursive: true);

      final newPath = '${downloadsDir.path}/$fileName';
      final newFile = await file.copy(newPath);
      return newFile.path;
    } catch (e) {
      return null;
    }
  }

  /// Open any file from file path
  Future<void> openFile(BuildContext context, String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await OpenFile.open(filePath);
    } else {
      SnackbarHelper.showError(context, "File not found.");
    }
  }

  /// Share any file with optional message
  Future<void> shareFile(
      BuildContext context,
      String filePath, {
        String? message,
      }) async {
    try {
      await Share.shareXFiles([XFile(filePath)], text: message ?? "Here is your file");
    } catch (e) {
      SnackbarHelper.showError(context, "Failed to share: $e");
    }
  }

  static Future<void> saveImageToGallery({
    required BuildContext context,
    required File imageFile,
    String? fileName,
    VoidCallback? onStart,
    VoidCallback? onComplete,
  }) async {
    try {
      onStart?.call();
      final bytes = await imageFile.readAsBytes();

      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        name: fileName ?? "${TNTextStrings.appNameDirectory}${DateTime.now().millisecondsSinceEpoch}",
        quality: 100,
      );


      if (result['isSuccess'] != true && result['filePath'] == null) {
        throw Exception(TNTextStrings.savingFailed);
      }
    } catch (e) {
      SnackbarHelper.showError(context, TNTextStrings.failedToSave);
    } finally {
      onComplete?.call();
    }
  }

  /// Save image to gallery for format converter (no extension in name)
  static Future<void> saveImageToGalleryForFormatConverter({
    required BuildContext context,
    required File imageFile,
    required String fileName,
    VoidCallback? onStart,
    VoidCallback? onComplete,
  }) async {
    try {
      onStart?.call();
      final bytes = await imageFile.readAsBytes();

      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        name: fileName,
        isReturnImagePathOfIOS: true,
        quality: 100,
      );


      if (result['isSuccess'] != true && result['filePath'] == null) {
        throw Exception(TNTextStrings.savingFailed);
      }
    } catch (e) {
      SnackbarHelper.showError(context, TNTextStrings.failedToSave);
    } finally {
      onComplete?.call();
    }
  }
}
