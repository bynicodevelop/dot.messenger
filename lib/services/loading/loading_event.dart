part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

class OnLoadingEvent extends LoadingEvent {}

class OnLoadedEvent extends LoadingEvent {}
