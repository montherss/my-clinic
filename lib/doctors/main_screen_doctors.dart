import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/doctors/add_free_time.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/models/userHome.dart';

import '../ServerError.dart';
import '../connectionError.dart';

class MainScreenDoctors extends StatelessWidget {
  const MainScreenDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit,DoctorsState>(
      listener: (context, state) {
        if(state is DoctorServerError){
          if(state.error == "FormatException: Unexpected character (at line 3, character 1)SQLSTATE[HY000] [2002] No connection could be made because the target machi...")
          showTost("Error", Colors.red);
        }

      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        cubit.doctorHome = doctoRHome;
        DOCTORID = cubit.doctorHome?.data?.doctor?[0].doctorId.toString();
        FirebaseMessaging.instance.subscribeToTopic("doctor${cubit.doctorHome?.data?.doctor?[0].doctorId}");
        cubit.getDoctorToken();
        //cubit.upDateDoctorToken(doctor_id: cubit.doctorHome?.data?.doctor?[0].doctorId.toString(), token: cubit.token.toString());
        return ConditionalBuilder(
            condition: cubit.doctorHome?.data?.doctor?[0] != null,
            builder: (context) => StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  return Scaffold(
                      body:snapshot.data==ConnectivityResult.none?ConncectionError(): cubit.Screens[cubit.curentIndex],
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: (){
                          NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: AddFreeTime()));
                        },
                      ),
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: BottomAppBar(
                        shape: CircularNotchedRectangle(),
                        notchMargin: 10,
                        child: Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    minWidth: 40,
                                    onPressed: (){
                                      cubit.ChangeNavBar(0);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.home_outlined,
                                          color: cubit.curentIndex==0?Colors.deepPurple:Colors.grey,
                                          size: 28,
                                        ),
                                        Text('الرئيسية' , style: TextStyle(color: cubit.curentIndex==0?Colors.deepPurple:Colors.grey,),),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    minWidth: 40,
                                    onPressed: (){
                                      cubit.ChangeNavBar(1);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: cubit.curentIndex==1?Colors.deepPurple:Colors.grey,
                                          size: 28,
                                        ),
                                        Text('المواعيد' , style: TextStyle(color: cubit.curentIndex==1?Colors.deepPurple:Colors.grey,),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    minWidth: 40,
                                    onPressed: (){
                                      cubit.ChangeNavBar(2);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.table_chart_outlined,
                                          color: cubit.curentIndex==2?Colors.deepPurple:Colors.grey,
                                          size: 28,
                                        ),
                                        Text('الجدول' , style: TextStyle(color: cubit.curentIndex==2?Colors.deepPurple:Colors.grey,),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  MaterialButton(
                                    minWidth: 40,
                                    onPressed: (){
                                      cubit.ChangeNavBar(3);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.settings_outlined,
                                          color: cubit.curentIndex==3?Colors.deepPurple:Colors.grey,
                                          size: 28,
                                        ),
                                        Text('الضبط' , style: TextStyle(color: cubit.curentIndex==3?Colors.deepPurple:Colors.grey,),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  );
                }
            ),
            fallback:(context) => ServerError(),
        );
      },
    );
  }
}
