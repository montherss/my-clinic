import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/cubit/login_signup_cubit.dart';
import 'package:pinput/pinput.dart';

import '../presentation/login_screen.dart';
import '../presentation/signup_complet.dart';

class OtpScreen extends StatelessWidget {

  final String phoneController ;
  final String verificationId ;
  final String email ;
  final String firstName ;
  final String lastName ;
  final String password ;
  final String secandName ;
  final String gender ;
  final String age ;

  OtpScreen({required this.phoneController , required this.verificationId, required this.gender, required this.email , required this.firstName , required this.lastName , required this.password , required this.secandName , required this.age});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginSignupCubit , LoginSignupState>(
      listener: (context, state) {
        LoginSignupCubit cubit = LoginSignupCubit.get(context);
        if (state is LoginSignupOTPError){
          if(state.e.toString() == '[firebase_auth/invalid-verification-code] The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again.'){
            showTost('رمز التحقق غير صحيح', Colors.red);
          }
        }
        else if(state is LoginSignupOTPSussecc){
          cubit.signUpUser(name: firstName, name2: secandName, name3: lastName, email: email, gender: gender, phoneNumber: phoneController, age: age, passWord: password);
          NavegatAndFinish(context, SignUpComplete());
        }
      },
      builder: (context, state) {
        LoginSignupCubit cubit = LoginSignupCubit.get(context);

        return Scaffold(
          body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if(snapshot==ConnectivityResult.none)
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الرجاء التحقق من الأتصال بالانترنت',style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                                Icon(Icons.error_outline , color:  Colors.white,),

                              ],
                            ),
                          ),
                        Lottie.asset('assets/lottie/zpunet-icon.json' , width: 250 , height: 250),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('رسالة التحقق' , style: TextStyle(fontSize: 30 , color:  Colors.deepPurple , fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Text(
                          'ستصلك رسالة نصية على الرقم ${phoneController} لتوثيق حسابك الرجاء ادخال رمز الرسالة' , style: TextStyle(fontWeight: FontWeight.w700 , color: Colors.black54 ,fontSize: 18),),
                        SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.deepPurple,
                                ),
                              ),
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )
                            ),
                            onCompleted: (value){
                              cubit.otpNumber(value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Button(
                            text: 'تحقق من الرمز',
                            function: (){
                              print(cubit.otp?.length.toString());
                              if(cubit.otp?.length != 0){
                                if(cubit.otp?.length == 6){
                                  if(snapshot.data==ConnectivityResult.none){
                                    showTost("الرجاء التحقق من الأتصال بالأنترنت", Colors.red);
                                  }else{
                                    cubit.otpSendCode(verificationId, cubit.otp!);
                                  }
                                }else {
                                  showTost('الرجاء ادخال 6 ارقام', Colors.red);
                                }
                              } else{
                                showTost('الرجاء ادخال 6 ارقام', Colors.red);
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
}

