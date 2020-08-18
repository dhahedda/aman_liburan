// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:aman_liburan/app_localizations.dart';
// import 'package:aman_liburan/blocs/login/login_bloc.dart';
// import 'package:aman_liburan/blocs/login/login_event.dart';
// import 'package:aman_liburan/blocs/login/login_state.dart';
// import 'package:aman_liburan/models/response/global_response.dart';
// import 'package:aman_liburan/repositories/aman_liburan/api_repository.dart';
// import 'package:aman_liburan/utilities/styles/custom_icons.dart';
// import 'package:aman_liburan/utilities/styles/custom_styles.dart';
// import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';
// import 'package:aman_liburan/utilities/widgets/social_Icons.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => BlocProvider<LoginBloc>(
//         create: (context) => LoginBloc(),
//         child: LoginScreen(),
//       );
// }

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//       dynamic _loginBloc = BlocProvider.of<LoginBloc>(context);
//       void _toggleVisiblePassword() {
//         BlocProvider.of<LoginBloc>(context).add(ToggleVisiblePassword());
//       }

//       void _toggleRememberMe() {
//         BlocProvider.of<LoginBloc>(context).add(ToggleRememberMe());
//       }

//       void _loginPressed() {
//         BlocProvider.of<LoginBloc>(context).add(LoginPressed());
//       }

//       // void _clearEmail() {
//       //   BlocProvider.of<LoginBloc>(context).add(ClearEmail());
//       // }

//       Widget _buildEmailWidget() {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Email', style: customLabelStyle),
//             SizedBox(height: 5.0),
//             Container(
//                 decoration: customBoxDecorationStyle,
//                 child: TextFormField(
//                   controller: state.emailController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) => value.isEmpty ? 'Email can\'t be empty!' : null,
//                   onChanged: (_) {
//                     setState(() {});
//                   },
//                   style: TextStyle(
//                     color: colorGreyGaijin,
//                     fontFamily: 'OpenSans',
//                   ),
//                   decoration: InputDecoration(
//                       // suffixIcon: state.emailController.text.length > 0
//                       //     ? IconButton(
//                       //         icon: Icon(Icons.clear, color: Colors.black38),
//                       //         onPressed: () {
//                       //           _clearEmail();
//                       //         },
//                       //       )
//                       //     : null,
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.email, color: colorGreyGaijin),
//                       hintText: 'Enter your Email',
//                       hintStyle: customHintTextStyle,
//                       errorStyle: TextStyle(color: Colors.red)),
//                 )),
//           ],
//         );
//       }

//       Widget _buildPasswordWidget() {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Password', style: customLabelStyle),
//             SizedBox(height: 5.0),
//             Container(
//               decoration: customBoxDecorationStyle,
//               child: TextFormField(
//                 controller: state.passwordController,
//                 textInputAction: TextInputAction.done,
//                 keyboardType: TextInputType.text,
//                 obscureText: !state.isVisiblePassword,
//                 onChanged: (_) {
//                   setState(() {});
//                 },
//                 validator: (value) => value.isEmpty ? 'Password can\'t be empty!' : null,
//                 style: TextStyle(
//                   color: colorGreyGaijin,
//                   fontFamily: 'OpenSans',
//                 ),
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     suffixIcon: state.passwordController.text.length > 0
//                         ? IconButton(
//                             onPressed: () {
//                               _toggleVisiblePassword();
//                             },
//                             highlightColor: Colors.transparent,
//                             icon: Icon(Icons.remove_red_eye),
//                             color: state.isVisiblePassword ? Theme.of(context).accentColor : Colors.grey)
//                         : null,
//                     prefixIcon: Icon(Icons.lock, color: colorGreyGaijin),
//                     hintText: 'Enter your Password',
//                     hintStyle: customHintTextStyle,
//                     errorStyle: TextStyle(color: Colors.red)),
//               ),
//             ),
//           ],
//         );
//       }

//       Widget _buildForgotPasswordBtn() {
//         return FlatButton(
//           onPressed: () => print('Forgot Password Button Pressed'),
//           padding: const EdgeInsets.only(right: 0.0),
//           child: Text('Forgot Password?', style: customLabelStyle),
//         );
//       }

//       Widget _buildRememberMeCheckbox() {
//         return Row(
//           children: <Widget>[
//             Theme(
//               data: ThemeData(unselectedWidgetColor: Colors.black26),
//               child: Checkbox(
//                 value: state.isRememberMe,
//                 checkColor: Colors.white,
//                 activeColor: colorBlueGaijin,
//                 onChanged: (_) {
//                   _toggleRememberMe();
//                 },
//               ),
//             ),
//             RawMaterialButton(
//               onPressed: () {
//                 _toggleRememberMe();
//               },
//               child: Text(
//                 'Remember me',
//                 style: customLabelStyle,
//               ),
//             ),
//           ],
//         );
//       }

//       Widget _buildLoginBtn() {
//         return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25.0),
//             child: RaisedButton(
//               elevation: 5.0,
//               onPressed: () async {
//                 print('login pressed');
//                 print(state.emailController.text);
//                 // GlobalResponse response = await ApiRepository().getSearch(query: 'Chair');
//                 // _loginBloc.add(LoginPressed());
//                 // _loginPressed();
//                 Navigator.of(context).pushReplacementNamed('/app-base-configuration');
//               },
//               padding: const EdgeInsets.all(10.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               color: colorBlueGaijin,
//               child: Text(
//                 'LOGIN',
//                 style: TextStyle(
//                   color: Colors.white,
//                   letterSpacing: 1,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'OpenSans',
//                 ),
//               ),
//             ));
//       }

//       Widget _buildSignInWithText() {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             HorizontalLine(width: 50, color: Colors.grey.withOpacity(.4), padding: 16.0),
//             Text(
//               'Sign in with',
//               style: customLabelStyle,
//             ),
//             HorizontalLine(width: 50, color: Colors.grey.withOpacity(.4), padding: 16.0),
//           ],
//         );
//       }

//       Widget _buildSocialBtnRow() {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SocialIcon(
//                 colors: [
//                   Color(0xFF102397),
//                   Color(0xFF187adf),
//                   Color(0xFF00eaf8),
//                 ],
//                 iconData: CustomIcons.facebook,
//                 onPressed: () {
//                   print('Login with Facebook');
//                 },
//               ),
//               SocialIcon(
//                 colors: [
//                   Color(0xFF102397),
//                   Color(0xFF187adf),
//                   Color(0xFF00eaf8),
//                 ],
//                 iconData: CustomIcons.googlePlus,
//                 onPressed: () {
//                   print('Login with Google');
//                 },
//               ),
//             ],
//           ),
//         );
//       }

//       return Scaffold(
//         body: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 40.0),
//           children: <Widget>[
//             Text(
//               'Welcome to Gaijin Collections',
//               style: TextStyle(
//                 color: colorBlueGaijin,
//                 fontFamily: 'OpenSans',
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Secondhand Platform for Gaijin',
//               style: TextStyle(
//                 color: Colors.blueAccent,
//                 fontFamily: 'OpenSans',
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 40.0),
//             _buildEmailWidget(),
//             SizedBox(height: 10.0),
//             _buildPasswordWidget(),
//             SizedBox(height: 5.0),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               _buildRememberMeCheckbox(),
//               _buildForgotPasswordBtn(),
//             ]),
//             _buildLoginBtn(),
//             _buildSignInWithText(),
//             _buildSocialBtnRow(),
//             // Experimental localization. Uncomment to see the translated texts
//             // Text(
//             //   AppLocalizations.of(context).translate('first_string'),
//             //   style: TextStyle(fontSize: 25),
//             //   textAlign: TextAlign.center,
//             // ),
//             // SizedBox(height: 10),
//             // Text(
//             //   AppLocalizations.of(context).translate('second_string'),
//             //   style: TextStyle(fontSize: 25),
//             //   textAlign: TextAlign.center,
//             // ),
//             // SizedBox(height: 10),
//             // Text(
//             //   'This will not be translated.',
//             //   style: TextStyle(fontSize: 25),
//             //   textAlign: TextAlign.center,
//             // ),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
