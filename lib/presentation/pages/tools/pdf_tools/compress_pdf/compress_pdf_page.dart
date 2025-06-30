import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toolest/application/blocs/pdf_tools/compress_pdf/compress_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';

class CompressPdfPage extends StatefulWidget {
  const CompressPdfPage({super.key});

  @override
  State<CompressPdfPage> createState() => _CompressPdfPageState();
}

class _CompressPdfPageState extends State<CompressPdfPage> with RouteAware {
  late CompressPdfBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<CompressPdfBloc>();

    /// Automatically clear any previously picked file on entering the page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(ClearPickedPdfEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.compressPDF,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocConsumer<CompressPdfBloc, CompressPdfState>(
          listenWhen: (previous, current) =>
          current is CompressPdfError && current != previous,
          listener: (context, state) {
            if (state is CompressPdfError) {
              DialogOptions().showModernErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
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
                            if (result != null &&
                                result.files.single.path != null) {
                              final file = File(result.files.single.path!);
                              bloc.add(PickPdfFileEvent(file.path));
                            }
                          },
                        )
                      else
                        Expanded(child: SfPdfViewer.file(picked.file)),
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
                      onPressed: () async {
                        await context.pushNamed(AppRoutes.compressPdfSettings);
                        bloc.add(ClearPickedPdfEvent()); // Also clear after coming back
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
