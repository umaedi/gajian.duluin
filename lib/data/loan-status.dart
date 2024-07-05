import 'dart:ui';

import '../contants/color.dart';

Color getStatusColor(String status) {
  switch (status) {
    case "waiting":
      return WAITING_BG_COLOR;
    case "approved_partner":
      return APPROVED_PARTNER_BG_COLOR;
    case "rejected_partner":
      return REJECTED_PARTNER_BG_COLOR;
    case "approved":
      return APPROVED_BG_COLOR;
    case "disbursed":
      return DISBURSED_BG_COLOR;
    case "repayment":
      return REPAYMENT_BG_COLOR;
    default:
      return REJECTED_BG_COLOR;
  }
}

String getStatusText(String status) {
  switch (status) {
    case "waiting":
      return "Menunggu";
    case "approved_partner":
      return "Menunggu";
    case "rejected_partner":
      return "Gagal";
    case "approved":
      return "Diproses";
    case "disbursed":
      return "Berhasil";
    case "repayment":
      return "Lunas";
    default:
      return "Gagal";
  }
}
