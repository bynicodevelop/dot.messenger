import 'package:dot_messenger/widgets/headling_authentication_form_widget.dart';
import 'package:flutter/material.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  const ForgottenPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
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
                  title: "Sécurité",
                  subtitle1: "Changer de mot de passe",
                  subtitle2: "Vous allez recevoir un email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                    },
                    child: Text(
                      "Envoyer",
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
                    text: "Retourner à la connexion",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
