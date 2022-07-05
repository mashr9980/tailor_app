import 'dart:convert';

import 'package:dio/dio.dart';
class ApisSetup{
  var baseurl="http://www.q8markaz.com/";
  var country="api/v1/countries/";
  var tailor_signup="api/v1/register_tailor/";
  var tailor_business="api/v1/business_tailor/";
  var tailor_login='api/v1/login_tailorlogin/';
  var login_url="o/token/";
  var stitching_prroduct="api/v1/stitchproducts/";
  var get_customers="api/v1/search_customer/";
  var get_customers_my="api/v1/get_tailor_customer/";
  var orders_filter="api/v1/oders_filters/";
  var add_measure_my="api/v1/measurements/";
  var get_bus_profile="api/v1/tailor_profile/";
  var oders="api/v1/oders/";
  var account="api/v1/profile_tailor/";
  var forget_pwd="api/v1/reset_tailorpwd/";
  var update_pwd="api/v1/tailor_password_reset/";
//////////////////////// un used apis /////////////////////////
  var register_url="users/api/v1/register/";
  var verify_url="users/api/v1/verify/";
  var get_gym="gym/api/v1/gym";
  var get_gym_detail="gym/api/v1/gymdetails/";
  var update_gym_view="gym/api/v1/gymviews/";
  var gym_review="gym/api/v1/gymreviewadd/";
  var user_profile="users/api/v1/profile/";



  var client_d="ieGvZGuveeBHoiwmedmLTWEH5FOyTMpJGFNAx8yU";
  var client_secret="l1BN22dkKM7237QnmCvRg71xkPWKTA7bpC2zukt47nO9rqJyRQlMHLowvs4os59FfO0jsvWs51Gnm5PFvgCYkOmgdspnSXago76nHmOKew7CBkrEXm0xSx1R1lGoA21P";
  var auth = 'Basic '+base64Encode(utf8.encode('xN0pCV0GjWqPONaQoEHjwd2M1vlpyu2ToxccPgOS:l06roQBRbNZKg8CtN8BVejbu3GQO5SJXSKLiVTPvEICgdyMFZECDGRD8gmSRzb6i85WBQj8Bdj1lWIlgM3f3km1DKpNcvl4WwkHXFxqIsan4LC3kCCXTRMJSu8nZm8oC'));
  late Dio dio;
  ApisSetup() {
    BaseOptions options = BaseOptions(
        baseUrl: baseurl,
        responseType: ResponseType.plain,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        // ignore: missing_return
        validateStatus: (code) {
          if (code! >= 200) {
            return true;
          }
          return false;
        });
    dio = Dio(options);
  }
}