import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/call_video/utils/call_manager.dart';
import 'package:camera/camera.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';

class ConstantVar {
  static String jwt = "";
  static bool isLogin = false;
  static UserDetail userDetail = null;
  static User user = null;
  static String registerToken = "";
  static String resetPassWordToken = "";
  static String currentLocal = "vi_VN";
  static CubeUser currentUser;
  static CallManager callManager;
  static ConferenceClient callClient;
  static ConferenceSession currentCall;
  static List<CameraDescription> cameras;
}
