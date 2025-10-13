import 'package:evently_c16_mon/core/utils/data_validator.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "forgetPassword";

  ForgetPasswordScreen({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.forgetPassword)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.asset("assets/images/forget_password.png"),
          SizedBox(height: 16),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator:
                (value) => DataValidator.validateEmail(
                  value ?? "",
                  AppLocalizations.of(context)!,
                ),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              if (DataValidator.validateEmail(
                    controller.text,
                    AppLocalizations.of(context)!,
                  ) ==
                  null) {
                try{
                  FirebaseAuthService().forgetPassword(controller.text);
                  Navigator.pop(context);
                }catch(e){
                  print(e);
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.resetPassword),
          ),
        ],
      ),
    );
  }
}
