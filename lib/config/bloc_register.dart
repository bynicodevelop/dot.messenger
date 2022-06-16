import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_messenger/components/avatar/avatar_edit_button/bloc/avatar_edit_button_bloc.dart';
import 'package:dot_messenger/components/avatar/bloc/avatar_bloc.dart';
import 'package:dot_messenger/repositories/image_repository.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:dot_messenger/services/loading/loading_bloc.dart';
import 'package:dot_messenger/services/logout/logout_bloc.dart';
import 'package:dot_messenger/services/profile_settings/profile_settings_bloc.dart';
import 'package:dot_messenger/services/signin/signin_bloc.dart';
import 'package:dot_messenger/services/signup/signup_bloc.dart';
import 'package:dot_messenger/services/start_wizard/start_wizard_bloc.dart';
import 'package:dot_messenger/services/update_profile_settings/update_profile_settings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BlocRegister extends StatelessWidget {
  final Widget child;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  const BlocRegister({
    Key? key,
    required this.child,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<StartWizardBloc>(
          create: (context) => StartWizardBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<LoadingBloc>(
          create: (context) => LoadingBloc(),
        ),
        BlocProvider<AvatarBloc>(
          create: (context) => AvatarBloc(),
        ),
        BlocProvider<AvatarEditButtonBloc>(
          create: (context) => AvatarEditButtonBloc(
            userRepository: userRepository,
            imageRepository: ImageRepository(
              picker: ImagePicker(),
              firebaseStorage: firebaseStorage,
              firebaseAuth: firebaseAuth,
            ),
          ),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<UpdateProfileSettingsBloc>(
          create: (context) => UpdateProfileSettingsBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<ProfileSettingsBloc>(
          create: (context) => ProfileSettingsBloc(
            userRepository: userRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
