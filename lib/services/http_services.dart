import 'dart:convert';

import 'package:http/http.dart';

import '../models/user_models.dart';

class Network {
  static String SERVER_DEVELOPMENT = "62348140debd056201e6da2f.mockapi.io";
  static String API_LIST = "/contact/contacts";
  static String API_CREATE = "/contact/contacts";
  static String API_DELETE = "/contact/contacts/";

  static Map<String, String> getHeaders() {
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    return header;
  }

  static String getServer() {
    return SERVER_DEVELOPMENT;
  }

  /// GET

  static Future<String?> GET(String api, Map<String, String> params) async {
    Uri uri = Uri.https(getServer(), api, params);
    Response response = await get(uri);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /// POST
  static Future<String?> POST(String api, Map<String, String> params) async {
    Uri uri = Uri.https(getServer(), api, params);
    Response response = await post(uri, body: jsonEncode(params),headers: getHeaders());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /// delete

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri);
    if (response.statusCode == 200) return response.body;
    return null;
  }


  /// params
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }




  /// Create Post ///
  static Map<String, String> paramsCreate(UserContact userContact) {
    Map<String, String> params = {};
    params.addAll({
      'userName': userContact.userName,
      'phoneNumber': userContact.phoneNumber,
      'relationship': userContact.relationship
    });
    return params;
  }



  static List<UserContact> parseCards(str) {
    List<UserContact> result =
    List.from(jsonDecode(str).map((e) => UserContact.fromJson(e)));
    return result;
  }


}