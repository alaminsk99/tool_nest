import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/chip/custom_margin_chip.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/margin_type_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/page_orientation_section.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/selection_of_page_size.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/bottom_sheets/Items_selection_bottom_sheets.dart';

class ImageToPdfSettings extends StatefulWidget {
  const ImageToPdfSettings({super.key});

  @override
  State<ImageToPdfSettings> createState() => _ImageToPdfSettingsState();
}

class _ImageToPdfSettingsState extends State<ImageToPdfSettings> {
  String _selectedPageSize = 'A4';
  String _selectedOrientation = 'Portrait';
  double _margin = 10.0;
  bool isCustom = false;
  double _customMargin = 10.0;

  final List<String> pageSizes = ['A4', 'Letter', 'Legal'];
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
        isLeadingIcon: false,
      ),
      body: SingleChildScrollView(
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
            OrientationSection(
              selectedOrientation: _selectedOrientation,
              onSelect: (value) => setState(() => _selectedOrientation = value),
              orientations: orientations,
            ),
            const Gap(TNSizes.spaceMD),
            MarginTypeSection(
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
            const ProcessButton(),
          ],
        ),
      ),
    );
  }
}





