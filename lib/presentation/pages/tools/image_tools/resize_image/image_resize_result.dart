import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/single_image_view_container.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class ImageResizeResult extends StatelessWidget {
  final Uint8List imageBytes;
  final int width;
  final int height;

  const ImageResizeResult({
    super.key,
    required this.imageBytes,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageResizeResult,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: TNPaddingStyle.allPadding,
            child: Column(
              children: [
                /// Show Resized Image
                SingleImageViewContainer(imageBytes: imageBytes),

                Gap(TNSizes.spaceBetweenItems),

                /// Resized Image Details
                Text(
                  '$width x $height px',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                Gap(TNSizes.spaceBetweenSections),

                /// Save Button (you can implement actual save logic)
                DownloadButton(onPressed: () async {
                  final tempDir = await getTemporaryDirectory();
                  final file = File('${tempDir.path}/resized_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

                  await file.writeAsBytes(imageBytes);

                  bool isSuccess = false;
                  await FileServices.saveImageToGallery(
                    context: context,
                    imageFile: file,
                    onComplete: () {
                      isSuccess = true;
                    },
                  );
                  /// If Save Successfull then Goto Other screen
                  if (isSuccess) {
                    Future.delayed(const Duration(seconds: 1), () {
                      context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
                    });
                  }
                }),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
