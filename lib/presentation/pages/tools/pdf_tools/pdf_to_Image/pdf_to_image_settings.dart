import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_bloc.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_event.dart';
import 'package:tool_nest/application/blocs/pdf_tools/pdf_to_image/pdf_to_image_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_args.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class PdfToImageSettings extends StatefulWidget {
  final PdfToImageArgsModel args;
  const PdfToImageSettings({super.key, required this.args});

  @override
  State<PdfToImageSettings> createState() => _PdfToImageSettingsState();
}

class _PdfToImageSettingsState extends State<PdfToImageSettings> {
  final _formKey = GlobalKey<FormState>();
  late int _startPage;
  late int _endPage;

  @override
  void initState() {
    super.initState();
    _startPage = 1;
    _endPage = widget.args.pageCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfToImageSettings,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocConsumer<PdfToImageBloc, PdfToImageState>(
          listener: (context, state) {
            if (state is PdfConverted) {
              context.pushNamed(
                AppRoutes.pdfToImageResult,
                extra: state.results,
              );
            } else if (state is PdfError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: TNPaddingStyle.allPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildPageField(
                      label: 'Start Page',
                      initialValue: '1',
                      onSaved: (v) => _startPage = int.parse(v!),
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        if (n == null || n < 1 || n > widget.args.pageCount) {
                          return 'Enter a valid page number';
                        }
                        return null;
                      },
                    ),
                    Gap(TNSizes.spaceBetweenInputFields),
                    _buildPageField(
                      label: 'End Page',
                      initialValue: '${widget.args.pageCount}',
                      onSaved: (v) => _endPage = int.parse(v!),
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        if (n == null ||
                            n < _startPage ||
                            n > widget.args.pageCount) {
                          return 'Enter a valid end page';
                        }
                        return null;
                      },
                    ),
                    Gap(TNSizes.spaceBetweenSections),
                    ProcessButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<PdfToImageBloc>().add(
                            ConvertPdfEvent(_startPage, _endPage),
                          );
                        }
                      },
                    ),
                    if (state is PdfConverting) ...[
                      Gap(TNSizes.spaceBetweenItems),
                      const ProgressIndicatorForAll(),
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

  Widget _buildPageField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
