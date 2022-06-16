import 'package:dot_messenger/components/avatar/avatar_component.dart';
import 'package:dot_messenger/components/forms/email_textfield.dart';
import 'package:dot_messenger/components/forms/input_textfield.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/services/profile_settings/profile_settings_bloc.dart';
import 'package:dot_messenger/services/update_profile_settings/update_profile_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const messages = {
  'email-already-in-use':
      'Vous ne pouvez pas utiliser cet e-mail un autre compte existe déjà avec la même adresse.',
  'invalid-email': 'Veuillez entrer une adresse e-mail valide.',
};

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier mes informations'),
      ),
      body: BlocListener<UpdateProfileSettingsBloc, UpdateProfileSettingsState>(
        listener: (context, state) {
          if (state is UpdateProfileSettingsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messages[state.error]!),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is UpdateProfileSettingsSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Vos informations ont bien été mises à jour'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
              bloc: context.read<ProfileSettingsBloc>()
                ..add(OnLoadProfileSettingsEvent()),
              builder: (context, state) {
                final AuthenticatedUserModel user =
                    (state as ProfileSettingsInitialState).user;

                usernameController.text = user.username;
                emailController.text = user.email;
                descriptionController.text = user.description;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AvatarComponent(
                            avatarFromProfile: user.avatar,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: InputTextField(
                        controller: usernameController,
                        placeholder: "Entrez un nom d'utilisateur",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: EmailTextField(
                        controller: emailController,
                        placeholder: "Entrez une adresse e-mail",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: InputTextField(
                        controller: descriptionController,
                        placeholder: "Entrez une description",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (usernameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Veuillez entrer un nom d'utilisateur",
                                  ),
                                ),
                              );

                              return;
                            }

                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Veuillez entrer une adresse e-mail",
                                  ),
                                ),
                              );

                              return;
                            }

                            context.read<UpdateProfileSettingsBloc>().add(
                                  OnUpdateProfileSettingsEvent(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    description: descriptionController.text,
                                  ),
                                );
                          },
                          child: const Text(
                            "Enregister",
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
