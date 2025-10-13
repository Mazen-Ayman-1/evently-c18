import 'package:evently_c16_mon/core/providers/app_config_provider.dart';
import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';
import 'package:evently_c16_mon/ui/auth/login_screen.dart';
import 'package:evently_c16_mon/ui/widgets/language_switch.dart';
import 'package:evently_c16_mon/ui/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatelessWidget {
  static const String routeName = "/setup";

  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/horizontal_logo.png",
                  width: MediaQuery.sizeOf(context).width * 0.5,
                ),
              ),
              Expanded(
                child: Image.asset(
                  "assets/images/${provider.isDark() ? "dark_setup_image.png" : "setup_image.png"}",
                ),
              ),
              Text(
                AppLocalizations.of(context)!.personalizeYourExperience,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.setupMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  LanguageSwitch(),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  ThemeSwitch(),
                ],
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(AppLocalizations.of(context)!.letsGo)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
