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
      bool grand1 = await Permission.storage.isGranted;
      bool grand2 = await Permission.mediaLibrary.isGranted;
      return grand1 ||
          grand2;
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
      result = await Permission.mediaLibrary.request();
    } else {
      result = await Permission.photos.request();
    }
    return result.isGranted;
  }

  Future<File?> getImage() async {
    bool checkPermission = await checkStoragePermission();

    if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");
      return await _openGallery().then((value) => value.first);
    } else {
      logPrint("NOT PERMISSION FOR GALLERY");
      checkPermission = await requestStoragePermission();
      if (checkPermission) {
        logPrint("PERMISSION FOR GALLERY");

        return await _openGallery().then((value) => value.first);
      }
    }
    return null;
  }

  Future<List<File?>> getImages() async {
    bool checkPermission = await checkStoragePermission();

    if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");
      return await _openGallery(allowMultiple: true);
    } else {
      logPrint("NOT PERMISSION FOR GALLERY");
      checkPermission = await requestStoragePermission();
      if (checkPermission) {
        logPrint("PERMISSION FOR GALLERY");

        return await _openGallery(allowMultiple: true);
      }
    }
    return [];
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

  Future<List<File?>> _openGallery({allowMultiple = false}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: allowMultiple);

    if (result != null) {
      if (allowMultiple) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        while (files.length > 5) {
          files.removeLast();
        }
        return files;
      }
      final file = File(result.files.single.path!);
      return [file];
    }
    return [];
  }

  Future<PlatformFile?> _openFolder() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'doc',
          'docx',
          // 'xls',
          // 'xlsx',
          // 'csv',
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
          // 'pps',
          // 'ppt',
          // 'pptx'
        ],
        allowMultiple: false);

    if (result != null) {
      return result.files.single;
    }
    return null;
  }
}
