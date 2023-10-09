import 'dart:convert';

class ImageRequest {
  String imagePath;
  String uploadPreset;
  String publicId;
  String folder;
  ImageRequest({
    required this.imagePath,
    required this.uploadPreset,
    required this.publicId,
    required this.folder,
  });
  


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'imagePath': imagePath});
    result.addAll({'upload_preset': uploadPreset});
    result.addAll({'public_id': publicId});
    result.addAll({'folder': folder});
  
    return result;
  }

  factory ImageRequest.fromMap(Map<String, dynamic> map) {
    return ImageRequest(
      imagePath: map['imagePath'] ?? '',
      uploadPreset: map['upload_preset'] ?? '',
      publicId: map['public_id']??'',
      folder: map['folder']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageRequest.fromJson(String source) => ImageRequest.fromMap(json.decode(source));
}
