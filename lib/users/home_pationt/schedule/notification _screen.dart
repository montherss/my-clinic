import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/models/notification.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../../models/notification_user.dart';

class NotificationScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.sortNotification();
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الأشعارات' , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.deepPurple,
                        )
                          ,
                        ),
                        IconButton(
                            onPressed: ()
                            {
                              Navigator.pop(context);
                              }
                              ,
                            icon: Icon(Icons.arrow_forward_ios , color: Colors.deepPurple , size: 30,)),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ConditionalBuilder(
                        condition: notificatioNUser!.notification!.isNotEmpty||notificatioNUser!.notification!=null,
                        builder: (context) =>  ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => NotificationBuilder( cubit.sortedNotifi[index] , context),
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: cubit.sortedNotifi.length,
                        ),
                        fallback: (context) => Column(
                          children: [
                            Text(
                              "لا يوجد مواعيد  !",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Lottie.asset("assets/lottie/empty.json"),
                          ],
                        ),
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

Widget NotificationBuilder(Notificationss notifications , context)=>
    Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
          ]),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                '${notifications.notificationTitle}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${notifications.notificationBody}'),
              trailing: CircleAvatar(
                radius: 25,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: notifications.notificationUserDoctorImage==null||notifications.notificationUserDoctorImage==""?NetworkImage("https://static.pexels.com/photos/36753/flower-purple-lical-blosso.jpg"):NetworkImage("${notifications.notificationUserDoctorImage}"),
                    ),
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: notifications.notificationState==1?Colors.green:notifications.notificationState==2?Colors.red:Colors.amber,
                        child: notifications.notificationState==1?Icon(Icons.check , color: Colors.white, size: 15):notifications.notificationState==2?Icon(Icons.remove , size: 20,color: Colors.white,):Icon(Icons.checklist_rtl , color: Colors.white, size: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${notifications.notificationTime}',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${notifications.notificationUserHoure}',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );