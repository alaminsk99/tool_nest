import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pdfx/pdfx.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/loader/progress_indicator_for_all.dart';

class RecentFilesScroll extends StatelessWidget {
  const RecentFilesScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final files = state.recentFiles.where((file) => file.tab == state.activeTab).toList();

          return SizedBox(
            height: 160,
            child: files.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: files.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => RecentFileCard(file: files[index]),
            ),
          );
        }
        return const SizedBox(height: 160);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No files found',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class RecentFileCard extends StatelessWidget {
  final RecentFileModel file;
  static final Map<String, Uint8List> _thumbnailCache = {};

  const RecentFileCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final exists = File(file.path).existsSync();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context,constraints) {
            final height = 130.0;
            final aspectRatio = _getAspectRatio(file); // You will define this function
            final width = height * aspectRatio;
            return Container(
              width: width,
              height: height,
              padding: TNPaddingStyle.allPaddingXS,
              decoration: BoxDecoration(
                color: TNColors.white,
                borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
                border: Border.all(color: TNColors.white.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: _buildFilePreview(context, exists),
            );
          }
        ),
        const Gap(TNSizes.spaceSM),
        _buildFileName(context),
        if (file.status == FileStatus.processing) _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildFilePreview(BuildContext context, bool exists) {
    const double previewHeight = 130.0;
    final aspectRatio = _getAspectRatio(file);
    final width = previewHeight * aspectRatio;



    if (!exists) {
      return Center(child: Icon(LucideIcons.fileWarning, color: Colors.red));
    }

    switch (file.fileType) {
      case RecentFileType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          child: Image.file(File(file.path), fit: BoxFit.cover),
        );

      case RecentFileType.pdf:
        if (_thumbnailCache.containsKey(file.path)) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
            child: Image.memory(_thumbnailCache[file.path]!, fit: BoxFit.cover),
          );
        }

        return FutureBuilder<PdfDocument>(
          future: PdfDocument.openFile(file.path),
          builder: (context, docSnapshot) {
            if (docSnapshot.connectionState != ConnectionState.done || docSnapshot.hasError || docSnapshot.data == null) {
              return Center(child: Icon(LucideIcons.fileWarning, color: Colors.red));
            }

            final document = docSnapshot.data!;
            return FutureBuilder<PdfPageImage>(
              future: document.getPage(1).then((page) async {
                final image = await page.render(
                  width: width.toDouble(),
                  height: previewHeight.toDouble(),
                  format: PdfPageImageFormat.png,
                );
                if (image == null) throw Exception("Page render failed");
                _thumbnailCache[file.path] = image.bytes;
                return image;
              }),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState != ConnectionState.done) {
                  return const Center(child: ProgressIndicatorForAll());
                }

                if (imageSnapshot.hasError || imageSnapshot.data == null) {
                  return Center(child: Icon(LucideIcons.fileWarning, color: Colors.red));
                }

                final pageImage = imageSnapshot.data!;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
                  child: Image.memory(pageImage.bytes, fit: BoxFit.cover),
                );
              },
            );
          },
        );
    }
  }

  Widget _buildFileName(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Text(
        file.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: file.status == FileStatus.processing ? Colors.grey : TNColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
      child: LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(TNColors.primary),
      ),
    );
  }
  double _getAspectRatio(RecentFileModel file) {
    // If the actual aspectRatio is available (e.g. from PdfService), use it
    if (file.aspectRatio != null && file.aspectRatio! > 0) {
      return file.aspectRatio!;
    }

    // Fallback estimates based on file type
    if (file.fileType == RecentFileType.image) {
      return 3 / 4; // Common portrait photo size
    } else if (file.fileType == RecentFileType.pdf) {
      return 8.5 / 11; // Standard A4 aspect ratio
    }

    // Default fallback ratio
    return 1.0;
  }


}
