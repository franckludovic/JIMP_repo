import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


class ApplicationFilter {
    List<String> applicationTypes;


  String? selectedIndustry;




  Set<String> statuses;

  Set<String> periods;



  ApplicationFilter({
    this.applicationTypes = const [],
    this.selectedIndustry,
    this.statuses = const {},
    this.periods = const {},
  });

  /// Clone method: creates a new ApplicationFilter from an existing one
  factory ApplicationFilter.from(ApplicationFilter other) {
    return ApplicationFilter(
      applicationTypes: List.from(other.applicationTypes),
      selectedIndustry: other.selectedIndustry,
      statuses: Set.from(other.statuses),
      periods: Set.from(other.periods),
    );
  }


  void reset() {
    applicationTypes.clear();
    selectedIndustry = null;
    statuses.clear();
    periods.clear();
  }
}



class ApplicationFilterWidget extends StatefulWidget {
  final ApplicationFilter initialFilter;
  final Function(ApplicationFilter) onApply;
  final VoidCallback? onCancel;

  const ApplicationFilterWidget({
    super.key,
    required this.initialFilter,
    required this.onApply,
    this.onCancel,
  });

  @override
  State<ApplicationFilterWidget> createState() => _ApplicationFilterWidgetState();
}

class _ApplicationFilterWidgetState extends State<ApplicationFilterWidget> {
  late ApplicationFilter _filter;

  @override
  void initState() {
    super.initState();
    // Clone the initial filter so changes don't affect the original until applied.
    _filter = ApplicationFilter.from(widget.initialFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(JSizes.cardRadiusLg),
          topRight: Radius.circular(JSizes.cardRadiusLg),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterSection('Application Types', _buildAppTypesFilter()),
            _buildFilterSection('Job Title', _buildIndustryFilter()),
            _buildFilterSection('Status', _buildStatusFilter()),
            _buildFilterSection('Periods', _buildAppPeriodFilter()),
            const SizedBox(height: JSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onCancel?.call();
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: JSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_filter);
                      Get.back();
                    },
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: JSizes.spaceBtwItems / 2),
        content,
        const SizedBox(height: JSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildAppTypesFilter() {

    final types = ['JOB', 'Internship'];
    return Wrap(
      spacing: JSizes.sm,
      children: types.map((type) {
        return FilterChip(
          label: Text(type),
          selected: _filter.applicationTypes.contains(type),
          onSelected: (selected) => setState(() {
            if (selected) {
              _filter.applicationTypes.add(type);
            } else {
              _filter.applicationTypes.remove(type);
            }
          }),
        );
      }).toList(),
    );
  }

  Widget _buildAppPeriodFilter() {

    final types = ['Full_time', 'Part_time'];
    return Wrap(
      spacing: JSizes.sm,
      children: types.map((type) {
        return FilterChip(
          label: Text(type),
          selected: _filter.periods.contains(type),
          onSelected: (selected) => setState(() {
            if (selected) {
              _filter.periods.add(type);
            } else {
              _filter.periods.remove(type);
            }
          }),
        );
      }).toList(),
    );
  }

  Widget _buildIndustryFilter() {
    final jobTitles = ['Engineering', 'Design', 'HR', 'Marketing'];
    return DropdownButtonFormField<String>(
      items: jobTitles.map((title) {
        return DropdownMenuItem(
          value: title,
          child: Text(title),
        );
      }).toList(),
      value: jobTitles.contains(_filter.selectedIndustry)
          ? _filter.selectedIndustry
          : null,
      onChanged: (value) => setState(() => _filter.selectedIndustry = value),
      decoration: const InputDecoration(labelText: 'Select Industry'),
    );
  }

  Widget _buildStatusFilter() {

    return Wrap(
      spacing: JSizes.sm,
      children: ['Pending', 'Accepted', 'Rejected', 'Not Applied'].map((status) {
        final isSelected = _filter.statuses.contains(status);
        return FilterChip(
          label: Text(status),
          selected: isSelected,
          onSelected: (selected) => setState(() {
            if (selected) {
              _filter.statuses.add(status);
            } else {
              _filter.statuses.remove(status);
            }
          }),
        );
      }).toList(),
    );
  }
}
