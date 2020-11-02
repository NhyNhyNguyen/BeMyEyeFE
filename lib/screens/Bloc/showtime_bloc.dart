import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class ShowtimeBloc extends Bloc<ShowtimeEvent, ShowtimeState> {
  ShowtimeBloc(ShowtimeState initialState) : super(initialState);

  @override
  ShowtimeState get initialState => InitialShowtimeState();

  ShowtimeState get currentState => null;

  @override
  Stream<ShowtimeState> mapEventToState(
      ShowtimeEvent event,
      ) async* {
    if (event is ChangeDate){
      yield ShowtimeChange(currentState, firstDate: event.payload);
    }
  }
}
