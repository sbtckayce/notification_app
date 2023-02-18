import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notification/config/app_router.dart';
import 'package:notification/config/themes.dart';
import 'package:notification/db/db_helper.dart';
import 'package:notification/screens/screens.dart';
import 'package:notification/services/theme_service.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notification App',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      onGenerateRoute: AppRouter.onGenerateRoute ,
      initialRoute: '/',
    );
  }
}

