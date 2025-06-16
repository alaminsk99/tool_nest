import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';

class ImageFormatConverterResult extends StatelessWidget {
  final Uint8List convertedBytes;
  final String format;

  const ImageFormatConverterResult({
    super.key,
    required this.convertedBytes,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageFormatConverterResult,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Converted to: ${format.toUpperCase()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Image.memory(
                    convertedBytes,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DownloadButton(
                onPressed: () async {
                  try {
                    final tempDir = await getTemporaryDirectory();
                    final timestamp = DateTime.now().millisecondsSinceEpoch;
                    final fileName = "${TNTextStrings.appNameDirectory}converted_$timestamp.$format";
                    final tempFile = File('${tempDir.path}/$fileName');

                    // Write image bytes to file
                    await tempFile.writeAsBytes(convertedBytes);

                    // Save to Downloads with original format
                    final downloadedPath = await FileServices().saveToDownloads(tempFile.path);

                    if (downloadedPath != null) {
                      SnackbarHelper.showSuccess(context, TNTextStrings.save);
                      await Future.delayed(const Duration(seconds: 1));
                      context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
                    } else {
                      SnackbarHelper.showError(context, TNTextStrings.savingFailed);
                    }
                  } catch (e) {
                    SnackbarHelper.showError(context, TNTextStrings.failedToSave);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
