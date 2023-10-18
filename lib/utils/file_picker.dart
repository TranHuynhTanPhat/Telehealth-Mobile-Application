import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerCustom {
  void openSettings() {
    openAppSettings();
  }

  Future<bool> checkStoragePermission() async {
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      return Permission.storage.isGranted;
    } else {
      return Permission.photos.isGranted;
    }
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }
    return result.isGranted;
  }

  Future<File?> getImage() async {
    bool checkPermission = await checkStoragePermission();

    if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");
      return await _openGallery();
    } else {
      logPrint("NOT PERMISSION FOR GALLERY");
      checkPermission = await requestStoragePermission();
      if (checkPermission) {
        logPrint("PERMISSION FOR GALLERY");

        return _openGallery();
      }
    }
    return null;
  }

  Future<File?> _openGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

  Future<PlatformFile?> chooseFile() async {
    bool checkPermission = await checkStoragePermission();

    if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");
      return await _openFolder();
    } else {
      logPrint("NOT PERMISSION FOR GALLERY");
      checkPermission = await requestStoragePermission();
      if (checkPermission) {
        logPrint("PERMISSION FOR GALLERY");

        return _openFolder();
      }
    }
    return null;
  }

  Future<PlatformFile?> _openFolder() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'doc',
          'docx',
          'xls',
          'xlsx',
          'csv',
          'pdf',
          'gif',
          'jpeg',
          'jpg',
          'png',
          '3gp',
          'asf',
          'avi',
          'm4u',
          'm4v',
          'mov',
          'mp4',
          'mpe',
          'mpeg',
          'mpg',
          'mpg4',
          'pps',
          'ppt',
          'pptx'
        ],
        allowMultiple: false);

    if (result != null) {
      return result.files.single;
    }
    return null;
  }
}
