import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hippo/base/base_controller.dart';
import 'package:hippo/generated/l10n.dart';
import 'package:hippo/ui/dashboard/dashboard.dart';
import 'package:hippo/utils/styling.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => LayoutBuilder(
        builder: (context, constraints) {
          return GetMaterialApp(
            localizationsDelegates: [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
            theme: AppThemes.theme(),
            darkTheme: AppThemes.darktheme(),
            themeMode: AppThemes().init(),
            locale: MyTranslations.locale,
            fallbackLocale: MyTranslations.fallbackLocale,
            translations: MyTranslations(),
            initialRoute: RouterName.dashboard,
            debugShowCheckedModeBanner: false,
            getPages: Pages.pages(),
          );

          return MaterialApp(
            localizationsDelegates: [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              accentColor: AppTheme.appBarCoin,
            ),
            debugShowCheckedModeBanner: false,
            home: DashboardScreen(),
          );
        },
      ),
    );
  }
}
