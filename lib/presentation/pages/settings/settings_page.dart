import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/api_constants.dart';
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
              title: "Terms & Conditions",
              onTap: () {
               context.goNamed(AppRoutes.webViews,
                 extra: WebViewModel(
                   title: 'Terms & Conditions',
                   url: ApiConstants.termsAndConditions,
                 ), );
              },
            ),
            _tile(
              icon: LucideIcons.lock,
              title: "Privacy Policy",
              onTap: () {},
            ),
            _tile(
              icon: LucideIcons.info,
              title: "About us",
              onTap: () {},
            ),
            _tile(
              icon: LucideIcons.sparkles,
              title: "Credits",
              onTap: () {},
            ),
            _tile(
              icon: LucideIcons.badgeHelp,
              title: "Help / Contact",
              onTap: () {},
            ),
            _tile(
              icon: LucideIcons.share2,
              title: "Share App",
              onTap: () {},
            ),

            const Gap(40),
            Center(
              child: Column(
                children: const [
                  Text("Tool Nest", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Version 3.11.1", style: TextStyle(color: Colors.grey)),
                ],
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
