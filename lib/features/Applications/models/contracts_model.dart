class Contract {
  final String id;
  final String companyLogo;
  final String companyName;
  final String position;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double? payment;
  final String frequency;
  final String? nextDeadline;
  final double progress;
  final String contractType;

  Contract({
    required this.id,
    required this.companyLogo,
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.payment,
    required this.frequency,
    this.nextDeadline,
    required this.progress,
    required this.contractType,
  });
}