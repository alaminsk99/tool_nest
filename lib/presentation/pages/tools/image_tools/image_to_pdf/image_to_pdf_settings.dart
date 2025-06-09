import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_state.dart';
import 'package:tool_nest/config/router/app_router.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/margin_type_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/page_orientation_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/selection_of_page_size.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/processing_screen.dart';

class ImageToPdfSettings extends StatelessWidget {
  const ImageToPdfSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> pageSizes = ['Original', 'A4', 'Letter', 'Legal'];
    final List<String> orientations = ['Portrait', 'Landscape'];
    final List<double> customMarginOptions = [0, 5, 10, 20, 30, 40, 50];
    bool  isProcessingDialogShown = false;

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfSettings,
        isLeadingIcon: true,
      ),
      body: BlocConsumer<ImageToPdfBloc, ImageToPdfState>(
        listener: (context, state) {
          // Processing dialog logic remains the same as before
          if (state is PdfConversionInProgress && !isProcessingDialogShown) {
            isProcessingDialogShown = true;

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const ProcessingScreen(
                title: TNTextStrings.generatedPDF,
                warningMessage: TNTextStrings.pleaseWaitWhileProcessing,
              ),
            );
          }
          if (state is PdfConversionSuccess) {
            if (isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              isProcessingDialogShown = false;
            }
            context.pushNamed(AppRoutes.result, extra: state.pdfPath);
          }
          // Error handling logic remains the same
          if (state is ImageToPdfError) {
            if (isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              isProcessingDialogShown = false;
            }

            SnackbarHelper.showError(context, state.message);

          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(TNSizes.spaceMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Gap(TNSizes.spaceMD),
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
                const Gap(TNSizes.spaceMD),
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

                const Gap(TNSizes.spaceXL),
                ProcessButton(
                  onPressed: () async{
                     context.read<ImageToPdfBloc>().add(ConvertToPdfEvent());
                    },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
