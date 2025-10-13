import 'package:evently_c16_mon/core/utils/data_validator.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';
import 'package:evently_c16_mon/ui/auth/forget_password_screen.dart';
import 'package:evently_c16_mon/ui/auth/register_screen.dart';
import 'package:evently_c16_mon/ui/home/home_screen.dart';
import 'package:evently_c16_mon/ui/widgets/language_switch.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";

  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fromKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/large_logo.png",
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:
                    (value) => DataValidator.validateEmail(value ?? "", locale),
                decoration: InputDecoration(
                  hintText: locale.email,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: passwordVisible,
                builder:
                    (context, value, child) => TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          (value) => DataValidator.validatePassword(
                            value ?? "",
                            locale,
                          ),
                      obscureText: !value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        hintText: locale.password,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            passwordVisible.value = !value;
                          },
                          child: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                  },
                  child: Text(locale.forgetPassword),
                ),
              ),
              SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder:
                    (context, value, child) => FilledButton(
                      onPressed: () async {
                        if (fromKey.currentState!.validate()) {
                          isLoading.value = true;
                          try {
                            await FirebaseAuthService().login(
                              emailController.text,
                              passwordController.text,
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.routeName,
                            );
                          } catch (e) {
                            print(e);
                          } finally {
                            isLoading.value = false;
                          }
                        }
                      },
                      child:
                          value
                              ? CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.surface,
                              )
                              : Text(locale.login),
                    ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locale.doNotHaveAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(locale.createAccount),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Divider(indent: 40)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      locale.or,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Expanded(child: Divider(endIndent: 40)),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.asset("assets/images/google.png"),
                label: Text(locale.loginWithGoogle),
              ),
              SizedBox(height: 16),
              Align(alignment: Alignment.center, child: LanguageSwitch()),
            ],
          ),
        ),
      ),
    );
  }
}
