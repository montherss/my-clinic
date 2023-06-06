import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/satisfactoryRecord_screen.dart';
import 'package:myclinics/models/doctorHome.dart';


import 'Add_satisfactoryrecord_image.dart';
import 'add_satisfactoryrecord.dart';

class DoneScreenDoctors extends StatelessWidget {
  const DoneScreenDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit, DoctorsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<DoctorsCubit, DoctorsState>(
          listener: (context, state) {},
          builder: (context, state) {
            DoctorsCubit cubit = DoctorsCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => DoneUserBuilder(cubit.userWhoAcceptOrReject[index] , context , cubit ),
                      separatorBuilder: (context, index) => Divider( height:  50 , thickness:  2,),
                      itemCount: cubit.userWhoAcceptOrReject.length,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
Widget DoneUserBuilder(Upcomingschedule users , context , DoctorsCubit cubit)=>
    Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2)
          ]),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(
                'اسم المريض :- ${users.userName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تاريخ الميلاد : - ${users.user_age}  , ${users.user_gender} '),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('رقم الهاتف :- ${users.user_phoneNumber}'),

                        TextButton(onPressed: (){
                          cubit.callNumber(users.user_phoneNumber.toString());
                        }, child: Row(
                          children: [
                            Text('اتصل الأن'),
                            SizedBox(width: 5,),
                            Icon(Icons.phone),
                          ],
                        ))
                      ],
                    ),
                    Text('البريد الألكتروني :- ${users.user_email}')
                  ],
                )
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
                        '${users.upcomingScheduleDate}',
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
                            '${users.upcomingScheduleStartTime}',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('حالة الطلب', style: TextStyle(fontSize: 20  ,fontWeight: FontWeight.bold , color: Colors.black54),),
            SizedBox(
              height: 10,
            ),
            users.upcomingScheduleStatuse=='تم الموافقة' ?
            Container(
              child: Column(
                children: [
                  Center(
                      child: Text(
                        'تم الموافقة',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.green),
                      )),
                  if(users.upcomingschedule_user_satis==0)
                    InkWell(
                    onTap: (){
                      ShowDialog(
                          context: context,
                          title: Text('كتابة كشف طبي'),
                          actions:[
                            TextButton(onPressed: (){
                             ShowDialog(
                                 context: context,
                                 title: Text("الكشف الطبي"),
                                 actions: [
                                   TextButton(onPressed: (){
                                     NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: AddSatisfactoyRecord(users)));
                                   }, child: Text('كتابة')),
                                   TextButton(onPressed: (){
                                     NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: AddSatisFactoryRecordImage(users)));
                                   }, child: Text('رفع صورة')),
                                   TextButton(onPressed: (){
                                     Navigator.pop(context);
                                   }, child: Text('عودة'))
                                 ],
                                 content: Text("شكل الكشف الطبي "),
                             );
                            }, child: Text('نعم')),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('لأ')),
                          ],
                          content:  Text('هل انت متأكد من كتابة كشف طبي ؟'),
                      );
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'رفع كشف طبي',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  if(users.upcomingschedule_user_satis==1)
                    Text("تم رفع الكشف المرضي للمريض")
                ],
              ),
            ):
            Container(
              child:Column(
                children: [
                    Text(
                'تم الرفض',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.red),
              ),
                    Text('ملاحظات' , style: TextStyle(fontSize: 20  ,fontWeight: FontWeight.bold , color: Colors.black54),),
                    Text('${users.upcomingScheduleNotest}' , style: TextStyle(fontSize: 18 , ),),
                ],
              )
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );

