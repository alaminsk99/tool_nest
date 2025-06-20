import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_result.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_state.dart';
import 'package:tool_nest/presentation/widgets/loader/processing_screen.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';


class ImageResizeSettings extends StatefulWidget {
  const ImageResizeSettings({super.key});

  @override
  State<ImageResizeSettings> createState() => _ImageResizeSettingsState();
}

class _ImageResizeSettingsState extends State<ImageResizeSettings> {

  @override
  void initState() {
    super.initState();
    context.read<ImageResizeBloc>().add(ResetResizeStateEvent());
  }


  @override
  Widget build(BuildContext context) {
    bool isProcessingDialogShown = false;
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageResizeSettings,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocConsumer<ImageResizeBloc, ImageResizeState>(
          listener: (context, state) {
            if (state is ImageResizeLoading && !isProcessingDialogShown) {
              isProcessingDialogShown = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const ProcessingScreen(
                  title: TNTextStrings.resizingImage,
                  warningMessage: TNTextStrings.pleWaitWhileResizing,
                ),
              );
            }
            if (state is ImageResizeDone) {
              if (isProcessingDialogShown && Navigator.of(context).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
                isProcessingDialogShown = false;
              }
              context.pushNamed(AppRoutes.imageResizeResult, extra: {
              'imageBytes': state.resizedBytes,
              'width': state.width,
              'height': state.height,
              },);
            }
            if (state is ImageResizeError) {
              if (isProcessingDialogShown) {
                Navigator.of(context, rootNavigator: true).pop();
                isProcessingDialogShown = false;
              }

              SnackbarHelper.showError(context, state.message);
            }

          },
          builder: (context, state) {
            if (state is ImageResizeLoaded) {
              return Padding(
                padding: TNPaddingStyle.allPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TNTextStrings.imageResizer, style: Theme.of(context).textTheme.bodyLarge),
                    Gap(TNSizes.spaceMD),

                    /// Width and Height Input
                    Form(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: state.width.toString(),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: TNTextStrings.width),
                              onChanged: (value) {
                                final width = int.tryParse(value);
                                if (width != null) {
                                  context.read<ImageResizeBloc>().add(UpdateWidthEvent(width));
                                }
                              },
                            ),
                          ),
                          Gap(TNSizes.spaceBetweenInputFields),
                          Expanded(
                            child: TextFormField(
                              initialValue: state.height.toString(),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: TNTextStrings.height),
                              onChanged: (value) {
                                final height = int.tryParse(value);
                                if (height != null) {
                                  context.read<ImageResizeBloc>().add(UpdateHeightEvent(height));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Lock Aspect Ratio
                    Gap(TNSizes.spaceBetweenItems),
                    Row(
                      children: [
                        Checkbox(
                          value: state.lockAspectRatio,
                          onChanged: (val) {
                            context.read<ImageResizeBloc>().add(
                              UpdateAspectRatioLockEvent(val ?? false),
                            );
                          },
                        ),
                        Gap(TNSizes.spaceMD),
                        Text(TNTextStrings.lockAspectRatio),
                      ],
                    ),

                    Gap(TNSizes.spaceBetweenSections),

                    /// Process Button
                    ProcessButton(
                      onPressed: () {
                        context.read<ImageResizeBloc>().add(ResizeImageEvent());
                      },
                    ),
                  ],
                ),
              );
            } else if (state is ImageResizeError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: ProgressIndicatorForAll());
            }
          },
        ),
      ),
    );
  }
}
