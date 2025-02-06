import 'dart:async';
import 'package:balloon_puzzle_factory/src/core/dependency_injection.dart';
import 'package:balloon_puzzle_factory/src/feature/app/presentation/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_amplitude/core_amplitude.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xor_dart/xor_dart.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setupDependencyInjection();

    await InitializationUtil.coreInit(
      domain: 'Dg0AAAMDAhwZFhYACQoNDxgDHhVCDwMB',
      amplitudeKey: '4b5bf4f36324b76caccc56491e467bf2',
      appId: 'com.gerberlife.balloonfactory',
      iosAppId: '6741427418',
      initialRoute: '/home',
      appName: 'Balloon Puzzle Factory',
      apiEndpoint: 'SFRUUFMaDw9JTg5CQUxMT09OUFVaWkxFRkFDVE9SWQ5DT00P',
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      const AppRoot(),
    );
  }, (Object error, StackTrace stackTrace) {
    _handleAsyncError(error, stackTrace);
  });
}

void _handleFlutterError(FlutterErrorDetails details) {
  AmplitudeUtil.logFailure(
    details.exception is Exception ? Failure.exception : Failure.error,
    details.exception.toString(),
    details.stack,
  );
}

void _handleAsyncError(Object error, StackTrace stackTrace) {
  AmplitudeUtil.logFailure(
    error is Exception ? Failure.exception : Failure.error,
    error.toString(),
    stackTrace,
  );
}
