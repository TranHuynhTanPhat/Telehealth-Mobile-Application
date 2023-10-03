import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerCustom {
  void openSettings() {
    openAppSettings();
  }

  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    if (result.isGranted) {
  
      return true;
    } 
    return false;
  }

  Future<File?> getImage() async {
    bool checkPermission = await requestFilePermission();
    
    if (checkPermission) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result != null) {
        final file = File(result.files.single.path!);
        return file;
      }
    }
    return null;
  }
}
