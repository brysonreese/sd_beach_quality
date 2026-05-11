import 'package:flutter/material.dart';
import 'package:sd_beach_quality/shell.dart';
import 'package:sd_beach_quality/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await getIt.allReady();

  runApp(const MaterialApp(home: Scaffold(body: Shell())));
}
