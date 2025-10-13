import 'package:evently_c16_mon/core/utils/data_validator.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';
import 'package:evently_c16_mon/ui/widgets/language_switch.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  ValueNotifier<bool> rePasswordVisible = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.registerTitle)),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/large_logo.png",
                width: MediaQuery.sizeOf(context).width * 0.3,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:
                  (value) =>
                      DataValidator.validateUserName(value ?? "", locale),
              decoration: InputDecoration(
                hintText: locale.nameHint,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: passwordVisible,
              builder:
                  (context, value, child) => TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:
                        (value) =>
                            DataValidator.validatePassword(value ?? "", locale),
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
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: rePasswordVisible,
              builder:
                  (context, value, child) => TextFormField(
                    controller: rePasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:
                        (value) => DataValidator.validateRePassword(
                          value ?? "",
                          passwordController.text,
                          locale,
                        ),
                    obscureText: !value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: locale.rePasswordHint,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          rePasswordVisible.value = !value;
                        },
                        child: Icon(
                          value ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder:
                  (context, value, child) => FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading.value = true;
                        try {
                          await FirebaseAuthService().registerUser(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          Navigator.pop(context);
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
                            : Text(locale.createAccount),
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(locale.alreadyHaveAccount),
                TextButton(onPressed: () {}, child: Text(locale.login)),
              ],
            ),
            const SizedBox(height: 16),
            const Align(alignment: Alignment.center, child: LanguageSwitch()),
          ],
        ),
      ),
    );
  }
}
