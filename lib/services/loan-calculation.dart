String calculateWithPlatformFee(
    String loanAmount, int adminFee, int platformFee, int point) {
  int loanAmountValue = int.parse(loanAmount
      .replaceAll('.', '')
      .replaceAll(',', '')); // Menghapus format coma dalam loan amount
  int total = loanAmountValue - adminFee - platformFee + point;
  return total.toStringAsFixed(0);
}

String calculateWithInterest(
    String loanAmount, int adminFee, int platformFee, int point) {
  int loanAmountValue = int.parse(loanAmount
      .replaceAll('.', '')
      .replaceAll(',', '')); // Menghapus format coma dalam loan amount
  int total = (loanAmountValue - adminFee) - platformFee + point;
  return total.toStringAsFixed(0);
}
