import 'package:dot_messenger/screens/authentication/signin_screen.dart';
import 'package:dot_messenger/screens/user_settings_screen.dart';
import 'package:dot_messenger/services/logout/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget _listTile(
    IconData leading,
    String title,
    String subtitle,
    Function()? onTap,
  ) =>
      ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(leading),
          ],
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres utilisateur'),
      ),
      body: ListView(
        children: [
          _listTile(
            Icons.person,
            'Profil',
            'Modifier votre profil utilisateur',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserSettingsScreen(),
              ),
            ),
          ),
          BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const SignInScreen();
                  }),
                  (route) => false,
                );
              }
            },
            child: _listTile(
              Icons.logout_rounded,
              'Déconnexion',
              'Déconnectez-vous de votre compte',
              () => context.read<LogoutBloc>().add(OnLogoutEvent()),
            ),
          )
        ],
      ),
    );
  }
}
