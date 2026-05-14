import 'package:flutter/material.dart';
import 'package:sd_beach_quality/router.dart';
import 'package:sd_beach_quality/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await getIt.allReady();

  runApp(MaterialApp.router(routerConfig: router));
}
