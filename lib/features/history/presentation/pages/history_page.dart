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
          'Road Signs History',
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
                  'Road Signs Detection Summary',
                  style: AppTextStyles.h4.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: StatisticsCardWidget(
                        title: 'Road Signs',
                        value: '23',
                        icon: Icons.traffic,
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
                        value: '96%',
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
    // Road signs detection data - filtering out person class
    final allDetections = [
      {
        'objects': ['Stop Sign'],
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        'location': 'Main Street & Oak Ave',
        'confidence': 0.95,
        'type': 'road_sign',
      },
      {
        'objects': ['Person'], // This will be filtered out
        'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
        'location': 'Crosswalk',
        'confidence': 0.92,
        'type': 'person',
      },
      {
        'objects': ['Speed Limit 25'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
        'location': 'School Zone - Pine St',
        'confidence': 0.89,
        'type': 'road_sign',
      },
      {
        'objects': ['Person', 'Bicycle'], // Person will be filtered out
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        'location': 'Park Entrance',
        'confidence': 0.87,
        'type': 'mixed',
      },
      {
        'objects': ['Yield Sign'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'location': 'Highway 101 Ramp',
        'confidence': 0.92,
        'type': 'road_sign',
      },
      {
        'objects': ['No Parking'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
        'location': 'Downtown District',
        'confidence': 0.88,
        'type': 'road_sign',
      },
      {
        'objects': ['School Zone'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
        'location': 'Elementary School',
        'confidence': 0.94,
        'type': 'road_sign',
      },
      {
        'objects': ['Person', 'Person'], // This will be filtered out
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
        'location': 'Shopping Mall',
        'confidence': 0.85,
        'type': 'person',
      },
      {
        'objects': ['Construction Zone'],
        'timestamp': DateTime.now().subtract(const Duration(hours: 6)),
        'location': 'Bridge Construction',
        'confidence': 0.91,
        'type': 'road_sign',
      },
      {
        'objects': ['Traffic Light'],
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'location': 'City Center',
        'confidence': 0.96,
        'type': 'road_sign',
      },
    ];

    // Filter to show only road sign detections (exclude person class)
    final historyItems = allDetections.where((item) {
      final objects = List<String>.from(item['objects'] as List);
      final type = item['type'] as String;

      // Filter out detections that are purely person class or mixed with person
      if (type == 'person') return false;

      // For mixed detections, filter out person objects but keep road signs
      if (type == 'mixed') {
        final roadSignObjects = objects.where((obj) => !obj.toLowerCase().contains('person')).toList();

        if (roadSignObjects.isNotEmpty) {
          // Update the objects list to exclude person detections
          item['objects'] = roadSignObjects;
          return true;
        }
        return false;
      }

      // Keep all road sign detections
      return type == 'road_sign';
    }).toList();

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
            const Text('Road Sign Types:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Stop Signs'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.error.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('Speed Limits'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.warning.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('Yield Signs'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.primary.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('School Zones'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.info.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('No Parking'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.secondary.withOpacity(0.2),
                ),
                FilterChip(
                  label: const Text('Construction'),
                  selected: true,
                  onSelected: (value) {},
                  selectedColor: AppColors.warning.withOpacity(0.2),
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
