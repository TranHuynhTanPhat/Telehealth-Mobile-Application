// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/utils/log_data.dart';

part 'application_update_state.dart';

class ApplicationUpdateCubit extends Cubit<ApplicationUpdateState> {
  ApplicationUpdateCubit()
      : super(ApplicationUpdateInitial(
          isShorebirdAvailable:
              AppController.instance.shorebirdCodePush.isShorebirdAvailable(),
        ));

  @override
  void onChange(Change<ApplicationUpdateState> change) {
    super.onChange(change);
    logPrint(change);
  }

  final _shorebirdCodePush = AppController.instance.shorebirdCodePush;

  void requestCurrentPatchNumber() {
    // Request the current patch number.
    _shorebirdCodePush.currentPatchNumber().then((currentPatchVersion) {
      emit(ApplicationUpdateInitial(
          isShorebirdAvailable: state.isShorebirdAvailable,
          currentPatchVersion: currentPatchVersion,
          isCheckingForUpdate: state.isCheckingForUpdate));
    });
  }

  void checkForUpdate() async {
    emit(ApplicationUpdateInitial(
        isShorebirdAvailable: state.isShorebirdAvailable,
        currentPatchVersion: state.currentPatchVersion,
        isCheckingForUpdate: true));
    // Ask the Shorebird servers if there is a new patch available.
    final isUpdateAvailable =
        await _shorebirdCodePush.isNewPatchAvailableForDownload();

    emit(ApplicationUpdateInitial(
        isShorebirdAvailable: state.isShorebirdAvailable,
        currentPatchVersion: state.currentPatchVersion,
        isCheckingForUpdate: false));

    if (isUpdateAvailable) {
      emit(UpdateAvailable(
          isShorebirdAvailable: state.isShorebirdAvailable,
          currentPatchVersion: state.currentPatchVersion,
          isCheckingForUpdate: state.isCheckingForUpdate));
    } else {
      emit(UpdateUnavailable(
          isShorebirdAvailable: state.isShorebirdAvailable,
          currentPatchVersion: state.currentPatchVersion,
          isCheckingForUpdate: state.isCheckingForUpdate));
    }
  }
}
