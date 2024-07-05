/* Main URL Endpoint */
const String MAIN_BASE_URL = "https://duluin.com/api";

/* Base URL Endpoint */
// const String BASE_URL =
//     "https://9818-118-99-116-244.ngrok-free.app/api"; // Local
const String BASE_URL = "https://dev.duluin.com/api"; // Staging
// const String BASE_URL = "https://dashboard.duluin.com/api"; // Production

/* Version API */
const VERS_1_API = '/v1';

/* Dynamic Page */
const String TERM_CONDITION_PAGE = "/meta/page?slug=term-and-conditions";
const String PRIVACY_POLICY_PAGE = "/meta/page?slug=privacy-policy";

/* Auth Endpoint */
const String SIGNUP_AUTH_CUSTOMER = "/auth/customer/signup";
const String SIGNIN_AUTH_CUSTOMER = "/auth/customer/signin";
const String FORGOT_PASSWORD_AUTH_CUSTOMER = "/auth/customer/forgot-password";
const String SIGNOUT_AUTH_CUSTOMER = "/auth/logout";
const String CHANGE_PASSWORD_AUTH_CUSTOMER = "/auth/change_password";

/* Verification Endpoint */
const String IDENTITY_UPLOAD_CUSTOMER =
    "$VERS_1_API/employees/account/identity_upload";
const String BASIC_INFORMATION_UPDATE_CUSTOMER =
    "$VERS_1_API/employees/account/form_account";
const String SEND_OTP_ENDPOINT = "/auth/customer/resend_verify";
const String SEND_OTP_WHATSAPP_ENDPOINT = "/auth/customer/resend_verify_phone";
const String VERIFY_OTP_ENDPOINT = "/auth/verify_otp";

/* Employee Endpoint */
const String EMPLOYEE_ACCOUNT_CUSTOMER = "$VERS_1_API/employees/account";
const String EMPLOYEE_ACCOUNT_USER_CUSTOMER =
    "$VERS_1_API/employees/account/user";
const String EMPLOYEE_WITHDRAW_CUSTOMER =
    "$VERS_1_API/employees/loans/withdraw";
const String UPDATE_USER_CUSTOMER =
    "$VERS_1_API/employees/account/form_account";

/* Loan Endpoint */
const String LOAN_CUSTOMER = "$VERS_1_API/employees/loans";
const String LOAN_HISTORY_CUSTOMER = "$VERS_1_API/employees/loans/history";

/* Current User Endpoint */
const String CURRENT_USER_CUSTOMER = "/user";

/* Companies Endpoint */
const String COMPANIES_ENDPOINT = "/meta/companies";

/* Promo Endpoint */
const String BANNER_ENDPOINT = "/promo";

/* Blog Endpoint */
const String BLOG_ENDPOINT = "/articles";

/* App Update Endpoint */
const String APP_UPDATE_ENDPOINT = "/app-version";
