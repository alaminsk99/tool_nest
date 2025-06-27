
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/home/home_page_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'package:tool_nest/domain/models/image_tools/image_format_converter_model.dart';
import 'package:tool_nest/domain/models/pdf_tools/compress_pdf_model/compress_pdf_model.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_args.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_result_model.dart';
import 'package:tool_nest/presentation/pages/home/home_page.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';
import 'package:tool_nest/presentation/pages/profile/profile_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_compressor/image_compress_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_format_convert/image_format_converter_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_format_convert/image_format_converter_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_format_convert/image_format_converter_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/image_preview_card.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/process_finished_for_image_to_pdf.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/resize_image/image_resize_settings.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/compress_pdf/compress_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/compress_pdf/compress_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/compress_pdf/compress_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/merge_pdf/merge_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/merge_pdf/merge_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/merge_pdf/merge_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/pdf_to_Image/pdf_to_image_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/pdf_to_Image/pdf_to_image_result.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/pdf_to_Image/pdf_to_image_settings.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/split_pdf/split_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/split_pdf/split_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/pdf_tools/split_pdf/split_pdf_settings.dart';


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
        // Home
        GoRoute(
          path: AppRoutes.homePath,
          name: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        // Image Tools
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
            GoRoute(
              path: AppRoutes.imageFormatConverterSettingsPath,
              name: AppRoutes.imageFormatConverterSettings,
              builder: (context, state) => const ImageFormatConverterSettings(),
            ),
            GoRoute(
                path: AppRoutes.imageFormatConverterResultPath,
                name: AppRoutes.imageFormatConverterResult,

                builder: (context, state) {
                  final data = state.extra as ImageFormatConverterResultDataModel;
                  return ImageFormatConverterResult(
                    convertedBytes: data.convertedBytes,
                    format: data.format,
                  );
                }
            ),
          ],

        ),
        // Pdf Tools
        GoRoute(
          path: AppRoutes.pdfToImagePath,
          name: AppRoutes.pdfToImage,
          builder: (context, state) => const PdfToImagePage(),
          routes: [
            GoRoute(
              path: AppRoutes.pdfToImageSettingsPath,
              name: AppRoutes.pdfToImageSettings,
              builder: (context, state) {
               final args = state.extra as PdfToImageArgsModel;
                return PdfToImageSettings(args: args);
              },
            ),
            GoRoute(
              path: AppRoutes.pdfToImageResultPath,
              name: AppRoutes.pdfToImageResult,
              builder: (context, state) {
                final results = state.extra as List<PdfToImageResultModel>;
                return PdfToImageResult(results: results);},
            ),
          ],

        ),
        GoRoute(
          path: AppRoutes.compressPdfPath,
          name: AppRoutes.compressPdf,
          builder: (context, state) => CompressPdfPage(),
          routes: [
            GoRoute(
              path: AppRoutes.compressPdfSettingsPath,
              name: AppRoutes.compressPdfSettings,
              builder: (context, state) {

                return CompressPdfSettings();
              },
            ),
            GoRoute(
              path: AppRoutes.compressPdfResultPath,
              name: AppRoutes.compressPdfResult,
              builder: (context, state) {
                final model = state.extra as CompressedPdfModel;
                return CompressPdfResult(compressedPdf: model);
              },
            ),

          ],

        ),
        GoRoute(
          path: AppRoutes.mergePdfPath,
          name: AppRoutes.mergePdf,
          builder: (context, state) => const MergePdfPage(),
          routes: [
            GoRoute(
              path: AppRoutes.mergePdfSettingsPath,
              name: AppRoutes.mergePdfSettings,
              builder: (context, state) {

                return MergePdfSettings();
              },
            ),
            GoRoute(
              path: AppRoutes.mergePdfResultPath,
              name: AppRoutes.mergePdfResult,
              builder: (context, state) {

                return MergePdfResult();
                },
            ),
          ],

        ),
        GoRoute(
          path: AppRoutes.splitPdfPath,
          name: AppRoutes.splitPdf,
          builder: (context, state) => const SplitPdfPage(),
          routes: [
            GoRoute(
              path: AppRoutes.splitPdfSettingsPath,
              name: AppRoutes.splitPdfSettings  ,
              builder: (context, state) {

                return SplitPdfSettings();
              },
            ),
            GoRoute(
              path: AppRoutes.splitPdfResultPath,
              name: AppRoutes.splitPdfResult,
              builder: (context, state) {

                return SplitPdfResult();
              },
            ),

          ],

        ),
        // Profile

        GoRoute(
          path: AppRoutes.profilePath,
          name: AppRoutes.profile,
          builder: (context, state) => ProfilePage(),
        ),

      ],
    ),
  ],
);



