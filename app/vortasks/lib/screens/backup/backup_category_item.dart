import 'package:flutter/material.dart';
import 'package:vortasks/screens/backup/backup_category.dart';

class BackupCategoryItem extends StatelessWidget {
  final String title;
  final dynamic data;
  final String categoryName;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const BackupCategoryItem({
    super.key,
    required this.title,
    required this.data,
    required this.categoryName,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackupCategory(
                title: title,
                data: data,
                categoryName: categoryName,
              )
            ],
          ),
        ),
      ],
    );
  }
}
