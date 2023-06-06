import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/presentation/login_screen.dart';

import 'component/component.dart';
import 'constant/constant.dart';
import 'doctors/main_screen_doctors.dart';
import 'models/doctorHome.dart';

class ServerError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("حدث خطأ في الخوادم !" , style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                    Center(
                      child: Container(
                        child: Lottie.asset("assets/lottie/505-error.json" ),
                      ),
                    ),
                    Button(
                        function: (){
                          NavegatAndFinish(context, Directionality(textDirection: TextDirection.rtl, child:LogInScreen()));
                        },
                        text: "قم بتسجيل الدخول"
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
