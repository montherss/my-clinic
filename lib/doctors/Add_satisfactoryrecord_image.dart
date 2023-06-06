import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../component/component.dart';
import '../constant/constant.dart';
import '../models/doctorHome.dart';

class AddSatisFactoryRecordImage extends StatelessWidget {

  final Upcomingschedule users;
  AddSatisFactoryRecordImage(this.users);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
        if(state is DoctorAddSatisFactoryRecordImageSuss){
          if(state.verification.status=="success"){
            showTost("تم رفع الملف بنجاح", Colors.green);
            DoctorsCubit.get(context).getDoctor(DOCTORID);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
          else if (state.verification.status=="imageSizeError"){
            showTost("الرجاء اختيار صوره اقل من 3 MB", Colors.red);
          }
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('كتابة الكشف الطبي' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              cubit.clrearImage();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            icon:
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.deepPurple,
                            )
                        ),
                      ],
                    ) ,
                    SizedBox(
                      height: 50,
                    ),
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
                    SizedBox(
                      height: 20,
                    ),
                    if(cubit.xfile==null)
                     Container(
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                          onPressed: ()async{
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: ()async{
                                          PermissionStatus storeg = await Permission.storage.request();
                                          if(storeg == PermissionStatus.granted){
                                            cubit.selectImageFromeGallary();
                                            Navigator.pop(context);
                                          }else{
                                            showTost("Error", Colors.red);
                                          }
                                        },
                                        child: Container(
                                          alignment: AlignmentDirectional.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "المعرض",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: ()async{
                                          PermissionStatus camera = await Permission.camera.request();
                                          if(camera == PermissionStatus.granted){
                                            cubit.selectImageFromeCamera();
                                            Navigator.pop(context);
                                          }else{
                                            showTost("Error", Colors.red);
                                          }
                                        },
                                        child: Container(
                                          alignment: AlignmentDirectional.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "الكاميرا",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ارفق صورة" , style: TextStyle(fontSize: 18 , color: Colors.white),),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.photo , color: Colors.white,),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Text("ان لا يزيد حجم الصوره عن 3MB" , style: TextStyle(color: Colors.red),),
                    if(cubit.xfile!=null)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.red,
                                width: 2
                            )
                        ),
                        child: Column(
                          children: [
                            IconButton(onPressed: (){
                              ShowDialog(
                                  context: context,
                                  title: Text("هل انت متأكد ؟"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      cubit.clrearImage();
                                      Navigator.pop(context);
                                    }, child: Text("تأكيد")),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("عودة")),
                                  ],
                                  content: SizedBox(),
                              );
                            }, icon: Icon(Icons.remove_circle , color: Colors.red,)),
                            Row(
                              children: [
                                Icon(Icons.photo , color: Colors.red,),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text("${cubit.xfile?.path}" , maxLines: 3, overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                            ConditionalBuilder(
                                condition: state is! DoctorAddSatisFactoryRecordImageLoading ,
                                builder:  (context) =>   Button(
                                    text: "رفع الصورة ",
                                    function: (){
                                      print(users.upcomingScheduleId.toString());
                                      cubit.addSatisfactoryImage(
                                        satisfactoRyrecord_user_id: users.upcomingScheduleUserId.toString(),
                                        satisfactoRyrecord_doctor_id: users.upcomingScheduleDoctorId.toString(),
                                        doctor_name: doctoRHome!.data!.doctor![0].doctorName!,
                                        doctor_image: cubit.doctorHome!.data!.doctor![0].doctorImageUrl.toString(),
                                        satisfactoRyrecord_date:  DateFormat('yyyy-MM-dd').format(DateTime.now()) ,
                                        upcomingSchedule_id: users.upcomingScheduleId.toString(),
                                        satisfactoRyrecord_time:  DateFormat("hh:mm a").format(DateTime.now()),
                                        satisfactoRyrecord_status: "1",
                                        file: cubit.myImage!,
                                      );
                                    }
                                ),
                                fallback: (context) =>  Center(child: CircularProgressIndicator(),),
                            )
                          ],
                        ),
                      ),
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
