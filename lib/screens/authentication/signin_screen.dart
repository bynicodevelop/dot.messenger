import 'package:dot_messenger/components/forms/password_textfield.dart';
import 'package:dot_messenger/screens/authentication/signup_screen.dart';
import 'package:dot_messenger/screens/home_screen.dart';
import 'package:dot_messenger/services/signin/signin_bloc.dart';
import 'package:dot_messenger/widgets/headling_authentication_form_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const messages = {
  'user-not-found': 'Vous ne pouvez pas vous connecter avec ces identifiants.',
  'wrong-password': 'Vous ne pouvez pas vous connecter avec ces identifiants.',
};

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    if (kDebugMode) {
      emailController.text = "john@domain.tld";
      passwordController.text = "123456";
    }

    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messages[state.error]!),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is SignInSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
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
                    subtitle1: "Heureux de vous rencontrer !",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: PasswordTextField(
                    textInputAction: TextInputAction.done,
                    controller: passwordController,
                    placeholder: "Mot de passe",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
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

                        context.read<SignInBloc>().add(
                              OnSignInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: Text(
                        "Connexion",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              letterSpacing: 1,
                            ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return const SignUpScreen();
                      },
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "Vous n'avez pas de compte ? ",
                      style: Theme.of(context).textTheme.bodySmall!,
                      children: [
                        TextSpan(
                          text: "Créez-en un",
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
