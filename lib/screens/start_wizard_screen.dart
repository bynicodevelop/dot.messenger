import 'dart:developer';

import 'package:dot_messenger/components/avatar/avatar_component.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:dot_messenger/services/loading/loading_bloc.dart';
import 'package:dot_messenger/services/start_wizard/start_wizard_bloc.dart';
import 'package:dot_messenger/widgets/headling_authentication_form_widget.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartWizardScreen extends StatelessWidget {
  const StartWizardScreen({Key? key}) : super(key: key);

  Widget _setUsername(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    if (kDebugMode) {
      usernameController.text = 'Jonh Smith';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            bottom: 36.0,
          ),
          child: HeadlineAuthenticationFormWidget(
            title: "Bienvenue",
            subtitle1: "Configurons votre compte",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: TextField(
            textInputAction: TextInputAction.next,
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: "Entrez un nom d'utilisateur",
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<LoadingBloc, LoadingState>(
              builder: (context, state) {
                log(state.toString());

                return ElevatedButton(
                  onPressed: state is LoadingLoadingState
                      ? null
                      : () {
                          if (usernameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Entrez un nom d'utilisateur"),
                              ),
                            );

                            return;
                          }

                          context.read<StartWizardBloc>().add(
                                OnStartWizardUpdateUsernameEvent(
                                  username: usernameController.text,
                                ),
                              );
                        },
                  child: Text(
                    "Suivant",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          letterSpacing: 1,
                        ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _setAvatar(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AvatarComponent(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<LoadingBloc, LoadingState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is LoadingLoadingState
                        ? null
                        : () {
                            context
                                .read<AuthenticationBloc>()
                                .add(OnUserSkipStartWizardEvent());
                          },
                    child: Text(
                      "Terminer",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            letterSpacing: 1,
                          ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: BlocConsumer<StartWizardBloc, StartWizardState>(
            listener: (context, state) {
              if (state is StartWizardLoadingState) {
                context.read<LoadingBloc>().add(OnLoadingEvent());
              } else {
                context.read<LoadingBloc>().add(OnLoadedEvent());
              }
            },
            builder: (
              BuildContext context,
              StartWizardState state,
            ) {
              if (state is StartWizardLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is StartWizardInitialState) {
                return _setUsername(context);
              }

              return _setAvatar(context);
            },
          ),
        ),
      ),
    );
  }
}
