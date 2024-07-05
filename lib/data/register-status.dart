import 'dart:ui';

import 'package:flutter/material.dart';

import '../contants/color.dart';

Color getRegisterStatusColor(String status) {
  switch (status) {
    case 'waiting':
      return WAITING_BG_COLOR;
    case 'approved_partner':
      return WAITING_BG_COLOR;
    case 'approved':
      return APPROVED_BG_COLOR;
    case 'revision':
      return REJECTED_BG_COLOR;
    default:
      return REJECTED_BG_COLOR;
  }
}

Color setTextStatusColor(String status) {
  switch (status) {
    case 'waiting':
      return Color(0xFF000000);
    case 'approved_partner':
      return Color(0xFF000000);
    case 'approved':
      return Color(0xFFFFFFFF);
    case 'revision':
      return Color(0xFFFFFFFF);
    default:
      return Color(0xFFFFFFFF);
  }
}

Icon setIconStatus(String status) {
  switch (status) {
    case 'waiting':
      return Icon(
        Icons.error_outline,
        color: setTextStatusColor(status),
      );
    case 'approved_partner':
      return Icon(
        Icons.error_outline,
        color: setTextStatusColor(status),
      );
    case 'approved':
      return Icon(
        Icons.check_circle_rounded,
        color: setTextStatusColor(status),
      );
    case 'revision':
      return Icon(
        Icons.error_outline,
        color: setTextStatusColor(status),
      );
    default:
      return Icon(
        Icons.error_outline,
        color: setTextStatusColor(status),
      );
  }
}

String getRegisterStatusText(String status) {
  switch (status) {
    case 'waiting':
      return 'Menunggu verifikasi oleh perusahaan Anda !';
    case 'approved_partner':
      return 'Sedang ditinjau dan menunggu verifikasi oleh tim kami !';
    case 'approved':
      return 'Selamat akun kamu telah terverifikasi, silahkan tarik gajimu !';
    case 'revision':
      return 'Silahkan lengkapi data diri anda !';
    default:
      return 'Silahkan lengkapi data diri anda !';
  }
}
