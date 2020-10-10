import 'package:meta/meta.dart';


@immutable
abstract class HomepageEvent {
  final String payload;
  HomepageEvent(this.payload);
}

class ChangeType extends HomepageEvent {
  ChangeType(String type) : super(type);

}


