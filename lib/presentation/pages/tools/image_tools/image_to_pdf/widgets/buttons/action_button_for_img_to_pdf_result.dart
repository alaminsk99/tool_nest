import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:tool_nest/config/router/route_paths.dart';

import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/permission/permissions.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_filled_button.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';

class ActionButtonForImgToPdfResult extends StatelessWidget {
  final String pdfPath;

  const ActionButtonForImgToPdfResult({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoActionButtons(
          title1: TNTextStrings.open,
          icon1: LucideIcons.externalLink,
          title2: TNTextStrings.save,
          icon2: LucideIcons.save,
          onPressed1: () async => await FileServices().openFile(context, pdfPath),
          onPressed2: () => _savePdf(context),
        ),
        const Gap(TNSizes.spaceSM),
        IconWithFilledButton(
          icon: LucideIcons.share2,
          title: TNTextStrings.share,
          onPressed: () async => await FileServices().shareFile(context, pdfPath),
        ),
      ],
    );
  }


  void _savePdf(BuildContext context) async {

    try {
      final hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        SnackbarHelper.showError(context, TNTextStrings.storagePermissionDenied);
        return;
      }

      final path = await FileServices().saveToDownloads(pdfPath);
      if (path != null) {
        // Show success snackbar
        SnackbarHelper.showSuccess(
          context,
          TNTextStrings.savedToDownloads,
        );

        // Navigate after short delay (optional UX touch)
        Future.delayed(const Duration(seconds: 1), () {
          context.pushNamed(
            AppRoutes.processFinishedForImgToPdf,
            extra: path,
          );
        });
      } else {
        SnackbarHelper.showError(context, TNTextStrings.failToSaveFile);
      }
    } catch (e) {
      SnackbarHelper.showError(
        context,
        '${TNTextStrings.failToSaveFile}',
      );
    }
  }



}
