import 'package:duluin_app/views/auth/forgot-password.dart';
import 'package:duluin_app/views/auth/signin.dart';
import 'package:duluin_app/views/auth/signup.dart';
import 'package:duluin_app/views/auth/verify-email.dart';
import 'package:duluin_app/views/banners/detail-banner.dart';
import 'package:duluin_app/views/blog-page.dart';
import 'package:duluin_app/views/blog/detail-blog-page.dart';
import 'package:duluin_app/views/history-page.dart';
import 'package:duluin_app/views/loan/detail-loan-page.dart';
import 'package:duluin_app/views/loan/make-loan-page.dart';
import 'package:duluin_app/views/notification.dart';
import 'package:duluin_app/views/partials/bottom-navigation-bar.dart';
import 'package:duluin_app/views/profile-page.dart';
import 'package:duluin_app/views/profile/account-setting-page.dart';
import 'package:duluin_app/views/profile/change-password-page.dart';
import 'package:duluin_app/views/profile/company-information-page.dart';
import 'package:duluin_app/views/profile/contact-us-page.dart';
import 'package:duluin_app/views/signup/identity-upload-page.dart';
import 'package:duluin_app/views/signup/selfie-upload-page.dart';
import 'package:duluin_app/views/widgets/privacy-policy.dart';
import 'package:flutter/cupertino.dart';

import '../views/widgets/term-and-conditions.dart';

/*Auth*/
String signinRoute = '/login';
String signupRoute = '/signup';
String forgotPasswordRoute = '/password-recovery';
String verifyEmailPageRoute = '/verify-email';

/*Signup Information*/
String identityUploadPageRoute = '/dashboard/upload_identity_photo';
String selfieUploadPageRoute = '/dashboard/upload_selfie_photo';

/*Main*/
String bottomNavRoute = '/dashboard';
// String dashboardPageRoute = '/dashboard';
String historyPageRoute = '/dashboard/loan';
String blogPageRoute = '/dashboard/blog';
String profilePageRoute = '/dashboard/setting';

String notificationPageRoute = '/dashboard/notifications';
String detailBlogPageRoute = '/dashboard/blog/detail';
String detailBannerPageRoute = '/dashboard/banner/detail';

/*Loan*/
String withdrawPageRoute = '/dashboard/loan/withdraw';
String detailLoanPageRoute = '/dashboard/loan/detail';

/*Account*/
String accountSettingPageRoute = '/dashboard/setting/account';
String companyInformationPageRoute = '/dashboard/setting/company-information';
String changePasswordPageRoute = '/dashboard/setting/password';
String contactUsPageRoute = '/dashboard/setting/contact';

/*Page*/
String termConditionPageRoute = '/page/term-and-conditions';
String privacyPolicyPageRoute = '/page/privacy-policy';

Map<String, WidgetBuilder> routePages = {
  /*Render Page Auth*/
  signinRoute: (context) => const SigninPage(),
  signupRoute: (context) => const SignupPage(),
  forgotPasswordRoute: (context) => const ForgotPasswordPage(),
  verifyEmailPageRoute: (context) => const VerifyEmailPage(),

  /*Signup Information*/
  identityUploadPageRoute: (context) => const IdentityUploadPage(),
  selfieUploadPageRoute: (context) => const SelfieUploadPage(),

  /*Render Page Main*/
  bottomNavRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BottomNavigationPartial(initialPage: args['initialPage']);
  },
  // dashboardPageRoute: (context) => const DashboardPage(),
  historyPageRoute: (context) => const HistoryPage(),
  blogPageRoute: (context) => const BlogPage(),
  profilePageRoute: (context) => const ProfilePage(),

  notificationPageRoute: (context) => const NotificationPage(),
  detailBlogPageRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return DetailBlogPage(slug: args['slug']);
  },
  detailBannerPageRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return DetailBannerPage(slug: args['slug']);
  },

  /*Loan*/
  withdrawPageRoute: (context) => const MakeLoanPage(),
  detailLoanPageRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return DetailLoanPage(
        loanId: args['loanId'], loanAmount: args['loanAmount']);
  },

  /*Account*/
  accountSettingPageRoute: (context) => const AccountSettingPage(),
  companyInformationPageRoute: (context) => const CompanyInformationPage(),
  changePasswordPageRoute: (context) => const ChangePasswordPage(),
  contactUsPageRoute: (context) => const ContactUsPage(),

  /*Page*/
  termConditionPageRoute: (context) => const TermAndConditionPage(),
  privacyPolicyPageRoute: (context) => const PrivacyPolicyPage(),
};
