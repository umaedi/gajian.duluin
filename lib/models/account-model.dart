class AccountModel {
  final bool isSuccess;
  final String isApproved;
  final String monthlySalary;
  final String companyId;
  final String companyName;
  final String companyCutoffDate;
  final String companyPayday;
  final String companyPhone;
  final int maxLoanPercent;
  final int singleCutoff;
  final String adminFee;
  final String platformFee;
  final String myBalanceId;
  final String employeeId;
  final String loanMaxAmount;
  final String loanCreditAmount;
  final String loanDebitAmount;
  final String loanBalanceMonth;
  final String loanBalanceYear;
  final String createdAt;
  final String updatedAt;
  final String loanMinAmount;
  final int workingDay;
  final String month;
  final String loanAdminFee;
  final String loanPlatformFee;
  final String loanInterest;
  final String defaultCost;
  final int pointValue;

  AccountModel({
    required this.isSuccess,
    required this.isApproved,
    required this.monthlySalary,
    required this.companyId,
    required this.companyName,
    required this.companyCutoffDate,
    required this.companyPayday,
    required this.companyPhone,
    required this.maxLoanPercent,
    required this.singleCutoff,
    required this.adminFee,
    required this.platformFee,
    required this.myBalanceId,
    required this.employeeId,
    required this.loanMaxAmount,
    required this.loanCreditAmount,
    required this.loanDebitAmount,
    required this.loanBalanceMonth,
    required this.loanBalanceYear,
    required this.createdAt,
    required this.updatedAt,
    required this.loanMinAmount,
    required this.workingDay,
    required this.month,
    required this.loanAdminFee,
    required this.loanPlatformFee,
    required this.loanInterest,
    required this.defaultCost,
    required this.pointValue,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      isSuccess: json['success'],
      isApproved: json['data']['is_approved'] ?? '',
      monthlySalary: json['data']['monthly_salary'] ?? '',
      companyId: json['data']['company_id'] ?? '',
      companyName: json['data']['company']['company_name'] ?? '',
      companyCutoffDate: json['data']['company']['cutoff_date'] ?? '',
      companyPayday: json['data']['company']['company_payday'] ?? '',
      companyPhone: json['data']['company']['company_phone'] ?? '',
      maxLoanPercent: json['data']['company']['max_loan_percent'] ?? 0,
      singleCutoff: json['data']['company']['single_cutoff'] ?? 0,
      adminFee: json['data']['company']['admin_fee'] ?? '',
      platformFee: json['data']['company']['platform_fee'] ?? '',
      myBalanceId: json['data']['myBalance']['id'] ?? '',
      employeeId: json['data']['myBalance']['employee_id'] ?? '',
      loanMaxAmount: json['data']['myBalance']['loan_max_amount'] ?? '',
      loanCreditAmount: json['data']['myBalance']['loan_credit_amount'] ?? '',
      loanDebitAmount: json['data']['myBalance']['loan_debit_amount'] ?? '',
      loanBalanceMonth: json['data']['myBalance']['loan_balance_month'] ?? '',
      loanBalanceYear: json['data']['myBalance']['loan_balance_year'] ?? '',
      createdAt: json['data']['myBalance']['created_at'] ?? '',
      updatedAt: json['data']['myBalance']['updated_at'] ?? '',
      loanMinAmount: json['data']['myBalance']['loan_min_amount'] ?? '',
      workingDay: json['data']['myBalance']['working_day'] ?? 0,
      month: json['data']['myBalance']['month'] ?? '',
      loanAdminFee: json['data']['costFee']['loan_admin_fee'] ?? '',
      loanPlatformFee: json['data']['costFee']['loan_platform_fee'] ?? '',
      loanInterest: json['data']['costFee']['loan_interest'] ?? '',
      defaultCost: json['data']['costFee']['default'] ?? '',
      pointValue: json['data']['point'] ?? 0,
    );
  }
}
