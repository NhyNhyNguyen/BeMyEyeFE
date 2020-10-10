import 'package:meta/meta.dart';

@immutable
abstract class ShowtimeState {
  final int firstDate;
  ShowtimeState({this.firstDate});
}

class InitialShowtimeState extends ShowtimeState {
  InitialShowtimeState() : super(firstDate: 0);
}

class ShowtimeChange extends ShowtimeState {
  ShowtimeChange(ShowtimeState oldState, {int firstDate})
      : super(
    firstDate: firstDate ?? oldState.firstDate,
  );
}
