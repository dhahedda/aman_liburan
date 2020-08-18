// // Copyright 2019 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:convert' show json;

// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// class GoogleSignInDemo extends StatefulWidget {
//   @override
//   State createState() => GoogleSignInDemoState();
// }

// class GoogleSignInDemoState extends State<GoogleSignInDemo> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;

//   String your_client_id = "enter your app FBID here (DON'T add secret app code)";
//   String your_redirect_url = "https://www.facebook.com/connect/login_success.html";
//   loginWithFacebook() async {
//     String result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => CustomWebView(
//                 selectedUrl: 'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
//               ),
//           maintainState: true),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//       '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     if (_currentUser != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: _currentUser,
//             ),
//             title: Text(_currentUser.displayName ?? ''),
//             subtitle: Text(_currentUser.email ?? ''),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText ?? ''),
//           RaisedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           RaisedButton(
//             child: const Text('REFRESH'),
//             onPressed: _handleGetContact,
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           RaisedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }

// class CustomWebView extends StatefulWidget {
//   final String selectedUrl;

//   CustomWebView({this.selectedUrl});

//   @override
//   _CustomWebViewState createState() => _CustomWebViewState();
// }

// class _CustomWebViewState extends State<CustomWebView> {
//   final flutterWebviewPlugin = FlutterWebviewPlugin();

//   @override
//   void initState() {
//     super.initState();

//     flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (url.contains("#access_token")) {
//         succeed(url);
//       }

//       if (url.contains(
//           "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
//         denied();
//       }
//     });
//   }

//   denied() {
//     Navigator.pop(context);
//   }

//   succeed(String url) {
//     var params = url.split("access_token=");

//     var endparam = params[1].split("&");

//     Navigator.pop(context, endparam[0]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//         url: widget.selectedUrl,
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(66, 103, 178, 1),
//           title: Text("Facebook login"),
//         ));
//   }
// }