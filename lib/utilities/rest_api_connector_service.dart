// import 'package:aman_liburan/model/response_model/oauth_object.dart'; 

// import 'package:aman_liburan/utilities/global.dart' as global;
// import 'package:aman_liburan/utilities/sync_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// class RestApiConnectorService {
//   String _accessToken; 

//   Future<void> checkAndAssignAccessToken() async{
//     OauthObject _oauthObject = await SyncService().oauthObject;
//     this._accessToken = _oauthObject.accessToken;
//   }

//   String getAccessToken(){
//     return this._accessToken;
//   }


//   //API GET PUBLIC
//   Future<Response> getUrl(String pathUrl) async{
//     var result; 
//     result = await http.get(global.apiBaseUrl + "/" + pathUrl).timeout(Duration(seconds: 15));
//     if (result.statusCode == 200) {
//       return result;
//     } else {
//       throw Exception('Failed'); 
//     } 
//   }

//   //API POST PUBLIC
//   Future<Response> postUrl(pathUrl, body) async {
//     var result;
//     Map<String, String> headers = {"content-type" : "application/json", "accept": "application/json",};
//     result = await http.post(global.apiBaseUrl + "/" + pathUrl, headers: headers, body: body).timeout(Duration(seconds: 15));
//     if (result.statusCode == 200) {
//       return result;
//     } else { 
//       throw Exception('Failed'); 
//     } 
//   }

//   //API GET AUTH 
//   Future<Response> get(String pathUrl, String extraParam) async{
//     await checkAndAssignAccessToken(); 
//     var result;
//     result = await http.get(global.apiBaseUrl + "/" + pathUrl + "?access_token=" 
//             + this._accessToken + extraParam)
//             .timeout(Duration(seconds: 15));
//     if (result.statusCode == 200) {
//       return result;
//     } else {
//       throw Exception('Failed'); 
//     } 
//   }

//    //API POST AUTH
//   Future<Response> post(pathUrl, body) async {
//     await checkAndAssignAccessToken();
//     var result;
//     Map<String, String> headers = {"content-type" : "application/json", "accept": "application/json",};
//     result = await http.post(global.apiBaseUrl + "/" + pathUrl + "?access_token=" 
//             + this._accessToken , headers: headers, body: body).timeout(Duration(seconds: 15));
//     if (result.statusCode == 200) {
//       return result;
//     } else { 
//       throw Exception('Failed'); 
//     } 
//   }


// }
