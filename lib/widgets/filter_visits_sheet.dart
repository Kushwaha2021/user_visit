import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_visit/models/visit_model.dart';
import 'package:user_visit/providers/visits_provider.dart';

class FilterVisitsSheet extends StatefulWidget {
  const FilterVisitsSheet({super.key});

  @override
  State<FilterVisitsSheet> createState() => _FilterVisitsSheetState();
}

class _FilterVisitsSheetState extends State<FilterVisitsSheet> {
  VisitType? _tempSelectedType;
  VisitStatus? _tempSelectedStatus;

  @override
  void initState() {
    super.initState();
    final provider = context.read<VisitsProvider>();
    _tempSelectedType = provider.selectedTypeFilter;
    _tempSelectedStatus = provider.selectedStatusFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Visits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildFilterSection<VisitType>(
            'VISIT TYPE',
            VisitType.values,
            (type) => type?.displayTitle ?? 'All',
            _tempSelectedType,
            (value) => setState(() => _tempSelectedType = value),
          ),
          const SizedBox(height: 20),
          _buildFilterSection<VisitStatus>(
            'VISIT STATUS',
            VisitStatus.values
                .where((s) => s != VisitStatus.completed)
                .toList(),
            (status) => status?.displayTitle ?? 'All',
            _tempSelectedStatus,
            (value) => setState(() => _tempSelectedStatus = value),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<VisitsProvider>()
                        .applyFilters(_tempSelectedType, _tempSelectedStatus);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    // Button color
                    foregroundColor: Colors.white,
                    // Text color
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: const Text('Apply Filter',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Bottom spacing
        ],
      ),
    );
  }

  Widget _buildFilterSection<T>(
    String title,
    List<T> options,
    String Function(T?) getLabel,
    T? currentSelection,
    ValueChanged<T?> onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0, // Horizontal space between chips
          runSpacing: 8.0, // Vertical space between lines
          children: [
            // 'All' option
            FilterChip(
              selectedColor: Colors.deepPurpleAccent.withOpacity(0.2),
              label: Text(getLabel(null)),
              // 'All'
              selected: currentSelection == null,
              onSelected: (selected) {
                if (selected) {
                  onSelected(null);
                }
              },
              showCheckmark: false,
              checkmarkColor:
                  Colors.white,
            ),
            ...options.map((option) {
              return FilterChip(
                selectedColor: Colors.deepPurpleAccent.withOpacity(0.2),
                label: Text(getLabel(option)),
                selected: currentSelection == option,
                onSelected: (selected) {
                  onSelected(selected ? option : null);
                },
                checkmarkColor: Colors.black,
                showCheckmark: false,
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
