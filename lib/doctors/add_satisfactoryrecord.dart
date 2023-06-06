

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../component/component.dart';
import '../constant/constant.dart';
import '../models/doctorHome.dart';
import 'cubit_doctors/doctors_cubit.dart';

class AddSatisfactoyRecord extends StatelessWidget {
  final Upcomingschedule users;
  AddSatisfactoyRecord(this.users);
  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var inspectionController = TextEditingController();
    var phaController = TextEditingController();
    var noteController = TextEditingController();
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
        if(state is DoctorAddSatisDoctorSuss){
          if(state.verification.status=="success"){
            showTost("تم الأضافة بنجاح", Colors.green);
            DoctorsCubit.get(context).getDoctor(DOCTORID);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }else{
            showTost("فشل", Colors.red);
          }
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        cubit.xfile==null;
        cubit.myImage==null;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('كتابة الكشف الطبي' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
                          Spacer(),
                          IconButton(
                              onPressed: () {
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
                        height: 30,
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
                      TextFeild(
                          labelText:'معاينة' ,
                          keyboardType: TextInputType.name,
                          hintText:'اضف معاينة ',
                          controller: inspectionController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال المعاينة ";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الوصفة الطبية' ,
                          keyboardType: TextInputType.name,
                          hintText:'اضف وصفة طبية ',
                          controller: phaController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال الوصفة الطبية ";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'ملاحظات' ,
                          keyboardType: TextInputType.name,
                          hintText:'اضف ملاحظة',
                          controller: noteController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال الملاحظة ";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ConditionalBuilder(
                          condition: state is! DoctorAddSatisDoctorLoading,
                          builder: (context) => Button(text: 'اضافة الكشف الطبي', function: ()async{
                            if(FormKey.currentState!.validate()){
                              cubit.addSatisfactoryRecorf(
                              satisfactoRyrecord_user_id: users.upcomingScheduleUserId.toString(), satisfactoRyrecord_doctor_id: users.upcomingScheduleDoctorId.toString(), satisfactoRyrecord_date: DateFormat('yyyy-MM-dd').format(DateTime.now()) , satisfactoRyrecord_inspection: inspectionController.text, satisfactoRyrecord_pharmaceutical: phaController.text, satisfactoRyrecord_notes: noteController.text, upcomingSchedule_id: users.upcomingScheduleId.toString(), satisfactoRyrecord_time: DateFormat("hh:mm a").format(DateTime.now()) , doctor_name: doctoRHome!.data!.doctor![0].doctorName!,doctor_image: cubit.doctorHome!.data!.doctor![0].doctorImageUrl.toString() , satisfactoRyrecord_status: "0");
                            }
                            // await NotificationService().showNotification(id: 1 , title: 'اضافة موعد'  , body: 'تم اضافة الموعد بنجاح');
                          }),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

