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
  static const USER_MEDICAL_RECORD = '$_USER/medical-record';

// doctor-management
  static const _DOCTOR = '/doctor-management';
  static const DOCTOR = '$_DOCTOR/doctor';
  static const DOCTOR_CHANGE_AVATAR = '$DOCTOR/avatar';
  static const DOCTOR_CHANGE_BIOGRAPHY = '$DOCTOR/biography';
  static const DOCTOR_CHANGE_FIXED_TIMES = '$DOCTOR/fixed-times';
  static const DOCTOR_SCHEDULE = '$_DOCTOR/schedule';

// patient-record
  static const _PATIENT = '/patient-record';
  static const PATIENT_HEALTH_STAT = '$_PATIENT/health-stat';
  static const PATIENT_RECORD = '$_PATIENT/record';

  // vaccination
  static const _VACCINATION = '/vaccination';
  static const VACCINATION_RECORD = '$_VACCINATION/record';
  static const VACCINATION_VACCINE = '$_VACCINATION/vaccine';
}
