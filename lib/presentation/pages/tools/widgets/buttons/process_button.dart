
import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class ProcessButton extends StatelessWidget {
  const ProcessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement image-to-pdf logic
        },
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.titleSmall,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: const Text(TNTextStrings.processFile),
      ),
    );
  }
}