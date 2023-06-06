part of 'login_signup_cubit.dart';

@immutable
abstract class LoginSignupState {}

class LoginSignupInitial extends LoginSignupState {}
class LoginSignupObsText extends LoginSignupState {}
class LoginSignupChangeRadio extends LoginSignupState {}
class LoginSignupChangePasswordRoles extends LoginSignupState {}
class LoginSignupOTP extends LoginSignupState {}

class LoginSignupOTPSussecc extends LoginSignupState {}
class LoginSignupOTPLoading extends LoginSignupState {}
class LoginSignupOTPError extends LoginSignupState {
  final String e ;
  LoginSignupOTPError(this.e);
}
class LoginSighupSelectedDateTime extends LoginSignupState{}
class LoginSighupCheckPhoneEmailLoding extends LoginSignupState{}
class LoginSighupCheckPhoneEmailSuss extends LoginSignupState{
  final Verification? verification;
  LoginSighupCheckPhoneEmailSuss(this.verification);
}
class LoginSighupCheckPhoneEmailError extends LoginSignupState{}
class LoginSignupCheckInterNetSuss extends LoginSignupState {
}
class LoginSignupCheckInterNetError extends LoginSignupState {
}
class LoginSignupOTPErrorPhoneNumber extends LoginSignupState {
  final FirebaseAuthException error ;
  LoginSignupOTPErrorPhoneNumber(this.error);
}

class LoginUserSussecc extends LoginSignupState {
  final UserLogin userLogin ;
  LoginUserSussecc(this.userLogin);
}
class LoginUserLoading extends LoginSignupState {}
class LoginUserError extends LoginSignupState {
  String error ;
  LoginUserError(this.error);
}

class LoginDoctorSussecc extends LoginSignupState {
  final DoctorLogin doctorLogin ;
  LoginDoctorSussecc(this.doctorLogin);
}
class LoginDoctorLoading extends LoginSignupState {}
class LoginDoctorError extends LoginSignupState {
  String error ;
  LoginDoctorError(this.error);
}
class LoginUserDataSuss extends LoginSignupState{
  final UserHome userHome;
  LoginUserDataSuss(this.userHome);
}
class LoginUserDataError extends LoginSignupState{}
class LoginDoctorDataSuss extends LoginSignupState{
  final DoctorLogin doctorLogin ;
  final DoctorHome doctorHome;
  LoginDoctorDataSuss(this.doctorHome , this.doctorLogin);
}

class LoginEmailSuss extends LoginSignupState{}
