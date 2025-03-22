class Employee {
  final String id;
  final String name;
  final String position;
  final String email;
  final String role;
  final String avatar;
  final String department;
  final String status;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.email,
    required this.role,
    required this.avatar,
    required this.department,
    required this.status,
  });
}

class EmployeeFilter {
  List<String> roles = [];
  String? selectedPosition;
  List<String> departments = [];
  Set<String> statuses = {};

  void reset() {
    roles.clear();
    selectedPosition = null;
    departments.clear();
    statuses.clear();
  }
}