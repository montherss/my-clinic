import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/models/free_time.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../constant/constant.dart';
import 'home_pationt.dart';
import 'main_pationt.dart';

class DoctorScheduleScreen extends StatelessWidget {
  final Doctor doctors;
  final String doctorsID;

  DoctorScheduleScreen({required this.doctors, required this.doctorsID});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (doctors.freetime == null) {
          doctors.freetime = [];
        }

        return Scaffold(
            backgroundColor: Colors.white,
            body: StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'اختيار الموعد',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: HexColor('#8a00e6'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.sortedFreeTime = [];
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: HexColor('#8a00e6'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (doctors.freetime!.isNotEmpty ||
                            doctors.freetime != null)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.getCurrentDay().toString(),
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black54),
                                ),
                                Text(
                                  "اليوم",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: DatePicker(
                                    DateTime.now(),
                                    height: 100,
                                    width: 80,
                                    initialSelectedDate: DateTime.now(),
                                    selectionColor: Colors.deepPurple,
                                    selectedTextColor: Colors.white,
                                    dateTextStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    onDateChange: (day) {

                                      cubit.sortedFreeTimeScedule(
                                          doctors, cubit.getDayString(day));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ConditionalBuilder(
                          condition: snapshot.data != ConnectivityResult.none,
                          builder: (context) => ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  TimeLineSceduileBuilder(
                                      cubit.sortedFreeTime[index],
                                      context,
                                      cubit,
                                      doctorsID,
                                      state),
                              separatorBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: random(150,300),
                                    height:4,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],),
                              itemCount: cubit.sortedFreeTime.length),
                          fallback: (context) => Center(
                            child: Lottie.asset(
                                "assets/lottie/no-internet-connection.json"),
                          ),
                        ),
                        if (cubit.sortedFreeTime.isEmpty)
                          Center(
                              child: Column(
                            children: [
                              Text(
                                'لا توجد مواعيد متاحة',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Lottie.asset("assets/lottie/empty.json"),
                            ],
                          ))
                      ],
                    ),
                  );
                }));
      },
    );
  }
}

Widget TimeLineSceduileBuilder(Freetime doctors, context, HomeCubit cubit,
        String doctorID, HomeState state) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${doctors.freeTimeStatedTime}" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
              ListGen(),
              Text("${doctors.freeTimeEndTime}", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
              SizedBox(height: 30,)
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.deepPurple
                  //color: Color(0xfffcf9f5),
                  ),
              child: Container(
                  height: 125,
                  margin: EdgeInsets.only(right: 6),
                  color: Color(0xfffcf9f5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.access_time),
                            SizedBox(width: 5,),
                            Text(
                              "${doctors.freeTimeStatedTime}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${doctors.freeTimeEndTime}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${doctors.freeTimeDay}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "العنوان : - ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                "${doctors.freeTimeTitle}",
                                style: TextStyle(fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "الملاحظات : - ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                "${doctors.freeTimeNote}",
                                style: TextStyle(fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "التاريخ : - ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                "${doctors.freeTimeDate}",
                                style: TextStyle(fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          )),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConditionalBuilder(
                            condition: state is! HomeSubMitUserLoading ||
                                state is! HomeSubMitUserCheldrenLoading,
                            builder: (context) => InkWell(
                              onTap: () {
                                ShowDialog(
                                  context: context,
                                  title: Text(
                                    "اضافة الموعد",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  actions: [
                                    if (cubit
                                        .userHome!.data!.children!.isNotEmpty)
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: AlertDialog(
                                                  title: Text(
                                                    "الأبناء",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          ShowDialog(
                                                              context: context,
                                                              title: Text(
                                                                "تأكيد الطلب",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit
                                                                          .subMitUserChildrenScedule(
                                                                        user_id: cubit
                                                                            .userHome!
                                                                            .data!
                                                                            .user![0]
                                                                            .userId
                                                                            .toString(),
                                                                        doctor_id:
                                                                            doctorID,
                                                                        startTime:
                                                                            doctors.freeTimeStatedTime!,
                                                                        date: doctors
                                                                            .freeTimeDate!,
                                                                        endTime:
                                                                            doctors.freeTimeEndTime!,
                                                                        freeTimeId:
                                                                            doctors.freeTimeId!,
                                                                        user_name: cubit
                                                                            .userHome!
                                                                            .data!
                                                                            .user![0]
                                                                            .userName!,
                                                                        chiled_name: cubit
                                                                            .userHome!
                                                                            .data!
                                                                            .children![cubit.selectedRadio]
                                                                            .childrenName!,
                                                                        chiled_age: cubit
                                                                            .userHome!
                                                                            .data!
                                                                            .children![cubit.selectedRadio]
                                                                            .childrenAge!,
                                                                      );
                                                                      NavegatAndFinish(
                                                                          context,
                                                                          (Directionality(
                                                                            textDirection:
                                                                                TextDirection.rtl,
                                                                            child:
                                                                                MainPationtScreen(),
                                                                          )));
                                                                    },
                                                                    child: Text(
                                                                        "تأكيد")),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "عودة")),
                                                              ],
                                                              content: Text(
                                                                  "هل انت متأكد من أختيار ${cubit.userHome!.data!.children![cubit.selectedRadio].childrenName}"));
                                                        },
                                                        child: Text("تأكيد")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("عودة")),
                                                  ],
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          for (int i = 0;
                                                              i <=
                                                                  cubit
                                                                          .userHome!
                                                                          .data!
                                                                          .children!
                                                                          .length -
                                                                      1;
                                                              i++)
                                                            RadioListTile(
                                                              title: Text(
                                                                  '${cubit.userHome!.data!.children![i].childrenName}'),
                                                              value: i,
                                                              groupValue: cubit
                                                                  .selectedRadio,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  cubit.selectedRadio =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  elevation: 1,
                                                ),
                                              ),
                                              barrierDismissible: true,
                                            );
                                          },
                                          child: Text("ابني")),
                                    TextButton(
                                        onPressed: () {
                                          cubit.subMitUserScedule(
                                              user_id: cubit.userHome!.data!
                                                  .user![0].userId
                                                  .toString(),
                                              doctor_id: doctorID,
                                              startTime:
                                                  doctors.freeTimeStatedTime!,
                                              date: doctors.freeTimeDate!,
                                              endTime: doctors.freeTimeEndTime!,
                                              freeTimeId: doctors.freeTimeId!,
                                              user_name: cubit.userHome!.data!
                                                  .user![0].userName!);

                                          NavegatAndFinish(
                                              context,
                                              (Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: MainPationtScreen(),
                                              )));
                                        },
                                        child: Text("شخصي")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("عودة")),
                                  ],
                                  content:
                                      Text("هل انت متأكد من اضافة الموعد ؟"),
                                );
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'اضافة الموعد',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            fallback: (context) => CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );


Widget ListGen() =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: 20,
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: 40,
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: 30,
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: 40,
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: 10,
            height: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
double random(int min, int max) {
  return min + Random().nextInt(max - min).toDouble();
}