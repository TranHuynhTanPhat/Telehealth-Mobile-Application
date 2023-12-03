// ignore_for_file: constant_identifier_names

enum AuthState {
  Unauthorized,
  PatientAuthorized,
  DoctorAuthorized,
  // AllAuthorized
}

enum AppTheme { LightTheme, DartTheme }

enum DrawerMenus {
  Overview,
  Schedule,
  YourShift,
  Patient,
  AccountSetting,
  ApplicationSetting,
  Helps
}

enum ScheduleTabBar { UpComing, Completed, Canceled }

enum Gender { Male, Female }

enum Role { Patient, Doctor }

enum Relationship {
  Children,
  Parent,
  Grandparent,
  Sibling,
}

enum BloodGroup {
  A,
  B,
  AB,
  O,
}

enum TypeHealthStat {
  Height,
  Weight,
  Heart_rate,
  Temperature,
  Blood_group,
  Head_cricumference,
}

enum PaymentMethod {
  None,
  Momo,
}
