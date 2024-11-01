import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/backup/backup.dart';
import 'package:vortasks/screens/backup/backup_category_item.dart';
import 'package:vortasks/stores/backup/backup_store.dart';

class BackupDataCard extends StatelessWidget {
  final Backup backup;

  BackupDataCard({super.key, required this.backup});
  final BackupStore _backupStore = GetIt.I<BackupStore>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) => BackupCategoryItem(
                title: 'Metas',
                data: backup.goals,
                categoryName: 'Goals',
                isExpanded: _backupStore.expandedCategories['Goals'] ?? false,
                onExpansionChanged: (value) =>
                    _backupStore.setExpandedCategory('Goals', value),
              ),
            ),
            Observer(
              builder: (_) => BackupCategoryItem(
                title: 'Conquistas',
                data: backup.achievements,
                categoryName: 'Achievements',
                isExpanded:
                    _backupStore.expandedCategories['Achievements'] ?? false,
                onExpansionChanged: (value) =>
                    _backupStore.setExpandedCategory('Achievements', value),
              ),
            ),
            Observer(
              builder: (_) => BackupCategoryItem(
                title: 'Tarefas',
                data: backup.tasks,
                categoryName: 'Tasks',
                isExpanded: _backupStore.expandedCategories['Tasks'] ?? false,
                onExpansionChanged: (value) =>
                    _backupStore.setExpandedCategory('Tasks', value),
              ),
            ),
            Observer(
              builder: (_) => BackupCategoryItem(
                title: 'Habilidades',
                data: backup.skills,
                categoryName: 'Skills',
                isExpanded: _backupStore.expandedCategories['Skills'] ?? false,
                onExpansionChanged: (value) =>
                    _backupStore.setExpandedCategory('Skills', value),
              ),
            ),
            Observer(
              builder: (_) => BackupCategoryItem(
                title: 'Dias de Check-in',
                data: backup.checkIns,
                categoryName: 'CheckIns',
                isExpanded:
                    _backupStore.expandedCategories['CheckInDays'] ?? false,
                onExpansionChanged: (value) =>
                    _backupStore.setExpandedCategory('CheckInDays', value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
