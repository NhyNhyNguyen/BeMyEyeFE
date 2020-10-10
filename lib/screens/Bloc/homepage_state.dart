import 'package:meta/meta.dart';

@immutable
abstract class HomepageState {
  final String firstType;
  HomepageState({this.firstType});
}

class InitialHomepageState extends HomepageState {
  InitialHomepageState() : super(firstType: "now-showing");
}

class HomepageChange extends HomepageState {
  HomepageChange(HomepageState oldState, {String firstType})
      : super(
    firstType: firstType ?? oldState.firstType,
  );
}
