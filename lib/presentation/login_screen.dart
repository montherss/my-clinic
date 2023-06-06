import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/local/shared_pref/cach_helper.dart';
import 'package:myclinics/network/https_helper.dart';
import 'package:myclinics/presentation/signup_screen.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/cubit/login_signup_cubit.dart';

import '../constant/constant.dart';
import '../doctors/main_screen_doctors.dart';
import '../models/userHome.dart';
import '../users/home_pationt/main_pationt.dart';
import 'froget_password.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<LoginSignupCubit , LoginSignupState>(
      listener: (context, state) async{
        if(state is LoginUserDataSuss){
          showTost("تم تسجيل الدخول بنجاح", Colors.green);
          useRHome = state.userHome;
          USERID = state.userHome.data!.user![0].userId.toString();
          CacheHepler.setData("id",state.userHome.data!.user![0].userId.toString());
          NavegatAndFinish(context, Directionality(textDirection: TextDirection.rtl, child: MainPationtScreen()));
        }
        else if (state is LoginDoctorDataSuss){
          if(state.doctorHome.status! == "success") {
            showTost(state.doctorHome.status!, Colors.green);
            doctoRHome = state.doctorHome;
            CacheHepler.setData("DoctorID", state.doctorHome.data!.doctor![0].doctorId);
            NavegatAndFinish(context, Directionality(
                textDirection: TextDirection.rtl, child: MainScreenDoctors()));
          }else if (state.doctorHome.data!.doctor!.isEmpty){
            print('>>>>>>>>>>>>>>>>>>>>>>');
          }
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if(snapshot.data==ConnectivityResult.none)
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
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("assets/image/doctors.png"),
                          ),
                          Text(
                            'تسجيل الدخول' ,
                            style: TextStyle(
                              color: DefaultSelectionStyle.defaultColor ,
                              fontSize: 30 ,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.phone) ,
                              keyboardType: TextInputType.phone ,
                              labelText: 'رقم الهاتف',
                              controller: phoneController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال رقم الهاتف';
                                }else if (value.length!= 10){
                                  return 'الرجاء ادخال رقم صحيح';
                                }
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.lock) ,
                              keyboardType: TextInputType.visiblePassword ,
                              labelText: 'كلمة السر',
                              controller: passwordController,
                              obscureText: cubit.ObsText,
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.ObsTextChange(cubit.ObsText);
                                  },
                                  icon:  cubit.ObsText?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال كلمة السر';
                                }return null ;
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginDoctorLoading || state is! LoginUserLoading,
                            builder: (context) => Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    if(snapshot.data==ConnectivityResult.none){
                                      showTost("الرجاء التحقق من الأتصال بالانترنت", Colors.red);
                                    }else{
                                      cubit.loginUser(phoneNumber: phoneController.text , password: passwordController.text);
                                    }
                                  }
                                },
                                child: Text('تسجيل الدخول' , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),),
                              ),
                            ),
                            fallback: (context) => Lottie.asset("assets/lottie/loding.json",width: 100 , height: 100),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('هل تملك حساب ؟'),
                              TextButton(
                                  onPressed: (){
                                    NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child: SignUpScreen()));
                                  },
                                  child: Text('سجل حساب الأن !')
                              ),
                              Spacer(),
                              TextButton(onPressed: (){
                               NavegatTo(context,   Directionality(textDirection: TextDirection.rtl,child: ForgetPassword(),));
                              }, child: Text("نسيت كلمة السر!"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        );
      },
    );
  }
}

