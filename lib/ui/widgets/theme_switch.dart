
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_mon/core/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return SizedBox(
      height: 32,
      child: AnimatedToggleSwitch.rolling(
        current: provider.appTheme,
        values: [
          ThemeMode.light,
          ThemeMode.dark
        ],
        onChanged: (value){
          provider.changeTheme(value);
        },
        padding: EdgeInsets.zero,
        borderWidth: 1,
        style: ToggleStyle(
            indicatorColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
            borderColor: Theme.of(context).colorScheme.primary
        ),
        indicatorSize: const Size.fromWidth(32),
        iconBuilder: (value , selected){
          if(value == ThemeMode.light){
            return Icon(Icons.light_mode);
          }else {
            return Icon(Icons.dark_mode);
          }
        },
      ),
    );

  }
}
