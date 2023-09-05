import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                  // contents of slider
                  return Slider(
                    image: slides[index].getImage(),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            color: primary,
            child: TextButton(
              child: Text(
                currentIndex == slides.length - 1 ? "Continue" : "Next",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: white),
              ),
              onPressed: () {
                if (currentIndex == slides.length - 1) {
                  Navigator.pushReplacementNamed(context, mainScreenId);
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                }
              },
              // textColor: Colors.white,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(25),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primary,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  String image;

  Slider({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimensImage(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image given in slider
          Image(image: AssetImage(image)),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class SliderModel {
  String image;
  String title;
  String description;
  SliderModel({
    required this.image,
    required this.title,
    required this.description,
  });

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String getImage() {
    return image;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  SliderModel copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return SliderModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'image': image});
    result.addAll({'title': title});
    result.addAll({'description': description});

    return result;
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SliderModel(image: $image, title: $title, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SliderModel &&
        other.image == image &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = [];

  slides.add(SliderModel(
      image: "assets/images/onboarding_1.jpg",
      title: "title",
      description: "description"));
  slides.add(SliderModel(
      image: "assets/images/onboarding_2.jpg",
      title: "title",
      description: "description"));
  slides.add(SliderModel(
      image: "assets/images/onboarding_3.jpg",
      title: "title",
      description: "description"));
  slides.add(SliderModel(
      image: "assets/images/onboarding_4.jpg",
      title: "title",
      description: "description"));
  slides.add(SliderModel(
      image: "assets/images/onboarding_5.jpg",
      title: "title",
      description: "description"));
  slides.add(SliderModel(
      image: "assets/images/onboarding_6.jpg",
      title: "title",
      description: "description"));

  return slides;
}
