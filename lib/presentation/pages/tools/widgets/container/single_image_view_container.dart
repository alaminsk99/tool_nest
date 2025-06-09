import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_core_helper/file_core_helper.dart';
import 'package:tool_nest/core/utils/helper/helper_functions.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/selected_image_container_with_image_path.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class SingleImageViewContainer extends StatelessWidget {
  const SingleImageViewContainer({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use constraints directly instead of screen width
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return FutureBuilder<Size>(
          future: getImageSize(imagePath),
          builder: (context, snapshot) {

            if (snapshot.hasError || !File(imagePath).existsSync()) {
              TNHelperFunctions().showToastMessage(TNTextStrings.errorPickingImages);
              return SizedBox.shrink();
            }

            // Handle loading state
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: TNColors.primary),
              );
            }

            final size = snapshot.data!;
            return _buildImageContainer(size, maxWidth, maxHeight);
          },
        );
      },
    );
  }

  Widget _buildImageContainer(Size imageSize, double maxWidth, double maxHeight) {
    final aspectRatio = imageSize.width / imageSize.height;
    double containerWidth = maxWidth;
    double containerHeight = maxWidth / aspectRatio;

    // Adjust if calculated height exceeds available height
    if (containerHeight > maxHeight) {
      containerHeight = maxHeight;
      containerWidth = maxHeight * aspectRatio;
    }

    return Center(
      child: SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: SelectedImageContainerWithPath(imagePath: imagePath, height: containerHeight,),
      ),
    );
  }

}