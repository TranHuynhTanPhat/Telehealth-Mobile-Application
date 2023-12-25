import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_doctor/patient/components/export.dart';
import 'package:healthline/utils/translate.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  PatientTabBar _currentIndex = PatientTabBar.Patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: Stack(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: dimensWidth()),
            children: [
              if (_currentIndex == PatientTabBar.Patient)
                Padding(
                  padding: EdgeInsets.only(
                    top: dimensHeight() * 10,
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3,
                  ),
                  child: const ListPatient(),
                )
              else if (_currentIndex == PatientTabBar.Feedback)
                 Padding(
                  padding: EdgeInsets.only(
                    top: dimensHeight() * 10,
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3,
                  ),
                  child: const ListFeedback(),
                )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  white,
                  white,
                  white,
                  Colors.white.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              height: dimensHeight() * 8,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(dimensWidth() * 3),
              ),
              padding: EdgeInsets.all(
                dimensWidth(),
              ),
              margin: EdgeInsets.only(
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3,
                  top: dimensHeight() * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            decoration: BoxDecoration(
                              color: _currentIndex == PatientTabBar.Patient
                                  ? primary
                                  : white,
                              borderRadius:
                                  BorderRadius.circular(dimensWidth() * 2),
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: _currentIndex == PatientTabBar.Patient
                                ? dimensWidth() * 6
                                : 0,
                            width: _currentIndex == PatientTabBar.Patient
                                ? dimensWidth() * 25
                                : 0,
                          ),
                        ),
                        SizedBox(
                          height: dimensHeight() * 6,
                          width: double.maxFinite,
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            enableFeedback: false,
                            onTap: () {
                              setState(() {
                                _currentIndex = PatientTabBar.Patient;
                              });
                            },
                            child: Center(
                              child: Text(
                                translate(context, 'patient'),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: _currentIndex ==
                                                PatientTabBar.Patient
                                            ? white
                                            : black26),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            decoration: BoxDecoration(
                              color: _currentIndex == PatientTabBar.Feedback
                                  ? primary
                                  : white,
                              borderRadius:
                                  BorderRadius.circular(dimensWidth() * 2),
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: _currentIndex == PatientTabBar.Feedback
                                ? dimensWidth() * 6
                                : 0,
                            width: _currentIndex == PatientTabBar.Feedback
                                ? dimensWidth() * 25
                                : 0,
                          ),
                        ),
                        SizedBox(
                          height: dimensHeight() * 6,
                          width: double.infinity,
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            enableFeedback: false,
                            onTap: () {
                              setState(() {
                                _currentIndex = PatientTabBar.Feedback;
                              });
                            },
                            child: Center(
                              child: Text(
                                translate(context, 'feedbacks'),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: _currentIndex ==
                                                PatientTabBar.Feedback
                                            ? white
                                            : black26),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
