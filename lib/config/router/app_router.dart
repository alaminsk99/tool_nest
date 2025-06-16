
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_compressor/image_compress_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_format_convert/image_format_converter_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/image_preview_card.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/process_finished_for_image_to_pdf.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_settings.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/compress_pdf/compress_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/merge_pdf/merge_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/pdf_to_Image/pdf_to_image_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/split_pdf/split_pdf_page.dart';


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

        ),
        GoRoute(
            path: AppRoutes.imageResizePath,
            name: AppRoutes.imageResize,
            builder: (context, state) => const ImageResizePage(),
            routes: [
              GoRoute(
                path: AppRoutes.imageResizeSettingsPath,
                name: AppRoutes.imageResizeSettings,
                pageBuilder: (context, state) {
                  final bloc = state.extra as ImageResizeBloc;
                  return MaterialPage(
                    child: BlocProvider.value(
                      value: bloc,
                      child: const ImageResizeSettings(),
                    ),
                  );
                },
              ),
              GoRoute(
                  path: AppRoutes.imageResizeResultPath,
                  name: AppRoutes.imageResizeResult,

                  builder: (context, state) {
                    final imageBytes = state.extra as Map<String, dynamic>;
                    return ImageResizeResult(
                      imageBytes: imageBytes['imageBytes'] as Uint8List,
                      width: imageBytes['width'] as int,
                      height: imageBytes['height'] as int,
                    );
                  }
              ),
            ]

        ),
        GoRoute(
          path: AppRoutes.imageFormatConverterPath,
          name: AppRoutes.imageFormatConverter,
          builder: (context, state) => const ImageFormatConverterPage(),
          routes: [

          ],

        ),
        GoRoute(
          path: AppRoutes.pdfToImagePath,
          name: AppRoutes.pdfToImage,
          builder: (context, state) => const PdfToImagePage(),
          routes: [

          ],

        ),
        GoRoute(
          path: AppRoutes.compressPdfPath,
          name: AppRoutes.compressPdf,
          builder: (context, state) => CompressPdfPage(),
          routes: [

          ],

        ),
        GoRoute(
          path: AppRoutes.mergePdfPath,
          name: AppRoutes.mergePdf,
          builder: (context, state) => const MergePdfPage(),
          routes: [

          ],

        ),
        GoRoute(
          path: AppRoutes.splitPdfPath,
          name: AppRoutes.splitPdf,
          builder: (context, state) => const SplitPdfPage(),
          routes: [

          ],

        ),
      ],
    ),
  ],
);



