import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/image_preview_card.dart';
import 'package:tool_nest/presentation/pages/tools/tools_pages.dart';
import 'package:tool_nest/presentation/widgets/loader/loader_screen.dart';

import 'route_paths.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.main,
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainPage(),
      routes: [
        GoRoute(
          path: 'image-to-pdf',
          name: AppRoutes.imageToPdfName,
          builder: (context, state) => const ImageToPdfPage(),
          routes: [
            GoRoute(
              path: 'settings',
              name: AppRoutes.imageToPdfSettingsName,
              builder: (context, state) => const ImageToPdfSettings(),
            ),
            GoRoute(
              path: 'preview',
              name: AppRoutes.imageToPdfPreviewName,
              builder: (context, state) => const ImageToPdfPreview(),
            ),
            GoRoute(
              path: 'loader',
              name: AppRoutes.loaderName,
              builder: (context, state) => const LoaderScreen(),
            ),
            GoRoute(
              path: 'result',
              name: AppRoutes.imageToPdfResultName,
              builder: (context, state) => const ImageToPdfResultScreen(),
            ),
          ],
        ),

      ],
    ),
  ],
);


