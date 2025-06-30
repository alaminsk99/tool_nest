import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/application/blocs/image_tools/image_format_converter/image_format_converter_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_format_converter/image_format_converter_event.dart';
import 'package:toolest/application/blocs/image_tools/image_format_converter/image_format_converter_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class ImageFormatConverterPage extends StatelessWidget {
  const ImageFormatConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.formatConverter,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPadding,
          child: BlocConsumer<ImageFormatConverterBloc, ImageFormatConverterState>(
            listener: (context, state) {
              if (state is ImageFormatPickedState) {
                context.pushNamed(AppRoutes.imageFormatConverterSettings);
              } else if (state is ImageFormatError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: UploadContainerForItem(
                      title: TNTextStrings.uploadFiles,
                      subTitle: TNTextStrings.formatConverterSubTitle,
                      onPressed: () {
                        context.read<ImageFormatConverterBloc>().add(PickImageFormatEvent());
                      },
                    ),
                  ),
                  const Gap(TNSizes.spaceBetweenItems),
                  // ProcessButton(onPressed: () {}),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
