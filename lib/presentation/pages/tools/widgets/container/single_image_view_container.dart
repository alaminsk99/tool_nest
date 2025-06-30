import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/file_core_helper/file_core_helper.dart';
import 'package:toolest/core/utils/helper/helper_functions.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/select_image_container_with_image_code.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/selected_image_container_with_image_path.dart';

class SingleImageViewContainer extends StatelessWidget {
  const SingleImageViewContainer({
    super.key,
    this.imagePath,
    this.imageBytes,
  });

  final String? imagePath;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // Case 1: show image from memory (bytes)
        if (imagePath == null && imageBytes != null) {
          return SelectImageContainerWithImageCode(imageBytes: imageBytes!);
        }

        // Case 2: show image from file path
        if (imagePath != null && File(imagePath!).existsSync()) {
          return FutureBuilder<Size>(
            future: getImageSize(imagePath!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: TNColors.primary),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                TNHelperFunctions().showToastMessage(TNTextStrings.errorPickingImages);
                return const SizedBox.shrink();
              }

              final size = snapshot.data!;
              return _buildImageContainer(size, maxWidth, maxHeight);
            },
          );
        }

        // Fallback
        TNHelperFunctions().showToastMessage(TNTextStrings.errorPickingImages);
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildImageContainer(Size imageSize, double maxWidth, double maxHeight) {
    final aspectRatio = imageSize.width / imageSize.height;
    double containerWidth = maxWidth;
    double containerHeight = maxWidth / aspectRatio;

    if (containerHeight > maxHeight) {
      containerHeight = maxHeight;
      containerWidth = maxHeight * aspectRatio;
    }

    return Center(
      child: SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: SelectedImageContainerWithPath(
          imagePath: imagePath!,
          height: containerHeight,
        ),
      ),
    );
  }
}
