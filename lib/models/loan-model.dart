class LoanModel {
  final String id;
  final String employeeId;
  final String loanPurpose;
  final String loanStatus;
  final String loanAmount;
  final String updated;
  final String created;
  final String loanRefNum;
  final String loanAdminFee;
  final String loanPlatformFee;
  final String loanDisbursedAmount;
  final String loanDisbursedAt;
  final String disbursedBank;
  final String disbursedAccNumber;

  LoanModel({
    required this.id,
    required this.employeeId,
    required this.loanPurpose,
    required this.loanStatus,
    required this.loanAmount,
    required this.updated,
    required this.created,
    required this.loanRefNum,
    required this.loanAdminFee,
    required this.loanPlatformFee,
    required this.loanDisbursedAmount,
    required this.loanDisbursedAt,
    required this.disbursedBank,
    required this.disbursedAccNumber,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      loanPurpose: json['loan_purpose'] ?? '',
      loanStatus: json['loan_status'] ?? '',
      loanAmount: json['loan_amount'] ?? '',
      updated: json['updated'] ?? '',
      created: json['created'] ?? '',
      loanRefNum: json['loan_reference_number'] ?? '',
      loanAdminFee: json['loan_admin_fee'] ?? '',
      loanPlatformFee: json['loan_platform_fee'] ?? '',
      loanDisbursedAmount: json['loan_disbursed_amount'] ?? '',
      loanDisbursedAt: json['loan_disbursed_at'] ?? '',
      disbursedBank: json['disbursed_bank'] ?? '',
      disbursedAccNumber: json['disbursed_acc_number'] ?? '',
    );
  }
}
