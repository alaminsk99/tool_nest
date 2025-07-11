

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/app.dart';
import 'package:toolest/application/blocs/image_tools/image_compressor/image_compressor_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_compressor/image_compressor_event.dart';
import 'package:toolest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/single_image_view_container.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';
import 'package:toolest/presentation/widgets/grid_views/image_grid_view.dart';

class ImageCompressPage extends StatefulWidget {
  const ImageCompressPage({super.key});

  @override
  State<ImageCompressPage> createState() => _ImageCompressPageState();
}

class _ImageCompressPageState extends State<ImageCompressPage> {
  late ImageCompressorBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImageCompressorBloc>();
    bloc.add(ClearSelectedImagesForImageCompressor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.imageCompressor, isLeadingIcon: true),
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPadding,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<ImageCompressorBloc, ImageCompressorState>(
                  listener: (context, state) {
                    if (state is ImageCompressorError) {
                      DialogOptions().showModernErrorDialog(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state.selectedImage != null) {
                      return SingleImageViewContainer(
                        imagePath: state.selectedImage!.path,
                      );
                    }
                    return UploadContainerForItem(
                      title: TNTextStrings.selectImageToCom,
                      subTitle: TNTextStrings.compressionPageSubTitle,
                      onPressed: () =>bloc.add(SelectImageForCompression()),
                    );
                  },
                ),
              ),
              const Gap(TNSizes.spaceMD),
              BlocBuilder<ImageCompressorBloc, ImageCompressorState>(
                builder: (context, state) {
                  return ProcessButton(
                    text: TNTextStrings.continueText,
                    onPressed: () {
                      if (state.selectedImage != null) {
                        context.pushNamed(AppRoutes.imageCompressorSettings);
                      } else {
                        DialogOptions().showModernErrorDialog(
                          context,
                          TNTextStrings.pleSelLeaImg,
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}