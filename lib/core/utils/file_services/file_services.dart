import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:tool_nest/core/constants/image_strings.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

import '../snackbar_helpers/snackbar_helper.dart';

class FileServices {
  Future<String?> saveToDownloads(String filePath) async {
    final file = File(filePath);
    final fileName = filePath.split('/').last;

    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) return null;

        final downloadsDir = Directory(TNTextStrings.downloadDirectory);
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync(recursive: true);
        }

        final newPath = '${downloadsDir.path}/$fileName';
        final newFile = await file.copy(newPath);
        return newFile.path;
      } else {
        final dir = await getApplicationDocumentsDirectory();
        final newFile = await file.copy('${dir.path}/$fileName');
        return newFile.path;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> openFile(BuildContext context, String filePath) async {
    if (await File(filePath).exists()) {
      await OpenFile.open(filePath);
    } else {
      SnackbarHelper.showError(context, "File not found");
    }
  }

  Future<void> shareFile(BuildContext context, String filePath, {String? message}) async {
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
      );

      if (result['isSuccess'] == true || result['filePath'] != null) {
        SnackbarHelper.showSuccess(context, TNTextStrings.save);
      } else {
        throw Exception(TNTextStrings.savingFailed);
      }
    } catch (e) {
      SnackbarHelper.showError(context, TNTextStrings.failedToSave);
    } finally {
      onComplete?.call();
    }
  }
  static Future<void> saveImageToGalleryForFormatConverter({
    required BuildContext context,
    required File imageFile,
    required String fileName, // ❌ No extension here
    VoidCallback? onStart,
    VoidCallback? onComplete,
  }) async {
    try {
      onStart?.call();

      final bytes = await imageFile.readAsBytes();

      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        name: fileName, // Just name — no extension
        isReturnImagePathOfIOS: true,
        quality: 100,
      );

      print('Save result: $result'); // ✅ For debugging

      if (result['isSuccess'] == true || result['filePath'] != null) {
        SnackbarHelper.showSuccess(context, TNTextStrings.save);
      } else {
        throw Exception(TNTextStrings.savingFailed);
      }
    } catch (e) {
      SnackbarHelper.showError(context, TNTextStrings.failedToSave);
    } finally {
      onComplete?.call();
    }
  }

}
