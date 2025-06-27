import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/api_constants.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/domain/models/common/webview_model.dart';
import 'package:tool_nest/presentation/pages/profile/widgets/login_card.dart';
import 'package:tool_nest/presentation/pages/profile/widgets/webview_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            LoginCard(onTap: (){},),
            Divider(),
            _tile(
              icon: LucideIcons.fileText,
              title: TNTextStrings.termsConditions,
              onTap: () {
               context.goNamed(AppRoutes.webViews,
                 extra: WebViewModel(
                   title: TNTextStrings.termsConditions,
                   url: ApiConstants.termsAndConditions,
                 ), );
              },
            ),
            _tile(
              icon: LucideIcons.lock,
              title:TNTextStrings.privacyPolicy,
              onTap: () {
                context.goNamed(
                    AppRoutes.webViews,
                    extra: WebViewModel(
                    url: ApiConstants.privacyPolicy,
                    title: TNTextStrings.privacyPolicy,
                    ),
                );
              }
            ),
            _tile(
              icon: LucideIcons.info,
              title: TNTextStrings.aboutUS,
              onTap: () {
                context.goNamed(
                  AppRoutes.webViews,
                  extra: WebViewModel(
                    url: ApiConstants.aboutUs,
                    title: TNTextStrings.aboutUS,
                  ),
                );
              },
            ),
            _tile(
              icon: LucideIcons.sparkles,
              title: TNTextStrings.credits,
              onTap: () {
                context.goNamed(
                  AppRoutes.webViews,
                  extra: WebViewModel(
                    url: ApiConstants.credits,
                    title: TNTextStrings.credits
                  ),
                );
              },
            ),
            _tile(
              icon: LucideIcons.badgeHelp,
              title: TNTextStrings.helpContact,
              onTap: () {
                context.goNamed(
                  AppRoutes.webViews,
                  extra: WebViewModel(
                    url: ApiConstants.helpContact,
                    title: TNTextStrings.helpContact,
                  ),
                );
              },
            ),
            _tile(
              icon: LucideIcons.share2,
              title: TNTextStrings.shareApp,
              onTap: () {},
            ),

            const Gap(40),
            Center(
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  final version = snapshot.data?.version ?? '...';
                  final buildNumber = snapshot.data?.buildNumber ?? '';
                  return Column(
                    children: [
                      const Text(
                        TNTextStrings.appName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("$version ($buildNumber)", style: const TextStyle(color: Colors.grey)),
                    ],
                  );
                },
              ),

            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }



  Widget _tile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }




}
