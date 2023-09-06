import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/data/storage/models/slider_model.dart';
import 'package:healthline/res/style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
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
                    padding: EdgeInsets.symmetric(horizontal: dimensWidth()*2),
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                              child: Text(
                                AppLocalizations.of(context).translate("skip"),
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: color1F1F1F, fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                // if (currentIndex == slides.length - 1) {
                                //   Navigator.pushReplacementNamed(context, mainScreenId);
                                // } else {
                                //   _controller.nextPage(
                                //       duration: const Duration(milliseconds: 100),
                                //       curve: Curves.linear);
                                // }
                              },
                            ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return Slider(
                      image: slides[index].getImage(),
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
                          Navigator.pushReplacementNamed(context, mainScreenId);
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
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? primary : colorCDDEFF,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class Slider extends StatelessWidget {
  const Slider(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image given in slider
          Image(image: AssetImage(image), height: dimensImage()*50,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text.rich(TextSpan(
                        text: title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                        children: [
                      TextSpan(
                          text: "\n$description",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color6A6E83))
                    ])))
              ],
            ),
          )
        ],
      ),
    );
  }
}
