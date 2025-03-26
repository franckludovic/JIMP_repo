import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


import '../../../../common/widgets/searchbar/searchbar.dart';
import '../../models/contracts_model.dart';
import 'contract_card.dart';
import 'contract_details.dart';

class OngoingContractsPage extends StatefulWidget {
  const OngoingContractsPage({super.key});

  @override
  State<OngoingContractsPage> createState() => _OngoingContractsPageState();
}

class _OngoingContractsPageState extends State<OngoingContractsPage> {
  final List<Contract> _allContracts = [
    Contract(
      id: '1',
      companyName: 'GOOGLE Inc.',
      companyLogo: JImages.google,
      position: 'Flutter Developer Intern',
      status: 'In Progress',
      progress: 0.65,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 60)),
      payment: 1500,
      frequency: 'month',
      contractType: 'Internship',
    ),
    Contract(
      id: '2',
      companyName: 'NVIDIA Ltd.',
      companyLogo: JImages.nvidia,
      position: 'UI/UX Design Intern',
      status: 'In Review',
      progress: 0.9,
      startDate: DateTime.now().subtract(const Duration(days: 90)),
      endDate: DateTime.now().subtract(const Duration(days: 7)),
      payment: 1200,
      frequency: 'month',
      contractType: 'JOB',
    ),
  ];

  List<Contract> _filteredContracts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredContracts = _allContracts;
    _searchController.addListener(_filterContracts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContracts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContracts = _allContracts.where((contract) {
        return contract.companyName.toLowerCase().contains(query) ||
            contract.position.toLowerCase().contains(query) ||
            contract.status.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ongoing Contracts'),
            Text('2 Active Contracts', style: TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.filter),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Using the reusable search bar
          JSearchBar(
            controller: _searchController,
            hintText: 'Search contracts...',
            onChanged: (value) => _filterContracts(),
          ),
          Expanded(
            child: _filteredContracts.isEmpty
                ? _buildEmptyState()
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.defaultSpace),
              child: ListView.separated(
                itemCount: _filteredContracts.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: JSizes.spaceBtwItems),
                itemBuilder: (context, index) => ContractCard(
                  contract: _filteredContracts[index],
                  onPressed: () => _navigateToDetail(_filteredContracts[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.document, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: JSizes.spaceBtwSections),
          Text(
            _searchController.text.isEmpty
                ? 'No Active Contracts'
                : 'No contracts found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: JSizes.xs),
          Text(
            _searchController.text.isEmpty
                ? 'Apply to opportunities to see contracts here'
                : 'Try a different search term',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // Implement filter dialog
  }

  void _navigateToDetail(Contract contract) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContractDetailPage(contract: contract),
      ),
    );
  }
}