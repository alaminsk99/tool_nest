import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_event.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/list_tile/margin_type_section.dart';
import 'package:toolest/presentation/pages/tools/widgets/list_tile/page_orientation_section.dart';
import 'package:toolest/presentation/pages/tools/widgets/list_tile/selection_of_page_size.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/loader/progress_indicator_for_all.dart';

class ImageToPdfSettings extends StatefulWidget {
  const ImageToPdfSettings({super.key});

  @override
  State<ImageToPdfSettings> createState() => _ImageToPdfSettingsState();
}

class _ImageToPdfSettingsState extends State<ImageToPdfSettings> {
  bool isProcessingDialogShown = false;

  final List<String> pageSizes = ['Original', 'A4', 'Letter', 'Legal'];
  final List<String> orientations = ['Portrait', 'Landscape'];
  final List<double> customMarginOptions = [0, 5, 10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfSettings,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: BlocConsumer<ImageToPdfBloc, ImageToPdfState>(
        listener: (context, state) {
          if (state is PdfConversionInProgress && !isProcessingDialogShown) {
            isProcessingDialogShown = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const ProgressIndicatorForAll(),
            );
          }

          if (state is PdfConversionSuccess) {
            if (isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              isProcessingDialogShown = false;
            }
            context.pushNamed(AppRoutes.result, extra: state.pdfPath);
          }

          if (state is ImageToPdfError) {
            if (isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              isProcessingDialogShown = false;
            }
            SnackbarHelper.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final theme = Theme.of(context);
          return SafeArea(
            child: SingleChildScrollView(
              padding: TNPaddingStyle.allPaddingLG,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TNTextStrings.selectPageSize,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  const Gap(TNSizes.spaceMD),

                  PageSizeSection(
                    selectedPageSize: state.pageSize,
                    onSelect: (value) => context.read<ImageToPdfBloc>().add(
                      UpdateSettingsEvent(
                        pageSize: value,
                        orientation: state.orientation,
                        margin: state.margin,
                        isCustomMargin: state.isCustomMargin,
                      ),
                    ),
                    pageSizes: pageSizes,
                  ),

                  const Gap(TNSizes.spaceXL),
                  if (state.pageSize != 'Original')
                    OrientationSection(
                      selectedOrientation: state.orientation,
                      onSelect: (value) => context.read<ImageToPdfBloc>().add(
                        UpdateSettingsEvent(
                          pageSize: state.pageSize,
                          orientation: value,
                          margin: state.margin,
                          isCustomMargin: state.isCustomMargin,
                        ),
                      ),
                      orientations: orientations,
                    ),

                  const Gap(TNSizes.spaceXL),
                  if (state.pageSize != 'Original')
                    MarginTypeSection(
                      margin: state.margin,
                      customMargin: state.margin,
                      isCustom: state.isCustomMargin,
                      customMarginOptions: customMarginOptions,
                      chipCallbacks: {
                        for (var value in customMarginOptions)
                          value: () => context.read<ImageToPdfBloc>().add(UpdateMarginValueEvent(value))
                      },
                      onDefaultSelected: () => context.read<ImageToPdfBloc>().add(
                        ToggleMarginTypeEvent(false),
                      ),
                      onCustomSelected: () => context.read<ImageToPdfBloc>().add(
                        ToggleMarginTypeEvent(true),
                      ),
                    ),

                  const Gap(TNSizes.spaceXXL),

                  ProcessButton(
                    text: TNTextStrings.convertToPdf,
                    onPressed: () {
                      context.read<ImageToPdfBloc>().add(ConvertToPdfEvent(context: context));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}