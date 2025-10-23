import 'package:evently_c16_mon/core/providers/app_config_provider.dart';
import 'package:evently_c16_mon/core/theme/app_theme.dart';
import 'package:evently_c16_mon/firebase_options.dart';
import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';
import 'package:evently_c16_mon/ui/auth/forget_password_screen.dart';
import 'package:evently_c16_mon/ui/auth/login_screen.dart';
import 'package:evently_c16_mon/ui/auth/register_screen.dart';
import 'package:evently_c16_mon/ui/home/home_screen.dart';
import 'package:evently_c16_mon/ui/manage_events/manage_events_screen.dart';
import 'package:evently_c16_mon/ui/setup/setup_screen.dart';
import 'package:evently_c16_mon/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      builder: (context, child) {
        var provider = Provider.of<AppConfigProvider>(context);
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.locale),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: provider.appTheme,
          routes: {
            SplashScreen.routeName: (_) => SplashScreen(),
            SetupScreen.routeName: (_) => SetupScreen(),
            LoginScreen.routeName: (_) => LoginScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
            ManageEventsScreen.routeName :(_) => ManageEventsScreen()
          },
          initialRoute: SplashScreen.routeName,
        );
      },
    );
  }
}
