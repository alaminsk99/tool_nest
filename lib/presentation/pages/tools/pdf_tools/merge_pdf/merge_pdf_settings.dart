import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

import 'merge_pdf_result.dart';

class MergePdfSettings extends StatefulWidget {
  const MergePdfSettings({super.key});
  @override
  State<MergePdfSettings> createState() => _MergePdfSettingsState();
}

class _MergePdfSettingsState extends State<MergePdfSettings> {
  double _spacing = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MergePdfBloc>();
    return Scaffold(
      appBar:  AppbarForMainSections(title: TNTextStrings.mergePdfSettings, isLeadingIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Page spacing: ${_spacing.toInt()} pts'),
            Slider(
              min: 0,
              max: 72,
              divisions: 12,
              value: _spacing,
              onChanged: (v) => setState(() => _spacing = v),
            ),
            const Spacer(),
            ProcessButton(
              onPressed: () {
                bloc.add(UpdateSettings(_spacing.toInt()));
                bloc.add(MergeRequested());

                context.pushNamed(AppRoutes.mergePdfResult);
              },
            ),
          ],
        ),
      ),
    );
  }
}
