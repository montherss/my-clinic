import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/main_screen_doctors.dart';
import 'package:myclinics/local/shared_pref/cach_helper.dart';
import 'package:myclinics/presentation/login_screen.dart';
import 'package:myclinics/presentation/privacy.dart';
import 'package:myclinics/presentation/signup_screen.dart';
import 'package:myclinics/users/cubit/login_signup_cubit.dart';
import 'package:myclinics/users/home_pationt/main_pationt.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginSignupCubit , LoginSignupState>(
      listener: (context, state) {
        LoginSignupCubit cubit = LoginSignupCubit.get(context);
        if(state is LoginSignupCheckInterNetError){
          cubit.inteNetReselt();
        }
        if(state is LoginSignupCheckInterNetSuss){

        }
      },
      builder: (context, state) {

        return Scaffold(
          body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(10),
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
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Lottie.asset("assets/lottie/online-doctor-app.json"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'عيادتي' ,
                          style: TextStyle(
                              fontSize: 35 ,
                              color: Colors.deepPurple ,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 2
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'تطبيق يتيح لك معرفة الأطباء الموجودين في مختلف محافظات المملكة' ,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18 ,
                            color: Colors.black54 ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  NavegatAndFinish(context,Directionality(textDirection: TextDirection.rtl, child: LogInScreen()));
                                },
                                child: Text(
                                  'تسجيل دخول',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child: SignUpScreen()));
                                },
                                child: Text(
                                  'انشاء حساب',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("عند انشاء حساب فانت موافق علي " , style: TextStyle(fontSize: 13),),
                              TextButton(onPressed: (){
                                showDialog(context: context, builder: (context) {
                                  return PrivacyDialog(mdFileName:'privacy.md');
                                },);
                              }, child:Text("سياسة الحصوصية و البنود"))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

