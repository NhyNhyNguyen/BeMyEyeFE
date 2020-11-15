import 'package:connectycube_sdk/connectycube_sdk.dart';

const String APP_ID = "3614";
const String AUTH_KEY = "cwN9CKpA3YBL5A-";
const String AUTH_SECRET = "x4UuAAKP--6y9Wb";
const String ACCOUNT_ID = "wDoBZhEDDzFRhhQVXsFZ";
const String DEFAULT_PASS = "NHINHI";
const String SERVER_ENDPOINT = "wss://janus.connectycube.com:8989";

List<CubeUser> users = [
  CubeUser(
      id: 2661406, password: "NHINHI123", login: "nhinhi", fullName: "nhi"),
  CubeUser(
    id: 1253159,
    login: "call_user_2",
    fullName: "User 2",
    password: DEFAULT_PASS,
  ),
  CubeUser(
    id: 1253160,
    login: "call_user_3",
    fullName: "User 3",
    password: DEFAULT_PASS,
  ),
  CubeUser(
    id: 1253162,
    login: "call_user_4",
    fullName: "User 4",
    password: DEFAULT_PASS,
  ),
  CubeUser(
    id: 1425506,
    login: "call_user_5",
    fullName: "User 5",
    password: DEFAULT_PASS,
  ),
];
