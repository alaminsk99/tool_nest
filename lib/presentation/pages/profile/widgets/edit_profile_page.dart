import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(TNTextStrings.editProfile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.ellipsisVertical),
            onPressed: () {
              // TODO: Delete Account Logic Here
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: TNColors.borderPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TNSizes.spaceBetweenItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Avatar with Change Button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? TNColors.darkGrey : TNColors.grey,
                  borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: TNColors.white,
                      child: Icon(
                        LucideIcons.user,
                        size: 40,
                        color: TNColors.grey,
                      ),
                    ),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            //TODO: here function for change photo
                          },
                          child: Row(
                            children: [
                              const Icon(LucideIcons.camera, color: TNColors.primary),
                              const Gap(8),
                              Text(
                                TNTextStrings.changePhoto,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: TNColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Text(
                          TNTextStrings.selectPhotoFromGallery,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(TNSizes.spaceBetweenSections),

              /// Name Field
              Text("Name", style: textTheme.labelLarge),
              const Gap(4),
              TextFormField(
                initialValue: "William Jason",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              const Gap(TNSizes.spaceBetweenItems),

              /// Email Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Email", style: textTheme.labelLarge),

                const Text("williamjason2526@gmail.com"),

              ],),

              const Gap(TNSizes.spaceBetweenSections),

              /// Save Button
              ProcessButton(onPressed:(){} ,text: TNTextStrings.save,),
            ],
          ),
        ),
      ),
    );
  }
}
