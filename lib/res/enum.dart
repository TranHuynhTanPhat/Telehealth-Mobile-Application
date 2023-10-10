// ignore_for_file: constant_identifier_names

enum AuthState {
  Unauthorized,
  PatientAuthorized,
  DoctorAuthorized,
  AllAuthorized
}

enum AppTheme { LightTheme, DartTheme }

enum DrawerMenus { Overview, Schedule, Patient, AccountSetting,ApplicationSetting, Helps }

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
  Blood_pressure,
  Waist_cricumference,
}
