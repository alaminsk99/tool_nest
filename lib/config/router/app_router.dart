
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_compressor/image_compress_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/image_preview_card.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/process_finished_for_image_to_pdf.dart';


import '../../presentation/pages/tools/image_tools/image_compressor/image_compress_page.dart';
import '../../presentation/pages/tools/image_tools/image_compressor/image_compress_settings.dart';
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.main,
  routes: [
    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => const MainPage(),
      routes: [
        GoRoute(
          path: AppRoutes.processFinishedForImgToPdfPath,
          name: AppRoutes.processFinishedForImgToPdf,
          builder: (context, state) {
            final path = state.extra as String;
            return ProcessFinishedForImageToPdf(pdfPath: path);
          },
        ),
        GoRoute(
          path: AppRoutes.imageToPdfPath,
          name: AppRoutes.imageToPdf,
          builder: (context, state) => const ImageToPdfPage(),
          routes: [
            GoRoute(
              path: AppRoutes.settingsPath,
              name: AppRoutes.settings,
              builder: (context, state) => const ImageToPdfSettings(),
            ),
            GoRoute(
              path: AppRoutes.previewPath,
              name: AppRoutes.preview,
              builder: (context, state) => const ImageToPdfPreview(),
            ),
            GoRoute(
              path: AppRoutes.resultPath,
              name: AppRoutes.result,
              builder: (context, state) {
                final pdfPath = state.extra as String;
                return ImageToPdfResultScreen(pdfPath: pdfPath);

              },
            ),


          ],
        ),
        GoRoute(
          path: AppRoutes.imageCompressorPath,
          name: AppRoutes.imageCompressor,
          builder: (context, state) => const ImageCompressPage(),
          routes: [
            GoRoute(
              path: AppRoutes.imageCompressorSettingsPath,
              name: AppRoutes.imageCompressorSettings,
              builder: (context, state) => const ImageCompressorSettings(),
            ),
            GoRoute(
              path: AppRoutes.imageCompressorResultPath,
              name: AppRoutes.imageCompressorResult,

              builder: (context, state) {
                final resultState  = state.extra as ImageCompressionSuccess;
                return ImageCompressResult(state: resultState ,);
              }
            ),
          ]

        )
      ],
    ),
  ],
);



