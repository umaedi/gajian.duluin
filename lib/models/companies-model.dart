class CompaniesModel {
  final String id;
  final String company_id;
  final String id_card;
  final String company_name;
  final String is_approved;

  CompaniesModel({
    required this.id,
    required this.company_id,
    required this.id_card,
    required this.company_name,
    required this.is_approved,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      id: json['id'] ?? '',
      company_id: json['company_id'] ?? '',
      id_card: json['id_card'] ?? '',
      company_name: json['company_name'] ?? '',
      is_approved: json['is_approved'] ?? '',
    );
  }
}

class CompanyInformationModel {
  final String companyId;
  final String businessCategoryId;
  final String? companyCode;
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final DateTime cutoffDate;
  final DateTime companyPayday;
  final DateTime startPayrollDate;
  final DateTime endPayrollDate;
  final String responsibleName;
  final String responsiblePosition;

  CompanyInformationModel({
    required this.companyId,
    required this.businessCategoryId,
    this.companyCode,
    required this.companyName,
    required this.companyAddress,
    required this.companyPhone,
    required this.cutoffDate,
    required this.companyPayday,
    required this.startPayrollDate,
    required this.endPayrollDate,
    required this.responsibleName,
    required this.responsiblePosition,
  });

  factory CompanyInformationModel.fromJson(Map<String, dynamic> json) {
    return CompanyInformationModel(
      companyId: json['company']['id'] ?? '',
      businessCategoryId: json['company']['business_category_id'] ?? '',
      companyCode: json['company']['company_code'],
      companyName: json['company']['company_name'] ?? '',
      companyAddress: json['company']['company_address'] ?? '',
      companyPhone: json['company']['company_phone'] ?? '',
      cutoffDate: DateTime.parse(json['company']['cutoff_date']),
      companyPayday: DateTime.parse(json['company']['company_payday']),
      startPayrollDate: DateTime.parse(json['company']['start_payroll_date']),
      endPayrollDate: DateTime.parse(json['company']['end_payroll_date']),
      responsibleName: json['company']['responsible_name'],
      responsiblePosition: json['company']['responsible_position'],
    );
  }
}
