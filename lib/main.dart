import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:golf_social/pages/auth_page.dart';
import 'firebase_options.dart';
import 'package:golf_social/components/constants.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.FINEST;

  // Get the path to the directory where you can write the log file
  final directory = await getApplicationDocumentsDirectory();
  final logFile = File('${directory.path}/app.log');

  Logger.root.onRecord.listen((record) async {
    final logMessage =
        '${record.level.name}: ${record.time}: ${record.message}';
    if (kReleaseMode) {
      // Append the log message to the log file in production mode
      await logFile.writeAsString('$logMessage\n', mode: FileMode.append);
    } else {
      // Output the log message to the console in development mode
      print(logMessage);
    }
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: primaryGrey,
        scaffoldBackgroundColor: Colors.white,
        dividerColor: primaryGrey,
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryLimeGreen,
          textTheme: ButtonTextTheme.primary,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryLimeGreen,
          selectionColor: primaryLimeGreen,
          selectionHandleColor: primaryLimeGreen,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
