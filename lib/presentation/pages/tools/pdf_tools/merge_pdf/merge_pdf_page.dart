import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/domain/models/pdf_tools/pdf_merge_model/pdf_file_model.dart';
import 'package:toolest/presentation/pages/tools/pdf_tools/merge_pdf/widgets/pdf_list_view.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class MergePdfPage extends StatelessWidget {
  const MergePdfPage({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MergePdfBloc>().add(const ClearFiles());
    });

    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.mergePDFs, isLeadingIcon: true),
      body: Stack(
        children: [
          /// PDF list view
          BlocBuilder<MergePdfBloc, MergePdfState>(
            builder: (context, state) {
              if (state is FilesPicked || state is SettingsUpdated) {
                final files = (state is FilesPicked ? state.files : (state as SettingsUpdated).files);
                return Padding(
                  padding: TNPaddingStyle.allPadding,
                  child: PdfListView(files: files),
                );
              }
              return const Center(child: Text('No PDF added.'));
            },
          ),

          /// Bottom bar
          Positioned(
            bottom: TNSizes.spaceMD,
            left: TNSizes.spaceMD,
            right: TNSizes.spaceMD,
            child: Row(
              children: [
                Expanded(
                  child: IconWithProcess(
                    title: TNTextStrings.pdfAdds,
                    icon: Icons.attach_file,
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                        allowMultiple: true,
                      );
                      if (result != null) {
                        final files = result.paths.map((p) => PdfFileModel(File(p!))).toList();
                        context.read<MergePdfBloc>().add(AddFiles(files));
                      }
                    },
                  ),
                ),
                Gap(TNSizes.spaceBetweenItems),
                Expanded(
                  child: ProcessButton(
                    onPressed: () => context.pushNamed(AppRoutes.mergePdfSettings),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
