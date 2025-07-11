import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart' hide PdfDocument;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toolest/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/domain/models/pdf_tools/split_pdf_model/pdf_split_file_model.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class SplitPdfPage extends StatelessWidget {
  const SplitPdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplitPdfBloc>().add(const ClearSplitFile());
    });
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.splitPDF,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocBuilder<SplitPdfBloc, SplitPdfState>(

          builder: (context, state) {
            final bloc = context.read<SplitPdfBloc>();
            final PdfSplitFileModel? fileModel =
            state is FileSelected ? state.file : null;

            return Stack(
              children: [
                Padding(
                  padding: TNPaddingStyle.allPadding,
                  child: Column(
                    children: [
                      if (fileModel == null)
                        UploadContainerForItem(
                          title: TNTextStrings.uploadFiles,
                          subTitle: TNTextStrings.splitPDFSubTitle,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null && result.files.single.path != null) {
                              final path = result.files.single.path!;
                              final file = File(path);
                              final bytes = await file.readAsBytes();
                              final document = PdfDocument(inputBytes: bytes);
                              final pageCount = document.pages.count;
                              document.dispose();

                              final model = PdfSplitFileModel(
                                file: file,
                                totalPages: pageCount,
                              );
                              bloc.add(PickSplitFile(model));
                            }
                          },
                        )
                      else
                        Expanded(
                          child: SfPdfViewer.file(fileModel.file),
                        ),
                    ],
                  ),
                ),

                /// Bottom process button
                if (fileModel != null)
                  Positioned(
                    bottom: TNSizes.spaceMD,
                    left: TNSizes.spaceMD,
                    right: TNSizes.spaceMD,
                    child: ProcessButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.splitPdfSettings);
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
