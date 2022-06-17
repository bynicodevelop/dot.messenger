import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_messenger/config/bloc_register.dart';
import 'package:dot_messenger/config/custom_theme_data.dart';
import 'package:dot_messenger/screens/authentication/signin_screen.dart';
import 'package:dot_messenger/screens/deep_link_screen.dart';
import 'package:dot_messenger/screens/home_screen.dart';
import 'package:dot_messenger/screens/slash_screen.dart';
import 'package:dot_messenger/screens/start_wizard_screen.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    await FirebaseStorage.instance.useStorageEmulator(
      host,
      9199,
    );
  }

  // await FirebaseAuth.instance.signOut();

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  runApp(App(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  ));
}

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  const App({
    Key? key,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocRegister(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
      child: MaterialApp(
        title: 'Dot Messenger',
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.themeLight(context),
        onGenerateRoute: (RouteSettings setting) {
          if (setting.name != null && setting.name!.startsWith("/connect")) {
            final String uid = setting.name!.split("/").last;

            return MaterialPageRoute(
              builder: (context) => DeepLinkScreen(
                uid: uid,
              ),
            );
          }

          return null;
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitialState) {
              if (!state.isReady) {
                return const SplashScreen();
              } else {
                if (!state.isAuthenticated) {
                  return const SignInScreen();
                }

                if (state.startWithWizard) {
                  return const StartWizardScreen();
                }
              }
            }

            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
