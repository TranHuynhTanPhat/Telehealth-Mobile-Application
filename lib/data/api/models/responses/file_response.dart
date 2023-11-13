import 'dart:convert';

class FileResponse {
  String? assetId;
  String? publicId;
  int? version;
  String? versionId;
  String? signature;
  int? width;
  int? height;
  String? format;
  String? resourceType;
  String? createdAt;
  // List<String?>? tags;
  int? bytes;
  String? type;
  String? etag;
  bool? placeholder;
  String? url;
  String? secureUrl;
  String? folder;
  String? accessMode;
  bool? existing;
  String? originalFilename;

  FileResponse({
    this.assetId,
    this.publicId,
    this.version,
    this.versionId,
    this.signature,
    this.width,
    this.height,
    this.format,
    this.resourceType,
    this.createdAt,
    // this.tags,
    this.bytes,
    this.type,
    this.etag,
    this.placeholder,
    this.url,
    this.secureUrl,
    this.folder,
    this.accessMode,
    this.existing,
    this.originalFilename,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (assetId != null) {
      result.addAll({'asset_id': assetId});
    }
    if (publicId != null) {
      result.addAll({'public_id': publicId});
    }
    if (version != null) {
      result.addAll({'version': version});
    }
    if (versionId != null) {
      result.addAll({'version_id': versionId});
    }
    if (signature != null) {
      result.addAll({'signature': signature});
    }
    if (width != null) {
      result.addAll({'width': width});
    }
    if (height != null) {
      result.addAll({'height': height});
    }
    if (format != null) {
      result.addAll({'format': format});
    }
    if (resourceType != null) {
      result.addAll({'resource_type': resourceType});
    }
    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }
    // if(tags != null){
    //   result.addAll({'tags': tags});
    // }
    if (bytes != null) {
      result.addAll({'bytes': bytes});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (etag != null) {
      result.addAll({'etag': etag});
    }
    if (placeholder != null) {
      result.addAll({'placeholder': placeholder});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (secureUrl != null) {
      result.addAll({'secure_url': secureUrl});
    }
    if (folder != null) {
      result.addAll({'folder': folder});
    }
    if (accessMode != null) {
      result.addAll({'access_mode': accessMode});
    }
    if (existing != null) {
      result.addAll({'existing': existing});
    }
    if (originalFilename != null) {
      result.addAll({'original_filename': originalFilename});
    }

    return result;
  }

  factory FileResponse.fromMap(Map<String, dynamic> map) {
    return FileResponse(
      assetId: map['asset_id'],
      publicId: map['public_id'],
      version: map['version'],
      versionId: map['version_id'],
      signature: map['signature'],
      width: map['width'],
      height: map['height'],
      format: map['format'],
      resourceType: map['resource_type'],
      createdAt: map['created_at'],
      // tags : map['tags'].cast<String>(),
      bytes: map['bytes'],
      type: map['type'],
      etag: map['etag'],
      placeholder: map['placeholder'],
      url: map['url'],
      secureUrl: map['secure_url'],
      folder: map['folder'],
      accessMode: map['access_mode'],
      existing: map['existing'],
      originalFilename: map['original_filename'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FileResponse.fromJson(String source) =>
      FileResponse.fromMap(json.decode(source));
}
