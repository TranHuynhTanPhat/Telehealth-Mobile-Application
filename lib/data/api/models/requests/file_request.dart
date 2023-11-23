import 'dart:convert';

class FileRequest {
  String? path;
  String? uploadPreset;
  String? publicId;
  String? folder;
  String? medicalId;
  FileRequest({
     this.path,
     this.uploadPreset,
     this.publicId,
     this.folder,
  });
  
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(path != null){
      result.addAll({'path': path});
    }
    if(uploadPreset != null){
      result.addAll({'upload_preset': uploadPreset});
    }
    if(publicId != null){
      result.addAll({'public_id': publicId});
    }
    if(folder != null){
      result.addAll({'folder': folder});
    }
  
    return result;
  }

  factory FileRequest.fromMap(Map<String, dynamic> map) {
    return FileRequest(
      path: map['path'],
      uploadPreset: map['upload_preset'],
      publicId: map['public_id'],
      folder: map['folder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FileRequest.fromJson(String source) => FileRequest.fromMap(json.decode(source));
}
