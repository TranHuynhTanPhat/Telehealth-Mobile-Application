import 'dart:convert';

import 'package:healthline/res/style.dart';

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
      image: DImages.onboarding1,
      title: "Find your best specialists and clinics",
      description:
          "Doctors from all over Vietnam are always ready to provide medical advice for you."));
  slides.add(SliderModel(
      image: DImages.onboarding2,
      title: "Answer all health questions",
      description:
          "You can get answers to all your health-related questions through forums or by directly consulting with a doctor."));
  slides.add(SliderModel(
      image: DImages.onboarding3,
      title: "Schedule online appointment easily",
      description:
          "Select the specialist and make appointment throught our app."));
  slides.add(SliderModel(
      image: DImages.onboarding4,
      title: "Health service",
      description:
          "We provide a wide range of health-related services with the collaboration of doctors."));
  slides.add(SliderModel(
      image: DImages.onboarding5,
      title: "Limit direct contact",
      description:
          "This helps reduce the risk of disease transmission in crowded places like hospitals."));
  slides.add(SliderModel(
      image: DImages.onboarding6,
      title: "Security",
      description:
          "Your personal and health information will be kept highly confidential."));

  return slides;
}
