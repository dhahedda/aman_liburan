import 'package:aman_liburan/blocs/login/login_bloc.dart';
import 'package:aman_liburan/services/consume_api.dart';
import 'package:aman_liburan/services/Screen.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const route = '/login';

  // final TextEditingController _emailController = TextEditingController(text: 'visitor@gmail.com');
  // final TextEditingController _emailController = TextEditingController(text: 'government@gmail.com');
  final TextEditingController _emailController = TextEditingController(text: 'fo@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'password');

  final _formKey = GlobalKey<FormState>();

  // UserServices userService;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   userService = Provider.of<UserServices>(context);
  // }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  Widget _decoration() {
    return Stack(
      children: [
        Positioned(
          top: 0.0,
          left: 0.0,
          width: SizeConfig.getWidth(context) / 100 * 30,
          child: Image.asset('images/ic.png'),
        ),
        Positioned(
          top: SizeConfig.getHeight(context) / 100 * 25,
          left: 0,
          width: SizeConfig.getWidth(context),
          child: SvgPicture.asset(
            'images/waves_blue.svg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: SizeConfig.getHeight(context) / 100 * 25,
          left: 0,
          width: SizeConfig.getWidth(context),
          child: SvgPicture.asset(
            'images/waves_green.svg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget _textField(String hint) {
    final formValidator = MultiValidator([
      RequiredValidator(errorText: 'harus diisi'),
      MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
    ]);
    return TextFormField(
      obscureText: hint == "Kata sandi" ? true : false,
      controller: hint == "Kata sandi" ? _passwordController : _emailController,
      style: TextStyle(color: Colors.black87),
      validator: formValidator,
      decoration: InputDecoration(hintText: hint, hoverColor: Colors.white, hintStyle: GoogleFonts.poppins(color: Colors.grey), fillColor: Colors.white, focusColor: Colors.white),
    );
  }

  Widget _form(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: SizeConfig.getHeight(context) / 100 * 35,
          width: SizeConfig.getWidth(context) / 100 * 100,
          height: SizeConfig.getHeight(context) / 100 * 65,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: SizeConfig.getWidth(context) / 100 * 10,
                    width: SizeConfig.getWidth(context) / 100 * 80,
                    child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                      return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '\nLogin',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: SizeConfig.getWidth(context) / 100 * 6),
                              ),
                              _textField("Email"),
                              _textField("Kata sandi"),
                              Text('\n\n'),
                              state is LoginLoading
                                  ? CustomButton(
                                      color: CustomColor().primary,
                                      fontColor: Colors.white,
                                      function: () {},
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      width: SizeConfig.getWidth(context) / 100 * 80,
                                    )
                                  : CustomButton(
                                      color: CustomColor().primary,
                                      fontColor: Colors.white,
                                      function: () async {
                                        // bool loginSuccess = await UserServices().signIn(_emailController.text, _passwordController.text);
                                        // bool loginSuccess = await userService.signIn(_emailController.text, _passwordController.text);
                                        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ));
                                        // if (loginSuccess) {
                                        //   Navigator.of(context).pushReplacementNamed('/app-base-configuration');
                                        // }
                                      },
                                      hint: 'LOGIN',
                                      width: SizeConfig.getWidth(context) / 100 * 80,
                                    ),
                              CustomButton(
                                color: Colors.white,
                                fontColor: CustomColor().primary,
                                function: () => ConsumeApi().tes(),
                                hint: 'REGISTER',
                                width: SizeConfig.getWidth(context) / 100 * 80,
                              ),
                              FlatButton(
                                child: Text(
                                  'Lupa password?',
                                  style: GoogleFonts.poppins(fontSize: SizeConfig.getWidth(context) / 100 * 5),
                                ),
                                onPressed: null,
                              )
                            ],
                          ));
                    })),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen().init(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (contex, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacementNamed('/app-base-configuration');
        }
      },
      child: Container(
        color: CustomColor().primary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Stack(
                children: <Widget>[_decoration(), _form(context)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
