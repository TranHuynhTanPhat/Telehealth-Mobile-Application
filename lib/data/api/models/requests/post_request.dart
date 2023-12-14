import 'dart:io';

import 'package:healthline/data/api/models/responses/post_response.dart';

class PostRequest {
  final List<File?> files;
  final PostResponse dto;

  PostRequest({required this.files, required this.dto});
}
