import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/presentation/widgets/card/process_finished_card.dart';


class ProcessFinishedForAllTools extends StatelessWidget {
  const ProcessFinishedForAllTools({super.key, this.pdfPath});
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
