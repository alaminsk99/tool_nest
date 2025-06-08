import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';


class FileServices {


  Future<String?> saveToDownloads(File pdfFile, String fileName) async {
    if (Platform.isAndroid) {
      final status = await Permission.mediaLibrary.request(); // for Android 13+
      if (!status.isGranted) return null;

      final downloadsDir = Directory(TNTextStrings.downloadDirectory);
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      final newFilePath = '${downloadsDir.path}/$fileName';
      final savedFile = await pdfFile.copy(newFilePath);
      return savedFile.path;
    } else {
      // For iOS or other
      final dir = await getApplicationDocumentsDirectory();
      final savedFile = await pdfFile.copy('${dir.path}/$fileName');
      return savedFile.path;
    }
  }

  /// Opens a file (like PDF, DOC, etc.) using a system handler
  Future<void> openFile(BuildContext context, String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await OpenFile.open(filePath);
    } else {
      SnackbarHelper.showError(context, TNTextStrings.pdfFileNotFound);
    }
  }

  /// Shares a file with optional share message
  Future<void> shareFile(BuildContext context, String filePath, {String? message}) async {
    try {
      await Share.shareXFiles(

        [XFile(filePath)],
        text: message ?? TNTextStrings.hereYourGeneraPDF,
      );
    } catch (e) {
      SnackbarHelper.showError(context, '${TNTextStrings.failToShare}: $e');
    }
  }


}