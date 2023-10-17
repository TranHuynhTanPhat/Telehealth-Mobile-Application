import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/utils/translate.dart';
import 'package:restart_app/restart_app.dart';

import 'components/export.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(translate(context, 'downloading')),
        actions: const [LoadingIndicator()],
      ),
    );
  }

  Future<void> _downloadUpdate() async {
    _showDownloadingBanner();

    await Future.wait([
      AppController.instance.shorebirdCodePush.downloadUpdateIfAvailable(),
      // Add an artificial delay so the banner has enough time to animate in.
      Future<void>.delayed(const Duration(milliseconds: 250)),
    ]);

    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    _showRestartBanner();
  }

  void _showRestartBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(translate(context, 'a_new_patch_is_ready')),
        actions: [
          TextButton(
            // Restart the app for the new patch to take effect.
            onPressed: Restart.restartApp,
            child: Text(translate(context, 'restart_app')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ApplicationUpdateCubit, ApplicationUpdateState>(
      listener: (context, state) {
        if (state is UpdateAvailable) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate(context, 'update_available')),
            ),
          );
        } else if (state is UpdateUnavailable) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate(context, 'no_update_available')),
            ),
          );
        }
      },
      child: BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
        builder: (context, state) {
          final heading = state.currentPatchVersion != null
              ? '${state.currentPatchVersion}'
              : translate(context, 'no_patch_installed');
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.colorScheme.inversePrimary,
              title: Text(translate(context, 'update_application')),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(translate(context, 'current_patch_version')),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          heading,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (!state.isShorebirdAvailable)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            translate(
                                context, 'cant_connect_to_current_version'),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  if (state.isShorebirdAvailable)
                    if (state is UpdateAvailable)
                      ElevatedButton(
                        onPressed: () async {
                          await _downloadUpdate();
                          if (!mounted) return;
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                        },
                        child: Text(translate(context, 'update_now')),
                      )
                    else
                      ElevatedButton(
                        onPressed: state.isCheckingForUpdate
                            ? null
                            : () => context
                                .read<ApplicationUpdateCubit>()
                                .checkForUpdate(),
                        child: state.isCheckingForUpdate
                            ? const LoadingIndicator()
                            : Text(translate(context, 'check_for_update')),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
