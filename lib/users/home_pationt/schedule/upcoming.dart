import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/models/upcoming.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../../component/component.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is HomeCancelUpcomingSuss){
          showTost("تم الغاء الموعد بنجاح", Colors.green);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.filterUpcoming();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              if (cubit.userHome!.data!.upcomingschedule!.isNotEmpty)
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => UpcomingSchBuilder(cubit,
                      cubit.userHome!.data!.upcomingschedule![index], context),
                  separatorBuilder: (context, index) => Divider(
                    height: 50,
                  ),
                  itemCount: cubit.userHome!.data!.upcomingschedule!.length,
                ),
              if (cubit.userHome!.data!.upcomingschedule!.isEmpty)
                Center(
                  child: Column(
                    children: [
                      Text(
                        "لا توجد نتائج !",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Lottie.asset("assets/lottie/empty.json"),
                    ],
                  ),
                ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget UpcomingSchBuilder(HomeCubit cubit, Upcomingschedule models, context) =>
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
          children: [
            ListTile(
              title: Text(
                '${models.doctorName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  '${models.doctorSpecialization}  , ${models.doctorState}'),
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${models.doctorImageUrl}'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      '${models.upcomingScheduleDate}',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
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
                          '${models.upcomingScheduleStartTime}',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: models.upcomingScheduleStatuse == 'تم الموافقة'
                            ? Colors.green
                            : models.upcomingScheduleStatuse ==
                                    'بانتظار الموافقة'
                                ? Colors.orangeAccent
                                : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${models.upcomingScheduleStatuse}',
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (models.upcomingScheduleStatuse == "بانتظار الموافقة")
                  InkWell(
                    onTap: () {
                      ShowDialog(
                        context: context,
                        title: Text(
                          "الغاء الموعد",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                cubit.cancelUpComing(
                                    user_id:
                                    cubit.userHome!.data!.user![0].userId.toString(),
                                    freeTimeId:
                                    models.upcomingscheduleFreeTimeId.toString()
                                );
                                cubit.getUser(USERID);
                                Navigator.pop(context);
                              },
                              child: Text("تأكيد")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("عودة")),
                        ],
                        content: Text("هل انت متأكد من الغاء الموعد ؟"),
                      );

                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: HexColor('#f4f6fa'),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'الغاء',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (models.upcomingScheduleStatuse == 'تم الرفض')
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ملاحظات : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 18),
                    ),
                    Text(
                      '${models.upcomingScheduleNotest} ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
