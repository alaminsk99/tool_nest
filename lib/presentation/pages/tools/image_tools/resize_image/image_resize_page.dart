import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/image_tools/resize_image/image_resize_settings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/single_image_view_container.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_event.dart';
import 'package:toolest/application/blocs/image_tools/image_resizer/image_resizer_state.dart';


class ImageResizePage extends StatelessWidget {
  const ImageResizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageResizeBloc(),
      child: Scaffold(
        appBar: AppbarForMainSections(
          title: TNTextStrings.imageResizer,
          isLeadingIcon: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: TNPaddingStyle.allPadding,
            child: Column(
              children: [
                /// Consumer and listener for image state
                Expanded(
                  child: BlocBuilder<ImageResizeBloc, ImageResizeState>(
                    builder: (context, state) {
                      if (state is ImageResizeLoaded) {
                        return SingleImageViewContainer(imageBytes: state.imageBytes);
                      }
                      return UploadContainerForItem(
                        title: TNTextStrings.uploadFiles,
                        subTitle: TNTextStrings.imageResizerSubTitle,
                        onPressed: () {
                          context.read<ImageResizeBloc>().add(PickImageEvent());
                        },
                      );
                    },
                  ),
                ),

                Gap(TNSizes.spaceMD),

                /// Navigate to imageResizeSetting screen only if image is picked
                BlocBuilder<ImageResizeBloc, ImageResizeState>(
                  builder: (context, state) {
                    return ProcessButton(
                      onPressed: state is ImageResizeLoaded
                          ? () {
                        context.pushNamed(
                          AppRoutes.imageResizeSettings,
                          extra: context.read<ImageResizeBloc>(),
                        );

                      }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
