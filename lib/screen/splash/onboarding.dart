import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/splash/components/exports.dart';
import 'package:healthline/utils/translate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PreloadPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PreloadPageController(initialPage: 0);
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(
                        translate(context, 'skip'),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: color1F1F1F, fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, signUpName);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PreloadPageView.builder(
                  controller: _controller,
                  preloadPagesCount: 6,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return SliderWidget(
                      fileName: 'img_onboarding_${index + 1}',
                      title: translate(context, 'ob_title_${index + 1}'),
                      description:
                          translate(context, 'ob_description_${index + 1}'),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
              height: dimensHeight() * 20,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentIndex == 0
                      ? SizedBox(
                          width: dimensIcon(),
                        )
                      : InkWell(
                          borderRadius: BorderRadius.circular(180),
                          child: Container(
                            padding: EdgeInsets.all(dimensWidth()),
                            child: const FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              color: primary,
                            ),
                          ),
                          onTap: () {
                            if (currentIndex == 5) {
                              Navigator.pushReplacementNamed(
                                  context, signUpName);
                            } else {
                              _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn);
                            }
                          },
                        ),
                  const Spacer(),
                  ...List.generate(
                    6,
                    (index) => buildDot(index, context),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(180),
                    child: Container(
                      padding: EdgeInsets.all(dimensWidth()),
                      child: const FaIcon(
                              FontAwesomeIcons.chevronRight,
                              color: primary,
                            ),
                    ),
                    onTap: () {
                      if (currentIndex == 5) {
                        Navigator.pushReplacementNamed(context, signUpName);
                      } else {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      height: dimensWidth(),
      width: currentIndex == index ? dimensWidth() * 2 : dimensWidth(),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
        color: currentIndex == index ? primary : colorCDDEFF,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
