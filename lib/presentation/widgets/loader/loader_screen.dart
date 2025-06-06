import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({super.key, required this.title, required this.warningMessage});

  final String? title;
  final String? warningMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TNColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TNSizes.spaceLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: TNColors.primary,
                strokeWidth: 3,
              ),
              const Gap(TNSizes.spaceLG),
             if(title != null) Text(title!, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TNColors.black,),
              ),
              const Gap(TNSizes.spaceSM),
              if(warningMessage != null)Text(
                warningMessage!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TNColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
void showProcessingDialog(BuildContext context,String title, String warningMessage) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceLG),
        child: ProcessingScreen(title: title, warningMessage: warningMessage,),
      ),
    ),
  );
}
