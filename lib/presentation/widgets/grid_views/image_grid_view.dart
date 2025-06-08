import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class ImageGridView extends StatelessWidget {
  final List<String> imagePaths;

  const ImageGridView({super.key, required this.imagePaths});


  Future<Size> _getImageSize(String path) async {
    final bytes = await File(path).readAsBytes();
    final image = await decodeImageFromList(bytes);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final isSingleImage = imagePaths.length == 1;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final tileWidth = 180.0;
    final crossAxisCount = screenWidth ~/ tileWidth;

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
                future: _getImageSize(imagePath),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final size = snapshot.data!;
                  final width = screenWidth / crossAxisCount;
                  final aspectRatio = size.width / size.height;
                  final height =  width / aspectRatio;


                  return ClipRRect(

                    borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
                    child: SizedBox(
                      height: height,
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },

    );
  }
}
