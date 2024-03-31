// ignore_for_file: constant_identifier_names

class ApiConstants {
  // CLOUDINARY
  static const UPLOAD = '/upload';

// common
  static const _COMMON_USER = '/common/user';
  static const _COMMON_DOCTOR = '/common/doctor';

  /// dont need cookie
  static const USER_LOG_IN = '$_COMMON_USER/auth';
  static const DOCTOR_LOG_IN = '$_COMMON_DOCTOR/auth';

  /// need cookie
  static const USER_REFRESH_TOKEN = '$_COMMON_USER/refresh';
  static const USER_LOG_OUT = '$_COMMON_USER/logout';
  static const DOCTOR_REFRESH_TOKEN = '$_COMMON_DOCTOR/refresh';
  static const DOCTOR_LOG_OUT = '$_COMMON_DOCTOR/logout';

// user-management
  static const _USER = '/user-management';
  static const USER = '$_USER/user';
  static const USER_EMAIL = '$USER/email';
  static const USER_PASSWORD = '$USER/password';
  static const USER_FORGOT_PASSWORD = '$USER/forget-password';
  static const USER_FORGOT_PASSWORD_RESET = '$USER/reset-password-forgot';
  static const USER_MEDICAL_RECORD = '$_USER/medical-record';
  static const USER_WISH_LIST = '$USER/wish-list';

// doctor-management
  static const _DOCTOR = '/doctor-management';
  static const DOCTOR = '$_DOCTOR/doctor';
  static const DOCTOR_PASSWORD = '$DOCTOR/password';
  static const DOCTOR_FORGOT_PASSWORD = '$DOCTOR/forget-password';
  static const DOCTOR_FORGOT_PASSWORD_RESET = '$DOCTOR/reset-password-forgot';
  static const DOCTOR_CHANGE_AVATAR = '$DOCTOR/avatar';
  static const DOCTOR_CHANGE_BIOGRAPHY = '$DOCTOR/biography';
  static const DOCTOR_CHANGE_EMAIL = '$DOCTOR/email';
  static const DOCTOR_CHANGE_FIXED_TIMES = '$DOCTOR/fixed-times';
  static const DOCTOR_LIST = '$DOCTOR/list';
  static const DOCTOR_SCHEDULE = '$_DOCTOR/schedule';
  static const DOCTOR_SCHEDULE_CRON = '$DOCTOR_SCHEDULE/cron';

// patient-record
  static const _PATIENT = '/patient-record';
  static const PATIENT_HEALTH_STAT = '$_PATIENT/health-stat';
  static const PATIENT_RECORD = '$_PATIENT/record';

  // vaccination
  static const _VACCINATION = '/vaccination';
  static const VACCINATION_RECORD = '$_VACCINATION/record';
  static const VACCINATION_VACCINE = '$_VACCINATION/vaccine';

  // forum
  static const _FORUM = '/health-forum';
  static const FORUM_POST = '$_FORUM/posts';



  // consultation
  static const CONSULTATION = '/consultation';
  static const CONSULTATION_FEEDBACK = '$CONSULTATION/feedback';
  static const CONSULTATION_USER = '$CONSULTATION/user';
  static const CONSULTATION_DOCTOR = '$CONSULTATION/doctor';
  static const CONSULTATION_DOCTOR_CONSULTATION = '$CONSULTATION_DOCTOR/consultation';
  static const CONSULTATION_DOCTOR_DASHBOARD = '$CONSULTATION_DOCTOR/doctor/dashboard';
  static const CONSULTATION_DOCTOR_INFORMATION = '$CONSULTATION_DOCTOR/information';

  // file-upload
  static const _FILE_UPLOAD = '/file-upload';
  static const UPLOAD_AVATAR_DOCTOR = '$_FILE_UPLOAD/doctor/avatar';
  static const UPLOAD_AVATAR_USER = '$_FILE_UPLOAD/user/avatar';
  static const UPLOAD_RECORD = '$_FILE_UPLOAD/user/record';
  static const UPLOAD_POST = '$_FILE_UPLOAD/post';
}
