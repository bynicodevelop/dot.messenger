import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitialState()) {
    on<OnLoadingEvent>((event, emit) {
      emit(LoadingLoadingState());
    });

    on<OnLoadedEvent>((event, emit) {
      emit(LoadingInitialState());
    });
  }
}
