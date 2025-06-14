import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/utils/file_core_helper/file_core_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/selected_image_container_with_image_path.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/single_image_view_container.dart';

class ImageGridView extends StatelessWidget {
  final List<String> imagePaths;

  const ImageGridView({super.key, required this.imagePaths});




  @override
  Widget build(BuildContext context) {
    final isSingleImage = imagePaths.length == 1;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final tileWidth = 180.0;
    final crossAxisCount = screenWidth ~/ tileWidth;

    if(isSingleImage){
      return SingleImageViewContainer(imagePath: imagePaths[0]);
    }else{
      return LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: MasonryGridView.count(
              crossAxisCount: isSingleImage ? 1 : crossAxisCount.clamp(1, 4),
              mainAxisSpacing: TNSizes.spaceMD,
              crossAxisSpacing: TNSizes.spaceMD,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final imagePath = imagePaths[index];
                return FutureBuilder<Size>(
                  future: getImageSize(imagePath),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final size = snapshot.data!;
                    final width = screenWidth / crossAxisCount;
                    final aspectRatio = size.width / size.height;
                    final height =  width / aspectRatio;


                    return SelectedImageContainerWithPath(height: height, imagePath: imagePath);
                  },
                );
              },
            ),
          );
        },

      );
    }


  }
}

