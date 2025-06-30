import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_event.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/loader/progress_indicator_for_all.dart';

class ImageResizeSettings extends StatefulWidget {
  const ImageResizeSettings({super.key});

  @override
  State<ImageResizeSettings> createState() => _ImageResizeSettingsState();
}

class _ImageResizeSettingsState extends State<ImageResizeSettings> {
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<ImageResizeBloc>().add(ResetResizeStateEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageResizeSettings,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: BlocConsumer<ImageResizeBloc, ImageResizeState>(
          listener: (context, state) {
            if (state is ImageResizeLoading && !_isDialogShown) {
              _isDialogShown = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const ProgressIndicatorForAll(),
              );
            }

            if (state is ImageResizeDone) {
              if (_isDialogShown && Navigator.of(context).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
                _isDialogShown = false;
              }

              context.pushNamed(AppRoutes.imageResizeResult, extra: {
                'imageBytes': state.resizedBytes,
                'width': state.width,
                'height': state.height,
              });
            }

            if (state is ImageResizeError) {
              if (_isDialogShown) {
                Navigator.of(context, rootNavigator: true).pop();
                _isDialogShown = false;
              }
              SnackbarHelper.showError(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ImageResizeLoaded) {
              return Padding(
                padding: TNPaddingStyle.allPaddingLG,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      TNTextStrings.imageResizer,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TNColors.textPrimary,
                      ),
                    ),
                    const Gap(TNSizes.spaceSM),

                    /// Subtitle
                    Text(
                      TNTextStrings.inputDesiredDimensions,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: TNColors.textSecondary,
                      ),
                    ),
                    const Gap(TNSizes.spaceXL),

                    /// Dimension Input
                    Row(
                      children: [
                        Expanded(
                          child: _buildDimensionField(
                            context,
                            label: TNTextStrings.width,
                            initialValue: state.width.toString(),
                            onChanged: (val) {
                              final width = int.tryParse(val);
                              if (width != null) {
                                context.read<ImageResizeBloc>().add(UpdateWidthEvent(width));
                              }
                            },
                          ),
                        ),
                        const Gap(TNSizes.spaceBetweenInputFields),
                        Expanded(
                          child: _buildDimensionField(
                            context,
                            label: TNTextStrings.height,
                            initialValue: state.height.toString(),
                            onChanged: (val) {
                              final height = int.tryParse(val);
                              if (height != null) {
                                context.read<ImageResizeBloc>().add(UpdateHeightEvent(height));
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const Gap(TNSizes.spaceBetweenItems),

                    /// Lock Aspect Ratio
                    Row(
                      children: [
                        Checkbox(
                          value: state.lockAspectRatio,
                          onChanged: (val) {
                            context.read<ImageResizeBloc>().add(
                              UpdateAspectRatioLockEvent(val ?? false),
                            );
                          },
                          activeColor: TNColors.primary,
                        ),
                        const Gap(TNSizes.spaceSM),
                        Text(
                          TNTextStrings.lockAspectRatio,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: TNColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// Process Button
                    ProcessButton(
                      onPressed: () {
                        context.read<ImageResizeBloc>().add(ResizeImageEvent(context: context));
                      },
                    ),
                  ],
                ),
              );
            } else if (state is ImageResizeError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: ProgressIndicatorForAll());
            }
          },
        ),
      ),
    );
  }

  Widget _buildDimensionField(
      BuildContext context, {
        required String label,
        required String initialValue,
        required ValueChanged<String> onChanged,
      }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: TNColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: TNColors.textSecondary),
        filled: true,
        fillColor: TNColors.buttonSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          borderSide: const BorderSide(color: TNColors.borderPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          borderSide: const BorderSide(color: TNColors.primary),
        ),
      ),
    );
  }
}
