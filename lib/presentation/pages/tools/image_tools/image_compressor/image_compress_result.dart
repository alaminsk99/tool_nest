import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button_with_bacground_color.dart' show IconWithOutlineButtonWithBackgroundColor;
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class ImageCompressResult extends StatefulWidget {
  const ImageCompressResult({super.key, required this.state});
  final ImageCompressionSuccess state;

  @override
  State<ImageCompressResult> createState() => _ImageCompressResultState();
}

class _ImageCompressResultState extends State<ImageCompressResult> {
  bool _showOriginal = false;
  bool _isSaving = false;


  @override
  Widget build(BuildContext context) {
    final currentFile = _showOriginal
        ? widget.state.selectedImage!
        : widget.state.compressedFile;

    final currentSize = _showOriginal
        ? widget.state.originalSize
        : widget.state.compressedSize;

    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.compressionResult, isLeadingIcon: true,widgets: [
        IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _isSaving ? null : () async{
              try{
                await FileServices.saveImageToGallery(
                  context: context,
                  imageFile: widget.state.compressedFile,
                  fileName: "${TNTextStrings.appNameDirectory}${DateTime.now().millisecondsSinceEpoch}",
                  onStart: () => setState(() => _isSaving = true),
                  onComplete: () => setState(() => _isSaving = false),
                );

                /// If Save Successfull then Goto Other screen
                Future.delayed(const Duration(seconds: 1), () {
                  context.pushNamed(
                    AppRoutes.processFinishedForImgToPdf,
                    extra: 'null',
                  );
                });
              }catch(e){
                debugPrint("Save error: $e");
              }


            },
          color: TNColors.white,
          ),],),

      body: SafeArea(
        child: Column(
          children: [
            // Preview Section
            Expanded(
              child: Stack(
                children: [
                  PhotoView(
                    imageProvider: FileImage(currentFile),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  ),

                  // Size Indicator
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        currentSize,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Comparison Controls
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: IconWithOutlineButtonWithBackgroundColor(
                      icon: _showOriginal
                          ? Icons.toggle_on
                          : Icons.toggle_off,
                      title: TNTextStrings.showOriginal,
                      onPressed: () => setState(() => _showOriginal = true),
                        color: _showOriginal
                            ? TNColors.materialPrimaryColor[300]
                            : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(

                    child: IconWithOutlineButtonWithBackgroundColor(
                      color: _showOriginal?null:TNColors.materialPrimaryColor[300],
                        icon: !_showOriginal
                              ? Icons.toggle_on
                              : Icons.toggle_off,

                        title:TNTextStrings.showCompressed,
                       onPressed: () => setState(() => _showOriginal = false,
                       ),
                    ),

                  ),
                ],
              ),
            ),

            // Info Panel
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(TNTextStrings.original,
                          style:
                          Theme.of(context).textTheme.labelSmall),
                      Text(widget.state.originalSize,
                          style:
                          Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const Icon(Icons.arrow_right_alt, size: 36),
                  Column(
                    children: [
                      Text(TNTextStrings.compressed,
                          style:
                          Theme.of(context).textTheme.labelSmall),
                      Text(widget.state.compressedSize,
                          style:
                          Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Column(
                    children: [
                      Text(TNTextStrings.reduction,
                          style:
                          Theme.of(context).textTheme.labelSmall),
                      Text(
                        _calculateReduction(
                          widget.state.selectedImage!.lengthSync(),
                          widget.state.compressedFile.lengthSync(),
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateReduction(int original, int compressed) {
    final reduction = ((original - compressed) / original * 100).round();
    return '$reduction%';
  }
}