import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/app_theme.dart';
import '../widgets/history_item_widget.dart';
import '../widgets/statistics_card_widget.dart';
import '../widgets/empty_history_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detection History',
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(context),
            icon: const Icon(Icons.filter_list, color: Colors.white),
            tooltip: 'Filter',
          ),
          IconButton(
            onPressed: () => _showExportDialog(context),
            icon: const Icon(Icons.download_outlined, color: Colors.white),
            tooltip: 'Export',
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Overview
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Summary',
                  style: AppTextStyles.h4.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: StatisticsCardWidget(
                        title: 'Objects Detected',
                        value: '47',
                        icon: Icons.visibility,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Expanded(
                      child: StatisticsCardWidget(
                        title: 'Sessions',
                        value: '8',
                        icon: Icons.camera_alt,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Expanded(
                      child: StatisticsCardWidget(
                        title: 'Accuracy',
                        value: '94%',
                        icon: Icons.verified,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History List
          Expanded(
            child: _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    // Mock data for demonstration
    final historyItems = [
      {
        'objects': ['Person', 'Chair', 'Table'],
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        'location': 'Living Room',
        'confidence': 0.95,
      },
      {
        'objects': ['Car', 'Tree'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
        'location': 'Street View',
        'confidence': 0.89,
      },
      {
        'objects': ['Phone', 'Keys', 'Wallet'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'location': 'Bedroom',
        'confidence': 0.92,
      },
      {
        'objects': ['Dog', 'Ball'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
        'location': 'Park',
        'confidence': 0.88,
      },
    ];

    if (historyItems.isEmpty) {
      return const EmptyHistoryWidget();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: historyItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.paddingS),
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return HistoryItemWidget(
          objects: List<String>.from(item['objects'] as List),
          timestamp: item['timestamp'] as DateTime,
          location: item['location'] as String,
          confidence: item['confidence'] as double,
          onTap: () => _showHistoryDetails(item),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter by:'),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Today'),
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            CheckboxListTile(
              title: const Text('This Week'),
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            CheckboxListTile(
              title: const Text('This Month'),
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text('Object Type:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('People'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.primary.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('Vehicles'),
                  selected: false,
                  onSelected: (value) {},
                  selectedColor: AppColors.primary.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('Objects'),
                  selected: false,
                  onSelected: (value) {},
                  selectedColor: AppColors.primary.withOpacity(0.2),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Apply Filter'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose export format:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('CSV File'),
              subtitle: const Text('Spreadsheet format'),
              onTap: () {
                Navigator.of(context).pop();
                _exportAsCSV(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('PDF Report'),
              subtitle: const Text('Formatted document'),
              onTap: () {
                Navigator.of(context).pop();
                _exportAsPDF(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('JSON Data'),
              subtitle: const Text('Raw data format'),
              onTap: () {
                Navigator.of(context).pop();
                _exportAsJSON(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showHistoryDetails(Map<String, dynamic> item) {
    // TODO: Navigate to detailed view or show details dialog
  }

  void _exportAsCSV(BuildContext context) {
    // TODO: Implement CSV export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CSV export feature coming soon!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _exportAsPDF(BuildContext context) {
    // TODO: Implement PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PDF export feature coming soon!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _exportAsJSON(BuildContext context) {
    // TODO: Implement JSON export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON export feature coming soon!'),
        backgroundColor: AppColors.info,
      ),
    );
  }
}
