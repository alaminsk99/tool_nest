import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:toolest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_bloc.dart';
import 'package:toolest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_event.dart';
import 'package:toolest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_args.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class PdfToImagePage extends StatelessWidget {
  const PdfToImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfToImage,
        isLeadingIcon: true,
      ),
      body: BlocConsumer<PdfToImageBloc, PdfToImageState>(
        listener: (ctx, state) {
          if (state is PdfPicked) {
            final args = PdfToImageArgsModel(
              pdfPath: state.pdfPath,
              pageCount: state.pageCount,
            );
            context.pushNamed(AppRoutes.pdfToImageSettings, extra: args);
          } else if (state is PdfError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (ctx, state) {
          return Padding(
            padding: TNPaddingStyle.allPadding,
            child: Column(
              children: [
                Expanded(
                  child: UploadContainerForItem(
                    title: TNTextStrings.uploadFiles,
                    subTitle: TNTextStrings.pdfToImageSubTitle,
                    onPressed: () {
                      // Reset previous PDF selection before picking a new one
                      context.read<PdfToImageBloc>().add(ResetPdfToImageEvent());
                      context.read<PdfToImageBloc>().add(PickPdfEvent());
                    },
                  ),
                ),
                Gap(TNSizes.spaceBetweenItems),
                ProcessButton(
                  onPressed: state is PdfPicked
                      ? () {
                    final args = PdfToImageArgsModel(
                      pdfPath: state.pdfPath,
                      pageCount: state.pageCount,
                    );
                    context.pushNamed(AppRoutes.pdfToImageSettings, extra: args);
                  }
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
