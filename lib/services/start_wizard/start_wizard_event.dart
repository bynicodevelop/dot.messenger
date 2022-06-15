part of 'start_wizard_bloc.dart';

abstract class StartWizardEvent extends Equatable {
  const StartWizardEvent();

  @override
  List<Object> get props => [];
}

class OnStartWizardUpdateUsernameEvent extends StartWizardEvent {
  final String username;

  const OnStartWizardUpdateUsernameEvent({
    required this.username,
  });

  @override
  List<Object> get props => [
        username,
      ];
}
