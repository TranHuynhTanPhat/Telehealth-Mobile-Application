import 'package:flutter/material.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/data/storage/models/slider_model.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/splash/components/exports.dart';
import 'package:healthline/utils/translate.dart';
import 'package:preload_page_view/preload_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  late PreloadPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PreloadPageController(initialPage: 0);
    // _controller.animateToPage(currentIndex,
    //     duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    slides = getSlides();
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
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return SliderWidget(
                      fileName: slides[index].getFileName(),
                      title: slides[index].getTitle(),
                      description: slides[index].getDescription(),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 2, vertical: dimensHeight() * 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: dimensWidth() * 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primary,
                      ),
                      iconSize: dimensIcon(),
                      onPressed: () {
                        if (currentIndex == slides.length - 1) {
                          Navigator.pushReplacementNamed(context, signUpName);
                        } else {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.linear);
                        }
                      },
                    ),
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
