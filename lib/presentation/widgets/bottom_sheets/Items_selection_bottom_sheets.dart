import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';

class ItemsSelectionBottomSheet {
  static void show({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(TNSizes.spaceMD),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TNSizes.spaceSM),
              ...options.map((option) {
                final isSelected = option == selectedValue;
                return ListTile(
                  title: Text(option),
                  trailing: isSelected
                      ? const Icon(LucideIcons.check, color: TNColors.primary)
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(option);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
