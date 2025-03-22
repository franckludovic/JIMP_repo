import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';

import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../authentication/compamy_screens/sign_up/add_recruiter.dart';
import '../../../authentication/compamy_screens/sign_up/widget/recuiter_info.dart';
import 'employee_model.dart';
import 'emplyee_card.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final EmployeeFilter _filter = EmployeeFilter();
  List<Employee> allEmployees = [];
  List<Employee> filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    _initializeEmployees();
  }

  void _initializeEmployees() {
    allEmployees = List.generate(10, (index) => Employee(
      id: 'EMP${index + 1}',
      name: 'Employee ${index + 1}',
      position: index % 3 == 0 ? 'Software Engineer' : 'UX Designer',
      email: 'employee${index + 1}@company.com',
      role: index % 2 == 0 ? 'Employee' : 'Intern',
      avatar: JImages.user2,
      department: index % 4 == 0 ? 'Engineering' : 'Design',
      status: index % 5 == 0 ? 'Active' : 'Inactive',
    ));
    filteredEmployees = allEmployees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text('Team Management',
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.user_add),
            onPressed: () => Get.to(() => const AddRecruiterForm()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: JSizes.spaceBtwSections),
            Expanded(
              child: ListView.separated(
                itemCount: filteredEmployees.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: JSizes.spaceBtwItems),
                itemBuilder: (context, index) => EmployeeCard(
                  employee: filteredEmployees[index],
                  onDelete: () => _confirmDelete(context, index),
                  onEdit: _navigateToEdit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.search_normal),
        hintText: 'Search employees...',
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Iconsax.filter),
              onPressed: _showFilterMenu,
            ),
            IconButton(
              icon: const Icon(Iconsax.close_circle),
              onPressed: _clearFilters,
            ),
          ],
        ),
      ),
      onChanged: (value) => _applyFilters(),
    );
  }

  void _showFilterMenu() {
    Get.bottomSheet(
      Container(
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
                    onPressed: Get.back,
                    child: const Text('Cancel')
                ),
        ),
                const SizedBox(width: JSizes.spaceBtwItems),

                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _applyFilters();
                        Get.back();
                      },
                      child: const Text('Apply Filters')),
                ),

            ],
          ),
          ]
        ),
      ),
    ));
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
          onSelected: (selected) => setState(() {
            if (selected) {
              _filter.roles.add(role);
            } else {
              _filter.roles.remove(role);
            }
          }),
        );
      }).toList(),
    );
  }

  Widget _buildPositionFilter() {
    final positions = ['Software Engineer', 'UX Designer', 'Product Manager'];
    return DropdownButtonFormField(
      items: positions.map((position) => DropdownMenuItem(
        value: position,
        child: Text(position),
      )).toList(),
      value: _filter.selectedPosition,
      onChanged: (value) => setState(() => _filter.selectedPosition = value),
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
          onSelected: (selected) => setState(() {
            if (selected) {
              _filter.departments.add(dept);
            } else {
              _filter.departments.remove(dept);
            }
          }),
        );
      }).toList(),
    );
  }

  Widget _buildStatusFilter() {
    return SegmentedButton(
      segments: const [
        ButtonSegment(value: 'Active', label: Text('Active')),
        ButtonSegment(value: 'Inactive', label: Text('Inactive')),
      ],
      selected: _filter.statuses,
      onSelectionChanged: (selection) => setState(() => _filter.statuses = selection),
      multiSelectionEnabled: true,
      emptySelectionAllowed: true,
    );
  }

  void _applyFilters() {
    final searchQuery = _searchController.text.toLowerCase();

    setState(() {
      filteredEmployees = allEmployees.where((employee) {
        final matchesSearch = employee.name.toLowerCase().contains(searchQuery) ||
            employee.email.toLowerCase().contains(searchQuery);

        final matchesRole = _filter.roles.isEmpty ||
            _filter.roles.contains(employee.role);

        final matchesPosition = _filter.selectedPosition == null ||
            employee.position == _filter.selectedPosition;

        final matchesDepartment = _filter.departments.isEmpty ||
            _filter.departments.contains(employee.department);

        final matchesStatus = _filter.statuses.isEmpty ||
            _filter.statuses.contains(employee.status);

        return matchesSearch && matchesRole && matchesPosition &&
            matchesDepartment && matchesStatus;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _filter.reset();
      _applyFilters();
    });
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to remove this team member?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                allEmployees.removeAt(index);
                _applyFilters();
              });
              Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit() {

    Get.to(() => const RecruiterInfo());
  }
}