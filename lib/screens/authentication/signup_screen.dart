import 'package:dot_messenger/components/forms/email_textfield.dart';
import 'package:dot_messenger/components/forms/password_textfield.dart';
import 'package:dot_messenger/services/signup/signup_bloc.dart';
import 'package:dot_messenger/widgets/headling_authentication_form_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const messages = {
  'email-already-in-use': 'Un compte existe déjà avec cette adresse email',
  'weak-password': 'Votre mot de passe doit contenir au moins 6 caractères',
  'invalid-email': 'Veuillez entrer une adresse email valide',
  'unexpected-error': 'Une erreur est survenue',
};

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    if (kDebugMode) {
      emailController.text = "john@domain.tld";
      passwordController.text = "123456";
    }

    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignupFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messages[state.error]!),
                backgroundColor: Colors.red,
              ),
            );

            return;
          }

          if (state is SignupSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Votre compte a bien été créé'),
              ),
            );

            Navigator.pop(context);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 36.0,
                  ),
                  child: HeadlineAuthenticationFormWidget(
                    title: "Bienvenue",
                    subtitle1: "Commençons par vous",
                    subtitle2: "créer un compte",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: EmailTextField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    placeholder: "Entrez votre E-mail",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: PasswordTextField(
                    textInputAction: TextInputAction.done,
                    controller: passwordController,
                    placeholder: "Entrez un mot de passe",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      // ForgottenPasswordButtonWidget(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez entrer votre email'),
                            ),
                          );

                          return;
                        }

                        if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Veuillez entrer un mot de passe (6 caractères min.)'),
                            ),
                          );

                          return;
                        }

                        context.read<SignUpBloc>().add(
                              OnSignupButtonPressedEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: Text(
                        "Créer un compte",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              letterSpacing: 1,
                            ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: "Vous avez un compte ? ",
                      style: Theme.of(context).textTheme.bodySmall!,
                      children: [
                        TextSpan(
                          text: "Connectez-vous",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
