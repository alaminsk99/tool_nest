import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class ImageCompressorSettings extends StatefulWidget {
  const ImageCompressorSettings({super.key});

  @override
  State<ImageCompressorSettings> createState() => _ImageCompressorSettingsState();
}

class _ImageCompressorSettingsState extends State<ImageCompressorSettings> {
  final selectedFormat = "Original";
  final selectedResolution = '70';
  final minImageQuality = 50.0;
  final maxImageQuality = 100.0;

  final List<String> imageFormat = ['Original', 'JPG', 'JPEG', 'PNG'];
  final List<String> imageResolution = ['Original', '70','50'];
  // I want this "Custom Width x Height (If advanced settings)",




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.imageCompressorSettings, isLeadingIcon: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: TNPaddingStyle.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Text For Title
              Text(TNTextStrings.compressionQuality,style: Theme.of(context).textTheme.bodyLarge,),
              /// Compression Quality Changes by Slider
              Slider(
                label: "",
                value: 0,
                onChanged: ((val){}),
                min: minImageQuality,
                max: maxImageQuality,
                activeColor: TNColors.materialPrimaryColor[900],
                inactiveColor: TNColors.materialPrimaryColor[100],
              ),

              // Output Format
              Dropdownbuttonselectionusingbottomsheets(
                  titleForBottomSheet: TNTextStrings.selectImgFormat,
                  titleOfTheSection: TNTextStrings.saveAsTitle,
                  selectedItem: selectedFormat,
                  options: imageFormat,
                  onSelect: ((val){}),
              ),

              /// Resolution (optional)
              Dropdownbuttonselectionusingbottomsheets(
                titleForBottomSheet: TNTextStrings.selectImgResolution,
                titleOfTheSection: TNTextStrings.resolution,
                selectedItem: selectedResolution,
                options: imageResolution,
                onSelect: ((val){}),
              ),
              /// Reset Settings
              TextButton(onPressed: () { }, child: Text(TNTextStrings.restButton,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
              /// Compress Now
              TwoActionButtons(title1: TNTextStrings.back, icon1: LucideIcons.chevronLeft, title2: TNTextStrings.compressNowButtonTit,)

            ],
          ),
        ),
      ),
    );
  }
}
