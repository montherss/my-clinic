import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/models/doctorHome.dart';
import 'package:myclinics/models/doctorLogin.dart';
import 'package:myclinics/models/userLogin.dart';
import 'package:myclinics/users/otp_screen.dart';
import 'package:http/http.dart'as http;

import '../../component/component.dart';
import '../../models/userHome.dart';
import '../../models/verification..dart';
import '../../network/https_helper.dart';

part 'login_signup_state.dart';

class LoginSignupCubit extends Cubit<LoginSignupState> {
  LoginSignupCubit() : super(LoginSignupInitial());

  static LoginSignupCubit get(context) => BlocProvider.of(context);
  UserHome? userHome;
  bool ObsText = true;
  int group = 0;
  String gender = '';
  String ? otp = '';
  bool loadingAuth = false;
  bool passwordRols = false;
  bool IsValed = false;
  bool? checkConnection;
  Map testData ={};
  DateTime currentDate = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  void getUser(String id)async{
    try{
      await Crud.getUerFromHttp(linkUrl: USERHOME, id: id).then((value){
        userHome = UserHome.fromJson(value);
        emit(LoginUserDataSuss(userHome!));
      }).catchError((onError){
        print(onError.toString());
        emit(LoginUserDataError());
      });
    }catch(e){
      print(e.toString());
    }
  }
  void getDataFromHttp()async{
    await Crud.getDate(
        linkUrl: TEST
    ).then(
            (value)
        {
          testData = value;
          print(testData);
        }
    ).catchError((onError){
      print('THEN ERROR');
    });
  }
  void postDataFromApp({
    required String name ,
    required String name2 ,
    required String name3 ,
    required String  email,
    required String gender ,
    required String phoneNumber ,
    required String age ,
    required String passWord ,
  })async{
    await Crud.postData(
        linkUrl: SIGNUP ,
        name: name ,
        name2: name2 ,
        name3: name3 ,
        email: email ,
        gender: gender ,
        phoneNumber: phoneNumber ,
        age: age ,
        passWord: passWord
    ).then((value){
      print(value);
    }).catchError((onError){
      print(onError.toString());
    });
  }
  inteNetReselt()async{
    checkConnection = await CheckInterNetConnection() ;
  }
  void selectedDateTime(DateTime time){
    currentDate = time ;
    emit(LoginSighupSelectedDateTime());
  }
  CheckInterNetConnection()async{
    try{
      var res = await InternetAddress.lookup("google.com");
      if(res.isNotEmpty && res[0].rawAddress.isNotEmpty){
        emit(LoginSignupCheckInterNetSuss());
        return true ;
      }
    }catch(e){
      emit(LoginSignupCheckInterNetError());
      return false ;
    }
  }
  Verification? verification;
  void ChangepasswordRols(bool pass){
    passwordRols = pass;
    emit(LoginSignupChangePasswordRoles());
  }
  void ChangeRadio(int i ){
    group = i ;
    if(i == 1){
      gender = 'ذكر';
    }else{
      gender = 'انثى';
    }
    emit(LoginSignupChangeRadio());
  }
  void ObsTextChange(bool obs){
    ObsText = !obs ;
    emit(LoginSignupObsText());
  }
  void otpNumber (String number)async{
    otp = number ;
    emit(LoginSignupOTP());
  }
  bool OTPLoding = false ;
  void otpAuth ({ required String phoneNumber ,required String firstName,required String secandName , required String lastName ,required String email ,required String gender   ,required String age ,required String password, context})async{

    emit(LoginSignupOTPLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+962${phoneNumber}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        emit(LoginSignupOTPSussecc());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(LoginSignupOTPErrorPhoneNumber(e));
      },
      codeSent: (String verificationId, int? resendToken) {
        NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: OtpScreen(phoneController:phoneNumber,verificationId: verificationId,gender: gender , email: email , secandName: secandName , password: password , lastName: lastName , firstName: firstName ,age: age,)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    ).catchError((onError){print(onError.toString());});
  }
  void otpSendCode (String verificationId ,String smsCode)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try{
      await auth.signInWithCredential(credential);
      emit(LoginSignupOTPSussecc());
    }catch(e){
      emit(LoginSignupOTPError(e.toString()));
    }
  }

  void getDoctor(String id)async{
    await Crud.getDoctorFromHttp(linkUrl: DOCTOR_DATA, id: id).then((value){
      doctoRHome = DoctorHome.fromJson(value);
      emit(LoginDoctorDataSuss(doctoRHome! , doctorLogin!));
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
      print(onError.toString());
    });
  }
  DoctorLogin? doctorLogin;
  void loginDoctors({required String phoneNumber , required String password})async{
    emit(LoginDoctorLoading());
    await Crud.loginDoctors(linkUrl: LOGIN_DOCTORS, phoneNumber: phoneNumber, password: password).then((value){
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      print(value.toString());
      doctorLogin = DoctorLogin.fromJson(value);
      print(doctorLogin?.status);
      if(doctorLogin?.status=="failuer"){
        showTost("رقم الهاتف او كلمة السر غير صحيحين", Colors.red);
      }else {
        getDoctor(doctorLogin!.data![0].doctorId!.toString());
      }
      print(">>>>>>>>>>>>>>>>>>>>");
      emit(LoginDoctorSussecc(doctorLogin!));
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
      print(onError.toString());
      emit(LoginDoctorError(onError.toString()));
    });
  }
  UserLogin? userLogin;

  void loginUser({required String phoneNumber , required String password})async{
    emit(LoginUserLoading());
    print("Hi all");
    await Crud.loginUser(linkUrl: LOGIN_USER, phoneNumber: phoneNumber, password: password).then((value){
      userLogin = UserLogin.fromJson(value);
      print(userLogin!.status);
      if(userLogin!.status == 'failuer'){
        loginDoctors(phoneNumber: phoneNumber, password: password);
      }else{
        print("HI ALLL");
        getUser(userLogin!.data![0].userId.toString());
      }
    }).catchError((onError){
      print(onError.toString());
      emit(LoginUserError(onError.toString()));
    });
  }
  void checkPhoneEmail({required String userPhone , required String userEmail})async{
    emit(LoginSighupCheckPhoneEmailLoding());
    print(userPhone);
    await Crud.checkPhoneEmail(linkUrl: VERIFICATION, userPhone: userPhone.substring(1), userEmail: userEmail).then((value){
      verification = Verification.fromJson(value);
      print(verification!.status);
      emit(LoginSighupCheckPhoneEmailSuss(verification));
    }).catchError((onError){
      print(onError.toString());
      emit(LoginSighupCheckPhoneEmailError());
    });
  }
  void emailAuth(String email , String password){
    FirebaseAuth.instance.createUserWithEmailAndPassword (email: email, password: password).then((value){
      print(value);
      emit(LoginEmailSuss());
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void signUpUser({
    required String name ,
    required String name2 ,
    required String name3 ,
    required String  email,
    required String gender ,
    required String phoneNumber ,
    required String age ,
    required String passWord ,
})async{
    await Crud.postData(linkUrl: SIGNUP, name: name, name2: name2, name3: name3, email: email, gender: gender, phoneNumber: phoneNumber, age: age, passWord: passWord).then((value){
      print(value);
    }).catchError((onError){
      print(onError.toString());
    });
  }

}
