part of 'application_update_cubit.dart';

sealed class ApplicationUpdateState {
  ApplicationUpdateState(
      {this.isShorebirdAvailable = false,
      this.currentPatchVersion,
      this.isCheckingForUpdate = false});
  final bool isShorebirdAvailable;
  final int? currentPatchVersion;
  final bool isCheckingForUpdate;
}

final class ApplicationUpdateInitial extends ApplicationUpdateState {
  ApplicationUpdateInitial(
      {super.isShorebirdAvailable,
      super.currentPatchVersion,
      super.isCheckingForUpdate});
}

final class UpdateAvailable extends ApplicationUpdateState {
  UpdateAvailable(
      {super.isCheckingForUpdate,
      super.currentPatchVersion,
      super.isShorebirdAvailable});
}

final class UpdateUnavailable extends ApplicationUpdateState {
  UpdateUnavailable(
      {super.isCheckingForUpdate,
      super.currentPatchVersion,
      super.isShorebirdAvailable});
}

final class Downloading extends ApplicationUpdateState {
  Downloading(
      {super.isCheckingForUpdate,
      super.currentPatchVersion,
      super.isShorebirdAvailable});
}

final class DownloadUpdateSuccessfully extends ApplicationUpdateState {
  DownloadUpdateSuccessfully(
      {super.isCheckingForUpdate,
      super.currentPatchVersion,
      super.isShorebirdAvailable});
}
