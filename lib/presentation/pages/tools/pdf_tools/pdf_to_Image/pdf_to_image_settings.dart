// pdf_to_image_settings.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_bloc.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_event.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_args.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';

class PdfToImageSettings extends StatefulWidget {
  final PdfToImageArgsModel args;
  const PdfToImageSettings({super.key, required this.args});

  @override
  State<PdfToImageSettings> createState() => _PdfToImageSettingsState();
}

class _PdfToImageSettingsState extends State<PdfToImageSettings> {
  final _formKey = GlobalKey<FormState>();
  int _startPage = 1;
  int _endPage = 1;

  @override
  void initState() {
    super.initState();
    _endPage = widget.args.pageCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppbarForMainSections(title: TNTextStrings.pdfToImageSettings, isLeadingIcon: true),
      body: SafeArea(
        child: BlocConsumer<PdfToImageBloc, PdfToImageState>(
          listener: (ctx, state) {
            if (state is PdfConverted) {
              context.pushNamed(
                AppRoutes.pdfToImageResult,
                extra: state.results,
              );
            } else if (state is PdfError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (ctx, state) {
            final totalPages = state is PdfPicked ? state.pageCount : 1;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Start page'),
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        return n == null || n<1 ? 'Invalid' : null;
                      },
                      onSaved: (v) => _startPage = int.parse(v!),
                    ),
                    Gap(TNSizes.spaceBetweenInputFields),
                    TextFormField(
                      initialValue: '$totalPages',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'End page'),
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        return n == null || n< _startPage || n>totalPages ? 'Invalid' : null;
                      },
                      onSaved: (v) => _endPage = int.parse(v!),
                    ),
                    Gap(TNSizes.spaceBetweenSections),
                    ProcessButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<PdfToImageBloc>().add(ConvertPdfEvent(_startPage, _endPage));
                        }
                      },
                    ),
                    if (state is PdfConverting) ...[
                Gap(TNSizes.spaceBetweenItems),
                      ProgressIndicatorForAll(),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
