import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'bloc.dart';
import 'bloc.dart';
import 'bloc.dart';
import 'bloc.dart';
import 'homepage_event.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc(HomepageState initialState) : super(initialState);

  @override
  HomepageState get initialState => InitialHomepageState();

  HomepageState get currentState => null;

  @override
  Stream<HomepageState> mapEventToState(
      HomepageEvent event,
      ) async* {
    if (event is ChangeType){
      yield HomepageChange(currentState, firstType: event.payload);
    }
  }
}
