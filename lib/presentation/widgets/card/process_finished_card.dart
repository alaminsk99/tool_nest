import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';

class ProcessFinishedCard extends StatefulWidget {
  const ProcessFinishedCard({super.key, this.onPressed, this.path});
  final VoidCallback? onPressed;
  final String? path;

  @override
  State<ProcessFinishedCard> createState() => _ProcessFinishedCardState();
}

class _ProcessFinishedCardState extends State<ProcessFinishedCard> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TNSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  LucideIcons.circleCheck,
                  color: Colors.green,
                  size: 100,
                ),
              ),
              const SizedBox(height: TNSizes.spaceLG),
              Text(
                TNTextStrings.processFinished,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gap(TNSizes.spaceXS),

              if(widget.path != 'null')Text(
                'Path: ${widget.path}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TNSizes.spaceXL),

              ProcessButton(text: TNTextStrings.useAnotherTool,onPressed: widget.onPressed,),
              SizedBox.shrink(),
            ],
          ),
        ),
    );
  }
}
