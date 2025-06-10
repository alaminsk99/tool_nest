
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/core/utils/permission/permissions.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';

class ActionButtonForShareAndDownload extends StatelessWidget {
  const ActionButtonForShareAndDownload({super.key, required this.filePath});
  final String filePath;
  @override
  Widget build(BuildContext context) {
    return TwoActionButtons(
        title1: TNTextStrings.share,
        icon1: LucideIcons.share2,
        title2: TNTextStrings.save,
        icon2: LucideIcons.fileDown,
        onPressed2: ()async => _savePdf(context,),
        onPressed1: ()async => await FileServices().openFile(context, filePath),
    );
  }

  void _savePdf(BuildContext context) async {

    try {
      final hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        SnackbarHelper.showError(context, TNTextStrings.storagePermissionDenied);
        return;
      }

      final path = await FileServices().saveToDownloads(filePath);
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
