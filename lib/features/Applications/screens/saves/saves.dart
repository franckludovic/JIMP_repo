import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/filtering/application_filter.dart';
import 'package:project_bc_tuto/common/widgets/icons/circular_icon.dart';
import 'package:project_bc_tuto/common/widgets/job_and_internship_card/vertical_application.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';

import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../search_page/widgets/SearchTextField.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final ApplicationFilter _filter = ApplicationFilter();
  final List<Map<String, dynamic>> _allApplications = [];
  List<Map<String, dynamic>> _filteredApplications = [];

  @override
  void initState() {
    super.initState();
    _initializeApplications();
    _applyFilters();
  }

  void _initializeApplications() {
    _allApplications.addAll([
      {
        'id': 1,
        'title': 'Database Engineer',
        'company': 'Nvidia',
        'type': 'Internship',
        'industry': 'Technology',
        'status': 'Pending',
        'location': 'Douala',
        'logo': JImages.nvidia,
        'saved': true,
        'period' : 'Full_time'
      },
      {
        'id': 2,
        'title': 'Software Developer',
        'company': 'Google',
        'type': 'JOB',
        'industry': 'Software',
        'status': 'Accepted',
        'location': 'Yaounde',
        'logo': JImages.google,
        'saved': true,
        'period' : 'Part_time'
      },

    ]);
  }

  void _applyFilters([ApplicationFilter? newFilter]) {
    final filter = newFilter ?? _filter;

    setState(() {
      _filteredApplications = _allApplications.where((app) {
        final matchesType = filter.applicationTypes.isEmpty ||
            filter.applicationTypes.contains(app['type']);

        final matchesIndustry = filter.selectedIndustry == null ||
            app['Industry'] == filter.selectedIndustry;


        final matchesStatus = filter.statuses.isEmpty ||
            filter.statuses.contains(app['status']);

        final matchesPeriod = filter.periods.isEmpty ||
            filter.periods.contains(app['period']);


        return matchesType && matchesIndustry && matchesStatus && matchesPeriod;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _filter.reset();
      _applyFilters(_filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Saved Applications",
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          JCircularIcon(
            icon: Iconsax.filter,
            color: Colors.blue,
            onPressed: () => Get.bottomSheet(
              ApplicationFilterWidget(
                initialFilter: _filter,
                onApply: (newFilter) {
                  _filter.applicationTypes = newFilter.applicationTypes;
                  _filter.selectedIndustry = newFilter.selectedIndustry;
                  _filter.statuses = newFilter.statuses;
                  _filter.periods = newFilter.periods;
                  _applyFilters();
                },
                onCancel: _clearFilters,
              ),
              backgroundColor: Theme.of(context).canvasColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              const SearchTextField(),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Filter Status & Result Count
              Row(
                children: [
                  if (_filter.statuses.isNotEmpty ||
                      _filter.applicationTypes.isNotEmpty)
                    FilterChip(
                      label: const Text('Clear Filters'),
                      onSelected: (_) => _clearFilters(),
                      backgroundColor: Colors.red.withAlpha((0.2 * 255).toInt()),
                    ),
                  const Spacer(),
                  Text(
                    '${_filteredApplications.length} ${_filteredApplications.length == 1 ? 'Result' : 'Results'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Applications Grid
              JGridLayout(
                itemCount: _filteredApplications.length,
                crossAxisCount: 2,
                itemBuilder: (_, index) => VerticalJInternshipCard(
                  companyLogo: _filteredApplications[index]['logo'],
                  companyName: _filteredApplications[index]['company'],
                  internshipTitle: _filteredApplications[index]['title'],
                  location: _filteredApplications[index]['location'],
                  jobType: _filteredApplications[index]['type'],
                  saved: _filteredApplications[index]['saved'],
                  status: _filteredApplications[index]['status'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}