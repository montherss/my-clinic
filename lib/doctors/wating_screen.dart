import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';

import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/models/doctorHome.dart';


class WatingScreenDoctors extends StatelessWidget {
  const WatingScreenDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
        if(state is DoctorApproveDoctorSuss){
          if(state.verification.status=="success"){
            showTost("تم الموافقة على الموعد", Colors.green);
          }else{
            showTost("فشل", Colors.red);
          }
        }
        if(state is DoctorCancelDoctorSuss){
          if(state.verification.status=="success"){
            showTost("تم رفض الموعد ", Colors.green);
          }else{
            showTost("فشل", Colors.red);
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<DoctorsCubit,DoctorsState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            DoctorsCubit cubit = DoctorsCubit.get(context);
            return ConditionalBuilder(
                condition: cubit.userWhoWating.isNotEmpty ,
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => WatingBuilder(cubit.userWhoWating[index] , context , cubit,state ),
                  separatorBuilder: (context, index) => Divider( height:  50 , thickness:  2,),
                  itemCount: cubit.userWhoWating.length,
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
            );
          },
        );
      },
    );
  }
}
Widget WatingBuilder(Upcomingschedule users , context , DoctorsCubit cubit, DoctorsState state)=>
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
                  users.upcomingscheduleUserChildren!=""?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اسم الأبن :- ${users.upcomingscheduleUserChildren}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("تاريخ ميلاد الأبن :- ${users.upcomingscheduleUserChildrenAge}"),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ):SizedBox(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ConditionalBuilder(
                    condition: state is! DoctorApproveDoctorLoading ,
                    builder: (context) => InkWell(
                      onTap: () {
                        ShowDialog(
                            title: Text('الموافقة على الموعد') ,
                            content: Text('هل انت متأكد ؟') ,
                            actions: [
                              TextButton(onPressed: (){
                                cubit.approveDoctor(
                                    user_id: users.upcomingScheduleUserId.toString(),
                                    doctor_id: users.upcomingScheduleDoctorId.toString(),
                                    upcoming_id: users.upcomingScheduleId.toString() ,
                                    freeTime_id: users.upcomingscheduleFreeTimeId.toString() ,
                                    doctor_name: cubit.doctorHome!.data!.doctor![0].doctorName!,
                                    date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                                    houre: DateFormat("hh:mm a").format(DateTime.now()).toString(),
                                    doctor_image: cubit.doctorHome!.data!.doctor![0].doctorImageUrl.toString()
                                );
                                Navigator.pop(context);
                              }, child: Text('نعم', style: TextStyle(fontWeight: FontWeight.bold))),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('لأ', style: TextStyle(fontWeight: FontWeight.bold)))
                            ] ,
                            context: context
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
                            'موافقة',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator(),),
                ),
                ConditionalBuilder(
                    condition: state is! DoctorCancelDoctorLoading,
                    builder: (context) => InkWell(
                      onTap: () {
                        ShowDialog(
                            title: Text('رفض الموعد ') ,
                            content: Text('هل انت متأكد ؟') ,
                            actions: [
                              TextButton(onPressed: (){
                                ShowDialog(
                                    title: Text('سبب الرفض') ,
                                    content: Text('الرجاء كتابة سبب الرفض') ,
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Form(
                                                key: cubit.FormKey,
                                                child: TextFeild(
                                                    labelText: 'سبب الرفض',
                                                    keyboardType: TextInputType.name ,
                                                    controller: cubit.refuserController,
                                                    validator: (value){
                                                      if(value==null||value.isEmpty){
                                                        return "الرجاء ادخال سبب الرفض";
                                                      }
                                                    }
                                                )
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(onPressed: (){
                                            if(cubit.FormKey.currentState!.validate()){
                                              cubit.cancelDoctor(
                                                  user_id: users.upcomingScheduleUserId.toString(),
                                                  doctor_id: users.upcomingScheduleDoctorId.toString(),
                                                  upcoming_id: users.upcomingScheduleId.toString(),
                                                  note: cubit.refuserController.text ,
                                                  freeTime_id: users.upcomingscheduleFreeTimeId.toString(),
                                                  doctor_name: cubit.doctorHome!.data!.doctor![0].doctorName!,
                                                  date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                                                  houre: DateFormat("hh:mm a").format(DateTime.now()).toString(),
                                                  doctor_image: cubit.doctorHome!.data!.doctor![0].doctorImageUrl.toString()
                                              ) ;
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }
                                          }, child:Text('ارسال')),
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }, child:Text('عودة')),
                                        ],
                                      )
                                    ] ,
                                    context: context
                                );
                              }, child: Text('نعم' , style: TextStyle(fontWeight: FontWeight.bold),)),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('لأ', style: TextStyle(fontWeight: FontWeight.bold)))
                            ] ,
                            context: context
                        );
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'رفض',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator(),),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
