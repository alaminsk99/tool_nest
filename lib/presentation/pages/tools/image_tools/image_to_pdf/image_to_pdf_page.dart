import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_event.dart';
import 'package:toolest/application/blocs/image_tools/image_to_pdf/image_to_pdf_state.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';
import 'package:toolest/presentation/widgets/grid_views/image_grid_view.dart';
import '../../image_tools/image_to_pdf/image_to_pdf_settings.dart';
import '../../widgets/buttons/process_button.dart';
import '../../widgets/container/upload_image_container.dart';

class ImageToPdfPage extends StatefulWidget {
  const ImageToPdfPage({super.key});

  @override
  State<ImageToPdfPage> createState() => _ImageToPdfPageState();
}

class _ImageToPdfPageState extends State<ImageToPdfPage> {
  late ImageToPdfBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImageToPdfBloc>();
    bloc.add(ClearSelectedImagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageToPDF,
        isLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceMD),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ImageToPdfBloc, ImageToPdfState>(
                listener: (context, state) {
                  if (state is ImageToPdfError) {
                    DialogOptions().showModernErrorDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ImageSelectionSuccess && state.selectedImages.isNotEmpty) {
                    return ImageGridView(imagePaths: state.selectedImages.map((file) => file.path).toList());
                  }
                  return UploadContainerForItem(
                    title: TNTextStrings.uploadFiles,
                    subTitle: TNTextStrings.dragAndDrop,
                    onPressed: () => bloc.add(SelectImagesEvent()),
                  );
                },
              ),
            ),
            const Gap(TNSizes.spaceMD),
            BlocBuilder<ImageToPdfBloc, ImageToPdfState>(
              builder: (context, state) {
                return ProcessButton(
                  onPressed: () {
                    if (state is ImageSelectionSuccess && state.selectedImages.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ImageToPdfSettings()),
                      );
                    } else {
                      DialogOptions().showModernErrorDialog(context, TNTextStrings.pleSelLeaImg);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

