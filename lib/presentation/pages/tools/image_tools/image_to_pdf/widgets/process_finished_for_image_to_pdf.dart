import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/presentation/widgets/card/process_finished_card.dart';


class ProcessFinishedForImageToPdf extends StatelessWidget {
  const ProcessFinishedForImageToPdf({super.key, this.pdfPath});
  final String? pdfPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProcessFinishedCard(onPressed:() => context.go(AppRoutes.main),
          path: pdfPath,
        ),
      ),
    );
  }
}
