// ignore_for_file: constant_identifier_names

enum AuthState {
  Unauthorized,
  PatientAuthorized,
  DoctorAuthorized,
  // AllAuthorized
}

enum AppTheme { LightTheme, DartTheme }

enum DrawerMenu {
  Overview,
  Schedule,
  YourShift,
  Patient,
  AccountSetting,
  ApplicationSetting,
  Helps
}

enum SignUp { Instruction, Profile, Contact, Secutiry }

enum ScheduleTabBar { UpComing, Completed, Canceled }

enum PatientTabBar { Patient, Feedback }

enum CreateConsultation {TimeLine, MedicalRecord, FormMedicalDelaration, PaymentMethod, Invoice}

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
  Healthline,
  Momo,
}

enum BlocState {
  Pending,
  Successed,
  Failed,
}

enum Specialty {
  all,
  allergist, // Bác sĩ chuyên khoa dị ứng
  andrologist, // Bác sĩ nam khoa
  anesthesiologist, // Bác sĩ gây mê
  cardiologist, // Bác sĩ tim mạch
  dermatologist, // Bác sĩ da liễu
  endocrinologist, // Bác sĩ nội tiết
  epidemiologist, // Bác sĩ dịch tễ học
  gastroenterologist, // Bác sĩ chuyên khoa tiêu hóa
  gynaecologist, // Bác sĩ phụ khoa
  haematologist, // Bác sĩ huyết học
  hepatologist, // Bác sĩ chuyên khoa gan
  immunologist, // Bác sĩ chuyên khoa miễn dịch
  nephrologist, // Bác sĩ chuyên khoa thận
  neurologist, // Bác sĩ chuyên khoa thần kinh
  oncologist, // Bác sĩ chuyên khoa ung thư
  ophthalmologist, // Bác sĩ mắt
  orthopedist, // Bác sĩ ngoại chỉnh hình
  otorhinolaryngologist, // Bác sĩ tai mũi họng
  otolaryngologist, // Bác sĩ tai mũi họng
  pathologist, // Bác sĩ bệnh lý học
  proctologist, // Bác sĩ chuyên khoa hậu môn – trực tràng
  psychiatrist, // Bác sĩ chuyên khoa tâm thần
  radiologist, // Bác sĩ X-quang
  rheumatologist, // Bác sĩ chuyên khoa bệnh thấp
  traumatologist, // Bác sĩ chuyên khoa chấn thương
  obstetrician, // Bác sĩ sản khoa
  paeditrician // Bác sĩ nhi khoa
}
