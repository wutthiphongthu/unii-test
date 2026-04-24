import 'package:flutter/widgets.dart';
import 'package:unii_test/app/app.dart';
import 'package:unii_test/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const UniiTestApp());
}
