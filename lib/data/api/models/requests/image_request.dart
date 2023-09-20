import 'dart:convert';

class ImageRequest {
  String imagePath;
  String uploadPreset;
  ImageRequest({
    required this.imagePath,
    required this.uploadPreset,
  });
  


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'imagePath': imagePath});
    result.addAll({'uploadPreset': uploadPreset});
  
    return result;
  }

  factory ImageRequest.fromMap(Map<String, dynamic> map) {
    return ImageRequest(
      imagePath: map['imagePath'] ?? '',
      uploadPreset: map['uploadPreset'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageRequest.fromJson(String source) => ImageRequest.fromMap(json.decode(source));
}
