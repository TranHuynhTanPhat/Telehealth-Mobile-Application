import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerCustom {
  void openSettings() {
    openAppSettings();
  }

  Future<bool> checkGalleryPermission() async {
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      logPrint("AHJDK");
      return Permission.storage.isGranted;
    } else {
      return Permission.photos.isGranted;
    }
  }

  Future<bool> requestGalleryPermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      logPrint("fdsjflskdjflds");
      result = await Permission.storage.request();
      logPrint(result);

    } else {
      result = await Permission.photos.request();
    }
    return result.isGranted;
  }

  Future<File?> getImage() async {
    bool checkPermission = await checkGalleryPermission();

    if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");
      return await openGallery();
    } else {
      logPrint("NOT PERMISSION FOR GALLERY");
      checkPermission = await requestGalleryPermission();
      if (checkPermission) {
      logPrint("PERMISSION FOR GALLERY");

        return openGallery();
      }
    }
    return null;
  }

  Future<File?> openGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}
