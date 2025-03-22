import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class EmployeeFilter {
  List<String> roles;
  String? selectedPosition;
  List<String> departments;
  Set<String> statuses;

  EmployeeFilter({
    this.roles = const [],
    this.selectedPosition,
    this.departments = const [],
    this.statuses = const {},
  });

  // Clone method: creates a new EmployeeFilter from an existing one
  factory EmployeeFilter.from(EmployeeFilter other) {
    return EmployeeFilter(
      roles: List.from(other.roles),
      selectedPosition: other.selectedPosition,
      departments: List.from(other.departments),
      statuses: Set.from(other.statuses),
    );
  }

  void reset() {
    roles.clear();
    selectedPosition = null;
    departments.clear();
    statuses.clear();
  }
}

class EmployeeFilterWidget extends StatefulWidget {
  final EmployeeFilter initialFilter;
  final Function(EmployeeFilter) onApply;
  final VoidCallback? onCancel;

  const EmployeeFilterWidget({
    super.key,
    required this.initialFilter,
    required this.onApply,
    this.onCancel,
  });

  @override
  State<EmployeeFilterWidget> createState() => _EmployeeFilterWidgetState();
}

class _EmployeeFilterWidgetState extends State<EmployeeFilterWidget> {
  late EmployeeFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = EmployeeFilter.from(widget.initialFilter);
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
            _buildFilterSection('Role', _buildRoleFilter()),
            _buildFilterSection('Position', _buildPositionFilter()),
            _buildFilterSection('Department', _buildDepartmentFilter()),
            _buildFilterSection('Status', _buildStatusFilter()),
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

  Widget _buildRoleFilter() {
    return Wrap(
      spacing: JSizes.sm,
      children: ['Employee', 'Intern'].map((role) {
        return FilterChip(
          label: Text(role),
          selected: _filter.roles.contains(role),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _filter.roles.add(role);
              } else {
                _filter.roles.remove(role);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildPositionFilter() {
    final positions = ['Software Engineer', 'UX Designer', 'Product Manager'];
    return DropdownButtonFormField<String>(
      items: positions.map((position) {
        return DropdownMenuItem(
          value: position,
          child: Text(position),
        );
      }).toList(),
      value: positions.contains(_filter.selectedPosition)
          ? _filter.selectedPosition
          : null, // Ensure valid selection
      onChanged: (value) {
        setState(() {
          _filter.selectedPosition = value;
        });
      },
      decoration: const InputDecoration(labelText: 'Select Position'),
    );
  }

  Widget _buildDepartmentFilter() {
    final departments = ['Engineering', 'Design', 'HR', 'Marketing'];
    return Wrap(
      spacing: JSizes.sm,
      children: departments.map((dept) {
        return ChoiceChip(
          label: Text(dept),
          selected: _filter.departments.contains(dept),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _filter.departments.add(dept);
              } else {
                _filter.departments.remove(dept);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildStatusFilter() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'Active', label: Text('Active')),
        ButtonSegment(value: 'Inactive', label: Text('Inactive')),
      ],
      selected: _filter.statuses,
      onSelectionChanged: (selection) {
        setState(() {
          _filter.statuses = selection;
        });
      },
      multiSelectionEnabled: true,
      emptySelectionAllowed: true,
    );
  }
}
