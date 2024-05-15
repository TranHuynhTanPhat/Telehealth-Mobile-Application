import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/requests/doctor_detail_request.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/auth/register_doctor/components/export.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({super.key});

  @override
  State<RegisterDoctorScreen> createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final CarouselController _carouselController = CarouselController();

  // late AnimationController _animationController;
  // late Animation<double> animationProfile;
  // late Animation<double> animationContact;
  // late Animation<double> animationSecurity;

  /// Personal Data Form

  /// Specialty

  /// Career

  late DoctorDetailRequest doctorDetailRequest;

  int currentPage = 0;
  bool completedForm1 = false;
  bool completedForm2 = false;
  bool completedForm3 = false;
  bool completedForm4 = false;

  final List<Map<String, dynamic>> formTitle = [
    {
      "icon": FontAwesomeIcons.person,
      "title": 'personal_data',
    },
    {
      "icon": FontAwesomeIcons.graduationCap,
      "title": 'education_and_certifications',
    },
    {
      "icon": FontAwesomeIcons.addressCard,
      "title": "specialty",
    },
    {
      "icon": FontAwesomeIcons.userDoctor,
      "title": "career",
    },
  ];
  @override
  void initState() {
    doctorDetailRequest = DoctorDetailRequest();
    super.initState();
  }

  void updateDoctorDetail({
    String? id,
    String? fullName,
    String? phone,
    String? gender,
    String? dayOfBirth,
    String? email,
    String? address,
    List<List<int>>? fixedTime,
    double? ratings,
    String? avatar,
    String? biography,
    int? feePerMinutes,
    int? accountBalance,
    int? numberOfConsultation,
    String? updatedAt,
    List<EducationAndCertificationModelRequest>? educationAndCertifications,
    List<SpecialtyModelRequest>? specialties,
    List<CareerModelRequest>? careers,
  }) {
    doctorDetailRequest = doctorDetailRequest.copyWith(
      id: id ?? doctorDetailRequest.id,
      fullName: fullName ?? doctorDetailRequest.fullName,
      phone: phone ?? doctorDetailRequest.phone,
      gender: gender ?? doctorDetailRequest.gender,
      dayOfBirth: dayOfBirth ?? doctorDetailRequest.dayOfBirth,
      email: email ?? doctorDetailRequest.email,
      address: address ?? doctorDetailRequest.address,
      fixedTime: fixedTime ?? doctorDetailRequest.fixedTime,
      ratings: ratings ?? doctorDetailRequest.ratings,
      avatar: avatar ?? doctorDetailRequest.avatar,
      biography: biography ?? doctorDetailRequest.biography,
      feePerMinutes: feePerMinutes ?? doctorDetailRequest.feePerMinutes,
      accountBalance: accountBalance ?? doctorDetailRequest.accountBalance,
      numberOfConsultation:
          numberOfConsultation ?? doctorDetailRequest.numberOfConsultation,
      updatedAt: updatedAt ?? doctorDetailRequest.updatedAt,
      educationAndCertifications: educationAndCertifications ??
          doctorDetailRequest.educationAndCertifications,
      specialties: specialties ?? doctorDetailRequest.specialties,
      careers: careers ?? doctorDetailRequest.careers,
    );
  }

  Future<void> backPressed() async {
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    await _carouselController.previousPage();

    await modelBottomSheet();
  }

  Future<void> nextPressed(int x) async {
    // ignore: use_build_context_synchronously
    if (x == 0) completedForm1 = true;
    if (x == 1) completedForm2 = true;
    if (x == 2) completedForm3 = true;
    if (x == 3) completedForm4 = true;
    Navigator.pop(context);
    if (currentPage < 3) {
      await _carouselController.nextPage();
      await modelBottomSheet();
    }
    setState(() {});
  }

  Future<void> modelBottomSheet() async {
    completedForm1 = currentPage == 0 ? false : completedForm1;
    completedForm2 = currentPage == 1 ? false : completedForm2;
    completedForm3 = currentPage == 2 ? false : completedForm3;
    completedForm4 = currentPage == 3 ? false : completedForm4;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        DoctorCubit doctorCubit = context.read<DoctorCubit>();
        return BlocProvider(
          create: (context) => doctorCubit,
          child: DraggableScrollableSheet(
            expand: false,
            minChildSize: .2,
            maxChildSize: .9,
            initialChildSize: .9,
            shouldCloseOnMinExtent: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(ctx),
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: transparent,
                  extendBody: true,
                  body: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight()),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          dimensWidth() * 4,
                        ),
                        topRight: Radius.circular(dimensWidth() * 4),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                      shrinkWrap: false,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: dimensHeight() * 3,
                                    top: dimensHeight() * 2),
                                child: Text(
                                  translate(
                                    context,
                                    formTitle[currentPage]["title"],
                                  ),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (currentPage == 0)
                          PersonalDataForm(
                            nextPressed: nextPressed,
                            updateDoctorDetail: updateDoctorDetail,
                            doctorDetailRequest: doctorDetailRequest,
                          )
                        else if (currentPage == 1)
                          EducationAndCertificationsForm(
                            nextPressed: nextPressed,
                            backPressed: backPressed,
                            doctorDetailRequest: doctorDetailRequest,
                            updateDoctorDetail: updateDoctorDetail,
                          ),
                        if (currentPage == 2)
                          SpecialtyForm(
                            nextPressed: nextPressed,
                            backPressed: backPressed,
                            doctorDetailRequest: doctorDetailRequest,
                            updateDoctorDetail: updateDoctorDetail,
                          ),
                        if (currentPage == 3)
                          CareerForm(
                            backPressed: backPressed,
                            doctorDetailRequest: doctorDetailRequest,
                            updateDoctorDetail: updateDoctorDetail,
                            nextPressed: nextPressed,
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
    ).then((value) {
      // currentPage = value ?? currentPage;
      if (value != currentPage && value != null) {
        _carouselController.jumpToPage(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      extendBody: true,
      bottomSheet: GestureDetector(
        onTap: () => modelBottomSheet(),
        onVerticalDragStart: (details) => modelBottomSheet(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3,
            vertical: dimensHeight() * 2,
          ),
          height: dimensHeight() * 12.8,
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                dimensWidth() * 4,
              ),
              topRight: Radius.circular(dimensWidth() * 4),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  translate(
                    context,
                    formTitle[currentPage]["title"],
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            items: [
              ...formTitle.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: primary),
                            borderRadius: BorderRadius.circular(360),
                          ),
                          width: dimensIcon() * 5,
                          height: dimensIcon() * 5,
                          child: FaIcon(
                            e["icon"],
                            size: dimensIcon() * 3,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 2,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              reverse: false,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                        vertical: dimensHeight() * 2,
                        horizontal: dimensWidth() * 2.5),
                  ),
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor: const MaterialStatePropertyAll(white),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                      side: BorderSide(width: 1, color: primary),
                    ),
                  ),
                ),
                onPressed: () {
                  _carouselController.previousPage();
                  if (currentPage == 0) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  translate(context, "back"),
                ),
              ),
              if (currentPage < 3)
                ElevatedButtonWidget(
                    text: translate(context, 'next'),
                    onPressed: () {
                      _carouselController.nextPage();
                    }),
              if (currentPage == 3)
                if (completedForm1 &&
                    completedForm2 &&
                    completedForm3 &&
                    completedForm4)
                  ElevatedButtonWidget(
                      text: translate(context, 'sign_up'),
                      onPressed: () {
                        context.read<AuthenticationCubit>().registerDoctor(
                            doctorDetailRequest: doctorDetailRequest.copyWith(
                                fixedTime: [[],[],[],[],[],[],[]],
                                phone: Validate().changePhoneFormat(
                                    doctorDetailRequest.phone!)));
                      }),
            ],
          ),
        ],
      ),
    );
  }
}
