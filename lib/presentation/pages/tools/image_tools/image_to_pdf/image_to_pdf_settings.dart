import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_to_pdf/image_to_pdf_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/margin_type_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/page_orientation_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/selection_of_page_size.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/loader_screen.dart';

class ImageToPdfSettings extends StatefulWidget {
  const ImageToPdfSettings({super.key});

  @override
  State<ImageToPdfSettings> createState() => _ImageToPdfSettingsState();
}

class _ImageToPdfSettingsState extends State<ImageToPdfSettings> {
  String _selectedPageSize = 'Original';
  //String _selectedPageSize = 'A4';
  String _selectedOrientation = 'Portrait';
  bool _isProcessingDialogShown = false;
  double _margin = 10.0;
  bool isCustom = false;
  double _customMargin = 10.0;

  final List<String> pageSizes = ['Original', 'A4', 'Letter', 'Legal'];
  final List<String> orientations = ['Portrait', 'Landscape'];
  final List<double> customMarginOptions = [0, 5, 10, 20, 30, 40, 50];
  late Map<double, VoidCallback> _chipCallbacks;

  @override
  void initState() {
    super.initState();
    _initializeChipCallbacks();
  }

  void _initializeChipCallbacks() {
    _chipCallbacks = {
      for (final value in customMarginOptions)
        value: () {
          setState(() {
            _customMargin = value;
            _margin = value;
          });
        }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfSettings,
        isLeadingIcon: true,
      ),
      body: BlocConsumer<ImageToPdfBloc, ImageToPdfState>(
        listener: (context, state) {
          if (state is PdfConversionInProgress && !_isProcessingDialogShown) {
            _isProcessingDialogShown = true;

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
            if (_isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              _isProcessingDialogShown = false;
            }
            context.pushNamed(AppRoutes.result, extra: state.pdfPath);
          }

          if (state is ImageToPdfError) {
            if (_isProcessingDialogShown) {
              Navigator.of(context, rootNavigator: true).pop();
              _isProcessingDialogShown = false;
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
                  selectedPageSize: _selectedPageSize,
                  onSelect: (value) => setState(() => _selectedPageSize = value),
                  pageSizes: pageSizes,
                ),
                const Gap(TNSizes.spaceMD),
                if (_selectedPageSize != 'Original') OrientationSection(
                  selectedOrientation: _selectedOrientation,
                  onSelect: (value) => setState(() => _selectedOrientation = value),
                  orientations: orientations,
                ),
                const Gap(TNSizes.spaceMD),
                if (_selectedPageSize != 'Original') MarginTypeSection(
                  margin: _margin,
                  isCustom: isCustom,
                  customMargin: _customMargin,
                  customMarginOptions: customMarginOptions,
                  chipCallbacks: _chipCallbacks,
                  onDefaultSelected: () {
                    setState(() {
                      isCustom = false;
                      _margin = 10.0;
                    });
                  },
                  onCustomSelected: () {
                    setState(() {
                      isCustom = true;
                      _margin = _customMargin;
                    });
                  },
                ),
                const Gap(TNSizes.spaceXL),

                /// Go to Result Screen Show there pdf
                ProcessButton(onPressed: (){
                  final bloc = context.read<ImageToPdfBloc>();
                  bloc.add(UpdateSettingsEvent(
                    _selectedPageSize,
                    _selectedPageSize == 'Original' ? 'Portrait' : _selectedOrientation,
                    _selectedPageSize == 'Original' ? 0.0 : _margin,
                  ));
                  bloc.add(ConvertToPdfEvent());
                },),



              ],
            ),
          );
        },
      ),
    );
  }
}
