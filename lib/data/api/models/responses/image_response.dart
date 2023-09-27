class ImageResponse {
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
  List<String>? tags;
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

  ImageResponse(
      {this.assetId,
      this.publicId,
      this.version,
      this.versionId,
      this.signature,
      this.width,
      this.height,
      this.format,
      this.resourceType,
      this.createdAt,
      this.tags,
      this.bytes,
      this.type,
      this.etag,
      this.placeholder,
      this.url,
      this.secureUrl,
      this.folder,
      this.accessMode,
      this.existing,
      this.originalFilename});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    publicId = json['public_id'];
    version = json['version'];
    versionId = json['version_id'];
    signature = json['signature'];
    width = json['width'];
    height = json['height'];
    format = json['format'];
    resourceType = json['resource_type'];
    createdAt = json['created_at'];
    tags = json['tags'].cast<String>();
    bytes = json['bytes'];
    type = json['type'];
    etag = json['etag'];
    placeholder = json['placeholder'];
    url = json['url'];
    secureUrl = json['secure_url'];
    folder = json['folder'];
    accessMode = json['access_mode'];
    existing = json['existing'];
    originalFilename = json['original_filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asset_id'] = assetId;
    data['public_id'] = publicId;
    data['version'] = version;
    data['version_id'] = versionId;
    data['signature'] = signature;
    data['width'] = width;
    data['height'] = height;
    data['format'] = format;
    data['resource_type'] = resourceType;
    data['created_at'] = createdAt;
    data['tags'] = tags;
    data['bytes'] = bytes;
    data['type'] = type;
    data['etag'] = etag;
    data['placeholder'] = placeholder;
    data['url'] = url;
    data['secure_url'] = secureUrl;
    data['folder'] = folder;
    data['access_mode'] = accessMode;
    data['existing'] = existing;
    data['original_filename'] = originalFilename;
    return data;
  }
}
