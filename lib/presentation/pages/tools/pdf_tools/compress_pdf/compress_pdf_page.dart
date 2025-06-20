import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tool_nest/application/blocs/pdf_tools/compress_pdf/compress_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class CompressPdfPage extends StatelessWidget {
  const CompressPdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.compressPDF,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocConsumer<CompressPdfBloc, CompressPdfState>(
          listenWhen: (previous, current) => current is CompressPdfError && current != previous,
          listener: (context, state) {
            if (state is CompressPdfError) {
              DialogOptions().showModernErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
            final bloc = context.read<CompressPdfBloc>();
            final picked = state is CompressPdfPicked ? state : null;

            return Stack(
              children: [
                Padding(
                  padding: TNPaddingStyle.allPadding,
                  child: Column(
                    children: [
                      if (picked == null)
                        UploadContainerForItem(
                          title: TNTextStrings.uploadFiles,
                          subTitle: TNTextStrings.compressPDFSubTitle,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null && result.files.single.path != null) {
                              final file = File(result.files.single.path!);
                              bloc.add(PickPdfFileEvent(file.path));
                            }
                          },
                        )
                      else
                        Expanded(
                          child: SfPdfViewer.file(picked.file),
                        ),
                    ],
                  ),
                ),

                /// Bottom Process Button
                if (picked != null)
                  Positioned(
                    bottom: TNSizes.spaceMD,
                    left: TNSizes.spaceMD,
                    right: TNSizes.spaceMD,
                    child: ProcessButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.compressPdfSettings);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
