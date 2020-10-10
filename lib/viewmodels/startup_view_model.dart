//
//
//import 'package:bymyeyefe/services/dynamic_link_service.dart';
//import 'package:flutter/cupertino.dart';
//
//import '../locator.dart';
//import 'base_model.dart';
//
//class StartUpViewModel extends ChangeNotifier{
//  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
//
//  Future handleStartUpLogic() async {
//    await _dynamicLinkService.handleDynamicLinks();
//
//    // Register for push notifications
//    /*await _pushNotificationService.initialise();
//
//    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
//
//    if (hasLoggedInUser) {
//      _navigationService.navigateTo(HomeViewRoute);
//    } else {
//      _navigationService.navigateTo(LoginViewRoute);
//    }*/
//  }
//}
