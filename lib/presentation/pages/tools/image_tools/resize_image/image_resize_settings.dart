import 'package:flutter/material.dart' hide ResizeImage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';


class ImageResizeSettingsPage extends StatelessWidget {
  const ImageResizeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController widthController = TextEditingController();
    final TextEditingController heightController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resize Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<ImageResizerBloc, ImageResizerState>(
        listener: (context, state) {
          if (state is ImageResizerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is DimensionsSet) {
            widthController.text = state.width.toString();
            heightController.text = state.height.toString();
          }
        },
        builder: (context, state) {
          if (state is! ImageSelected && state is! DimensionsSet) {
            context.read<ImageResizerBloc>().add(ResetState());
            return const Center(child: Text('Please select an image first'));
          }

          final imageBytes = state is ImageSelected
              ? state.imageBytes
              : (state as DimensionsSet).imageBytes;

          return Padding(
            padding: const EdgeInsets.all(TNSizes.defaultSpace),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.memory(imageBytes, fit: BoxFit.contain),
                        const Gap(TNSizes.spaceBetweenSections),
                        Form(
                          key: formKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: widthController,
                                  decoration: const InputDecoration(
                                    labelText: 'Width (px)',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter width';
                                    }
                                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                      return 'Invalid width';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Gap(TNSizes.spaceBetweenItems),
                              Expanded(
                                child: TextFormField(
                                  controller: heightController,
                                  decoration: const InputDecoration(
                                    labelText: 'Height (px)',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter height';
                                    }
                                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                      return 'Invalid height';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(TNSizes.spaceBetweenItems),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  widthController.text = '800';
                                  heightController.text = '600';
                                  _updateDimensions(context, widthController, heightController);
                                },
                                child: const Text('800x600'),
                              ),
                            ),
                            const Gap(TNSizes.spaceBetweenItems),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  widthController.text = '1024';
                                  heightController.text = '768';
                                  _updateDimensions(context, widthController, heightController);
                                },
                                child: const Text('1024x768'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(TNSizes.spaceBetweenItems),
                ProcessButton(
                  text: TNTextStrings.resizeAndPreview,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      _updateDimensions(context, widthController, heightController);
                      context.pushNamed(AppRoutes.imageResizeResult);
                      context.read<ImageResizerBloc>().add(ResizeImage());
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateDimensions(
      BuildContext context,
      TextEditingController widthController,
      TextEditingController heightController,
      ) {
    final width = int.tryParse(widthController.text) ?? 0;
    final height = int.tryParse(heightController.text) ?? 0;
    context.read<ImageResizerBloc>().add(SetDimensions(width, height));
  }
}