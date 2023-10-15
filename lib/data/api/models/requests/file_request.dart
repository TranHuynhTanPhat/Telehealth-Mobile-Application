import 'dart:convert';

class FileRequest {
  String imagePath;
  String uploadPreset;
  String publicId;
  String folder;
  FileRequest({
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

  factory FileRequest.fromMap(Map<String, dynamic> map) {
    return FileRequest(
      imagePath: map['imagePath'] ?? '',
      uploadPreset: map['upload_preset'] ?? '',
      publicId: map['public_id']??'',
      folder: map['folder']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileRequest.fromJson(String source) => FileRequest.fromMap(json.decode(source));
}
