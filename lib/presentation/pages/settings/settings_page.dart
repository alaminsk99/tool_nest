
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tool_nest/application/blocs/auth/auth_bloc.dart';
import 'package:tool_nest/application/blocs/auth/auth_event.dart';
import 'package:tool_nest/application/blocs/auth/auth_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/api_constants.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/domain/models/common/webview_model.dart';
import 'package:tool_nest/presentation/pages/profile/auth/login/login_page.dart';
import 'package:tool_nest/presentation/pages/profile/widgets/login_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isAuthenticated = state is Authenticated;
            final user = isAuthenticated ? (state as Authenticated).user : null;

            return ListView(
              children: [
                AuthCard(
                  onTap: () {
                    if (!isAuthenticated) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => LoginPage(
                          onGoogleSignIn: () {
                            authBloc.add(SignInRequested());
                            context.pop();
                          },
                        ),
                      );
                    }
                  },
                  userName: user?.name,
                  email: user?.email,
                  photoUrl: user?.photoUrl,
                ),
                const Divider(),
                _buildSettingsList(context),
                const Gap(TNSizes.spaceBetweenItems),
                const Divider(),
                if (isAuthenticated)
                  TextButton(
                    onPressed: () {
                      authBloc.add(SignOutRequested());
                    },
                    child: const Text("Logout"),
                  ),
                const Gap(TNSizes.spaceBetweenSections),
                _buildAppVersionInfo(),
                const Gap(20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        _tile(
          icon: LucideIcons.fileText,
          title: TNTextStrings.termsConditions,
          onTap: () {
            context.goNamed(
              AppRoutes.webViews,
              extra: WebViewModel(
                title: TNTextStrings.termsConditions,
                url: ApiConstants.termsAndConditions,
              ),
            );
          },
        ),
        _tile(
          icon: LucideIcons.lock,
          title: TNTextStrings.privacyPolicy,
          onTap: () {
            context.goNamed(
              AppRoutes.webViews,
              extra: WebViewModel(
                url: ApiConstants.privacyPolicy,
                title: TNTextStrings.privacyPolicy,
              ),
            );
          },
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
                title: TNTextStrings.credits,
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
      ],
    );
  }

  Widget _buildAppVersionInfo() {
    return Center(
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
              Text(
                "$version ($buildNumber)",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          );
        },
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
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}