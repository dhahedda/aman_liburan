part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final TextEditingController signinEmailController;
  final TextEditingController signinPasswordController;

  final bool obscureTextSignin;
  final bool obscureTextSignup;
  final bool obscureTextSignupConfirm;

  final TextEditingController signupEmailController;
  final TextEditingController signupFirstNameController;
  final TextEditingController signupLastNameController;
  final TextEditingController signupPasswordController;
  final TextEditingController signupConfirmPasswordController;

  final SigninStatus signinStatus;

  const SigninState({
    this.signinEmailController,
    this.signinPasswordController,
    this.obscureTextSignin,
    this.obscureTextSignup,
    this.obscureTextSignupConfirm,
    this.signupEmailController,
    this.signupFirstNameController,
    this.signupLastNameController,
    this.signupPasswordController,
    this.signupConfirmPasswordController,
    this.signinStatus,
  });

  factory SigninState.initial() => SigninState(
        signinEmailController: TextEditingController(text: "ahmadrfauzi94@gmail.com"),
        signinPasswordController: TextEditingController(text: "GoDummy2020"),
        obscureTextSignin: true,
        obscureTextSignup: true,
        obscureTextSignupConfirm: true,
        signupEmailController: TextEditingController(),
        signupFirstNameController: TextEditingController(),
        signupLastNameController: TextEditingController(),
        signupPasswordController: TextEditingController(),
        signupConfirmPasswordController: TextEditingController(),
        signinStatus: SigninStatus.none,
      );

  SigninState copyWith({
    TextEditingController signinEmailController,
    TextEditingController signinPasswordController,
    bool obscureTextSignin,
    bool obscureTextSignup,
    bool obscureTextSignupConfirm,
    TextEditingController signupEmailController,
    TextEditingController signupFirstNameController,
    TextEditingController signupLastNameController,
    TextEditingController signupPasswordController,
    TextEditingController signupConfirmPasswordController,
    SigninStatus signinStatus,
  }) =>
      SigninState(
        signinEmailController: signinEmailController ?? this.signinEmailController,
        signinPasswordController: signinPasswordController ?? this.signinPasswordController,
        obscureTextSignin: obscureTextSignin ?? this.obscureTextSignin,
        obscureTextSignup: obscureTextSignup ?? this.obscureTextSignup,
        obscureTextSignupConfirm: obscureTextSignupConfirm ?? this.obscureTextSignupConfirm,
        signupEmailController: signupEmailController ?? this.signupEmailController,
        signupFirstNameController: signupFirstNameController ?? this.signupFirstNameController,
        signupLastNameController: signupLastNameController ?? this.signupLastNameController,
        signupPasswordController: signupPasswordController ?? this.signupPasswordController,
        signupConfirmPasswordController: signupConfirmPasswordController ?? this.signupConfirmPasswordController,
        signinStatus: signinStatus ?? this.signinStatus,
      );

  @override
  List<Object> get props => [
        signinEmailController,
        signinPasswordController,
        obscureTextSignin,
        obscureTextSignup,
        obscureTextSignupConfirm,
        signupEmailController,
        signupFirstNameController,
        signupLastNameController,
        signupPasswordController,
        signupConfirmPasswordController,
        signinStatus,
      ];

  @override
  String toString() {
    return '''SigninState {
        signinEmailController: $signinEmailController,
        signinPasswordController: $signinPasswordController,
        obscureTextSignin: $obscureTextSignin,
        obscureTextSignup: $obscureTextSignup,
        obscureTextSignupConfirm: $obscureTextSignupConfirm,
        signupEmailController: $signupEmailController,
        signupFirstNameController: $signupFirstNameController,
        signupLastNameController: $signupLastNameController,
        signupPasswordController: $signupPasswordController,
        signupConfirmPasswordController: $signupConfirmPasswordController,
        signinStatus: $signinStatus,
    }''';
  }
}

enum SigninStatus { none, process, done, failed }