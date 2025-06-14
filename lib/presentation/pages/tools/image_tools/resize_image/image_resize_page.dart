import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';

import 'package:tool_nest/presentation/pages/tools/widgets/container/single_image_view_container.dart';import 'package:tool_nest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';



class ImageResizePage extends StatelessWidget {
  const ImageResizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Resizer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ImageResizerBloc, ImageResizerState>(
                listener: (context, state) {
                  if (state is ImageResizerError) {
                    DialogOptions().showModernErrorDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ImageSelected || state is DimensionsSet) {
                    final imageBytes = state is ImageSelected
                        ? state.imageBytes
                        : (state as DimensionsSet).imageBytes;
                    return SingleImageViewContainer(imageBytes: imageBytes);
                  }
                  return UploadImageContainer(
                    title: TNTextStrings.uploadFiles,
                    subTitle: TNTextStrings.imageResizerSubTitle,
                    onPressed: () => context.read<ImageResizerBloc>().add(SelectImage()),
                  );
                },
              ),
            ),
            const Gap(20),
            BlocBuilder<ImageResizerBloc, ImageResizerState>(
              builder: (context, state) {
                return ProcessButton(
                  text: TNTextStrings.continueText,
                  onPressed: () {
                    if (state is ImageSelected || state is DimensionsSet) {
                      context.pushNamed(AppRoutes.imageResizeSettings);
                    } else {
                      DialogOptions().showModernErrorDialog(
                        context,
                        TNTextStrings.pleaseSelectImage,
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}