
import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/text_strings.dart';

class ProcessButton extends StatelessWidget {
  const ProcessButton({
    super.key, this.onPressed, this.text=TNTextStrings.processFile,
  });
 final VoidCallback? onPressed;
 final String? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.titleSmall),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(TNColors.transparent),
          backgroundColor: WidgetStateProperty.all(TNColors.primary),
          foregroundColor: WidgetStateProperty.all(TNColors.black),
        ),
        child:  Text(text!),
      ),
    );
  }
}