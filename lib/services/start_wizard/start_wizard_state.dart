part of 'start_wizard_bloc.dart';

abstract class StartWizardState extends Equatable {
  const StartWizardState();

  @override
  List<Object> get props => [];
}

class StartWizardInitialState extends StartWizardState {}

class StartWizardLoadingState extends StartWizardState {}

class StartWizardUpdateUsernameSuccessState extends StartWizardState {}

class StartWizardErrorState extends StartWizardState {
  final String error;

  const StartWizardErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
