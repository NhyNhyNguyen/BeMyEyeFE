//
//import 'package:bymyeyefe/constant/ConstantVar.dart';
//import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
//
//class DynamicLinkService {
//  Future handleDynamicLinks() async {
//    // Get the initial dynamic link if the app is opened with a dynamic link
//    final PendingDynamicLinkData data =
//        await FirebaseDynamicLinks.instance.getInitialLink();
//
//    // handle link that has been retrieved
//    _handleDeepLink(data);
//
//    // Register a link callback to fire if the app is opened up from the background
//    // using a dynamic link.
//    FirebaseDynamicLinks.instance.onLink(
//        onSuccess: (PendingDynamicLinkData dynamicLink) async {
//      // handle link that has been retrieved
//      _handleDeepLink(dynamicLink);
//    }, onError: (OnLinkErrorException e) async {
//      print('Link Failed: ${e.message}');
//    });
//  }
//
//  void _handleDeepLink(PendingDynamicLinkData data) {
//    final Uri deepLink = data?.link;
//    if (deepLink != null) {
//      print('_handleDeepLink | deeplink: $deepLink');
//      if(deepLink.path.contains('token')){
//       String token =  deepLink.path.split('=')[1];
//       print(token + " token");
//       ConstantVar.registerToken = token;
//      }
//    }
//  }
//
//
//}
