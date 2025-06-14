import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class ImageResizeResult extends StatelessWidget {
  const ImageResizeResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              context.read<ImageResizerBloc>().add(ResetState());
              context.go('/');
            },
          ),
        ],
      ),
      body: BlocBuilder<ImageResizerBloc, ImageResizerState>(
        builder: (context, state) {
          if (state is! ImageResized) {
            context.read<ImageResizerBloc>().add(ResetState());
            return const Center(child: Text('No resized image available'));
          }

          return Padding(
            padding: const EdgeInsets.all(TNSizes.defaultSpace),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.memory(state.resizedImage, fit: BoxFit.contain),
                        const Gap(TNSizes.spaceBetweenSections),
                        _buildDetailsCard(state),
                      ],
                    ),
                  ),
                ),
                const Gap(TNSizes.spaceBetweenSections),
                ProcessButton(
                  text: TNTextStrings.saveToGallery,
                  onPressed: () => _saveImage(context, state.resizedImage),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsCard(ImageResized state) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(TNSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Image Details', style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            _buildDetailRow('Original Size', '${state.width} x ${state.height} pixels'),
            _buildDetailRow('File Path', state.originalPath),
            const Gap(TNSizes.spaceBetweenItems),
            const Text(
              'Long press the image to save or share',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TNSizes.spaceXS),
      child: Row(
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _saveImage(BuildContext context, Uint8List imageBytes) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      DialogOptions().showModernErrorDialog(
        context,
        'Storage permission denied',
      );
      return;
    }

    try {
      final result = await ImageGallerySaverPlus.saveImage(imageBytes);
      if (result['isSuccess'] == true) {
        DialogOptions().showModernSuccessDialog(
          context,
          'Image saved to gallery!',
        );
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      DialogOptions().showModernErrorDialog(
        context,
        'Failed to save image: ${e.toString()}',
      );
    }
  }
}