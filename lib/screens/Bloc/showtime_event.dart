import 'package:meta/meta.dart';


@immutable
abstract class ShowtimeEvent {
  final int payload;
  ShowtimeEvent(this.payload);
}

class ChangeDate extends ShowtimeEvent {
  ChangeDate(int date) : super(date);

}


