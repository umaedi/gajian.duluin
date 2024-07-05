class UserModel {
  final String id;
  final String leadId;
  final String companyId;
  final String companyName;
  final String? bankId;
  final String nik;
  final String employeeIdCard;
  final String name;
  final String birthdayAddress;
  final String birthdayDate;
  final String address;
  final String email;
  final String phoneNumber;
  final String emergencyName;
  final String emergencyPhoneNumber;
  final String emergencyRelation;
  final String ktpPhoto;
  final String selfiePhoto;
  final String cutoffDate;
  final String companyPayday;
  final String monthlySalary;
  final String? monthlyHours;
  final String bankName;
  final String bankCode;
  final String bankAccountNumber;
  final int banned;
  final String? bannedReason;
  final String? ownedBy;
  final String isApproved;
  final String? rejectedReason;
  final String approvedBy;
  final String approvedAt;
  final String createdAt;
  final String updatedAt;
  final int isEmailVerified;

  UserModel({
    required this.id,
    required this.leadId,
    required this.companyId,
    required this.companyName,
    this.bankId,
    required this.nik,
    required this.employeeIdCard,
    required this.name,
    required this.birthdayAddress,
    required this.birthdayDate,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.emergencyName,
    required this.emergencyPhoneNumber,
    required this.emergencyRelation,
    required this.ktpPhoto,
    required this.selfiePhoto,
    required this.cutoffDate,
    required this.companyPayday,
    required this.monthlySalary,
    this.monthlyHours,
    required this.bankName,
    required this.bankCode,
    required this.bankAccountNumber,
    required this.banned,
    this.bannedReason,
    this.ownedBy,
    required this.isApproved,
    this.rejectedReason,
    required this.approvedBy,
    required this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      leadId: json['lead_id'] ?? '',
      companyId: json['company_id'] ?? '',
      companyName: json['company_name'] ?? '',
      bankId: json['bank_id'],
      nik: json['nik'] ?? '',
      employeeIdCard: json['employee_id_card'] ?? '',
      name: json['name'] ?? '',
      birthdayAddress: json['birthday_address'] ?? '',
      birthdayDate: json['birthday_date'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      emergencyName: json['emergency_name'] ?? '',
      emergencyPhoneNumber: json['emergency_phone_number'] ?? '',
      emergencyRelation: json['emergency_relation'] ?? '',
      ktpPhoto: json['ktp_photo'] ?? '',
      selfiePhoto: json['selfie_photo'] ?? '',
      cutoffDate: json['cutoff_date'] ?? '',
      companyPayday: json['company_payday'] ?? '',
      monthlySalary: json['monthly_salary'] ?? '',
      monthlyHours: json['monthly_hours'],
      bankName: json['bank_name'] ?? '',
      bankCode: json['bank_code'] ?? '',
      bankAccountNumber: json['bank_account_number'] ?? '',
      banned: json['banned'] ?? 0,
      bannedReason: json['banned_reason'],
      ownedBy: json['owned_by'],
      isApproved: json['is_approved'] ?? '',
      rejectedReason: json['rejected_reason'],
      approvedBy: json['approved_by'] ?? '',
      approvedAt: json['approved_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isEmailVerified: json['is_email_verified'],
    );
  }
}
