import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class ShowtimeBloc extends Bloc<ShowtimeEvent, ShowtimeState> {
  @override
  ShowtimeState get initialState => InitialShowtimeState();

  @override
  Stream<ShowtimeState> mapEventToState(
      ShowtimeEvent event,
      ) async* {
    if (event is ChangeDate){
      yield ShowtimeChange(currentState, firstDate: event.payload);
    }
  }
}
