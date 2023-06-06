import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/updateFreeTime.dart';
import 'package:myclinics/models/doctorHome.dart';

import '../component/component.dart';
import '../constant/constant.dart';

class TableTimeScreen extends StatelessWidget {
  const TableTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
        if(state is DocrosDeleteFreeTimeSuss){
          if(state.verification.status=="success"){
            showTost("تم الحذف بنجاح", Colors.green);
            DoctorsCubit.get(context).getDoctor(DOCTORID);
          }else{
            showTost("فشل", Colors.green);
          }
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        cubit.getFreeTime();
        cubit.filterFreeTime();
        cubit.sortFreeTime();
        print("AKASDL");
        return Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ConditionalBuilder(
              condition: cubit.freeTimeLastList.isNotEmpty,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => tableTimeBuilder(cubit.freeTimeLastList[index] , context , cubit),
                separatorBuilder: (context, index) => SizedBox(height: 50 , child: Divider(height: 10 , thickness: 2,),),
                itemCount:cubit.freeTimeLastList.length,
              ),
              fallback: (context) => Column(
                children: [
                  Text(
                    "لا يوجد مواعيد !",
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
        );
      },
    );
  }
}

Widget tableTimeBuilder(FreeTime freeTime, context , DoctorsCubit cubit)=>
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
                  'العنوان :- ${freeTime.freeTimeTitle}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' ملاحظات:-${freeTime.freeTimeNote}'),
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
                        '${freeTime.freeTimeDate}',
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
                            '${freeTime.freeTimeStatedTime}',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("الى", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 5,
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
                            '${freeTime.freeTimeEndTime}',
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
            Text('حالة الموعد', style: TextStyle(fontSize: 20  ,fontWeight: FontWeight.bold , color: Colors.black54),),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                  child: freeTime.freeTimeAvailable==0?Text(
                    'متاح',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.green),
                  ):Text(
                    'قيد انتظار الموافقة أو الرفض',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.orangeAccent),
                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            freeTime.freeTimeAvailable==0
                ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    ShowDialog(
                        title: Text('تعديل الموعد') ,
                        content: Text('هل انت متأكد ؟') ,
                        actions: [
                          TextButton(onPressed: (){
                            NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child:  UpdateFreeTime(freeTime)));
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
                        'تعديل',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ShowDialog(
                        title: Text('حذف الموعد ') ,
                        content: Text('هل انت متأكد ؟') ,
                        actions: [
                          TextButton(onPressed: (){
                            cubit.deleteFreeTimeDoctor(freeTime_doctor_id: freeTime.freeTimeDoctorId.toString(), freeTime_id: freeTime.freeTimeId.toString());
                            Navigator.pop(context);
                            print("suss");
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
                        'حذف',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
                :
            Text('الرجاء الموافقة او الرفض على المراجع'),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );