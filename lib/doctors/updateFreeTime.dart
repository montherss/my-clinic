import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/models/doctorHome.dart';
import 'package:myclinics/notification_helper/notification_helper.dart';

import '../constant/constant.dart';

class UpdateFreeTime extends StatelessWidget {
  final FreeTime freeTime;
  UpdateFreeTime(this.freeTime);
  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var  titleController  = TextEditingController();
    var  noteController  = TextEditingController();
    var endTimeController = TextEditingController();

    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
        if(state is DocrosUpdateFreeTimeSuss){
          showTost("تم تعديل الموعد بنجاح", Colors.green);
          Navigator.pop(context);
          Navigator.pop(context);
          DoctorsCubit.get(context).getDoctor(DOCTORID);
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
       // cubit.freeTimeDate =  DateTime.parse(freeTime.freeTimeDate!);
       // cubit.freeTimeStart = freeTime.freeTimeStatedTime!;
        //cubit.freeTimeEnd = freeTime.freeTimeEndTime!;
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
                          Text('تعديل المواعيد' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
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
                      TextFeild(
                          labelText:'العنوان' ,
                          keyboardType: TextInputType.name,
                          hintText:'${freeTime.freeTimeTitle}',
                          controller: titleController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال العنوان ";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الملاحظات' ,
                          keyboardType: TextInputType.name,
                          hintText:'${freeTime.freeTimeNote}',
                          controller: noteController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال الملاحظات ";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DoctorFormFiled(
                          title: 'التاريخ' ,
                          hint: DateFormat('yyyy-MM-dd').format(cubit.freeTimeDate!),
                          validator: (value){
                            if(value == DateFormat('yyyy-MM-dd').format(DateTime.now())){
                              showTost("الرجاء اختيار التاريخ ", Colors.red);
                            }
                          },
                          widget: IconButton(
                              onPressed: ()async{
                                cubit.selectedDateTimeForUpdate(await getDateFromDoctorsUser(context));
                              },
                              icon: Icon(Icons.calendar_month_outlined , color: Colors.grey,)
                          )
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: DoctorFormFiled(
                                  title: 'وقت البدأ',
                                  hint: cubit.freeTimeStart,
                                  validator: (value){
                                    if(cubit.freeTimeStart==null||cubit.freeTimeStart.isEmpty){
                                      showTost("الرجاء ادخال وقت البدأ", Colors.red);
                                    }
                                  },
                                  widget:  IconButton(
                                      onPressed: ()async{
                                        cubit.selectedTimeUpdate(await getTimeFromUser(context), context);
                                      },
                                      icon: Icon(Icons.access_time , color: Colors.grey,)
                                  )
                              )
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: DoctorFormFiled(
                                  title: 'وقت الأنتهاء',
                                  hint: "${cubit.freeTimeEnd}",
                                  controller: endTimeController,
                                  validator: (value){
                                    if(cubit.freeTimeEnd==null||cubit.freeTimeEnd.isEmpty){
                                      showTost("الرجاء ادخال وقت الأنتهاء", Colors.red);
                                    }
                                  },
                                  widget:  IconButton(
                                      onPressed: ()async{
                                        cubit.selectedTimeFinshedUpdate(await getTimeFromUser(context), context);
                                      },
                                      icon: Icon(Icons.access_time , color: Colors.grey,)
                                  )
                              )
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /* DoctorFormFiled(
                          title: 'المنبه',
                          hint: "${cubit.selectedReminder}  دقيقة قبل الموعد "  ,
                          widget: DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down ,color: Colors.grey,),
                              iconSize: 32,
                              elevation: 4,
                              underline: Container(height: 0,),
                              style: TextStyle(
                                fontSize: 16 ,
                                fontWeight: FontWeight.w400 ,
                                color: Colors.grey[600],
                              ),
                              items: cubit.remindList.map<DropdownMenuItem<String>>((int value){
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(value.toString()),
                                );
                              }).toList() ,
                              onChanged: (newvalue){
                              cubit.dropDownListShange(newvalue!);
                              },
                          )
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      Button(text: 'اضافة الموعد', function: ()async{
                        if(FormKey.currentState!.validate()){
                          cubit.upDateDoctorFreeTime(freeTime_date: DateFormat('yyyy-MM-dd').format(cubit.freeTimeDate!), freeTime_title: titleController.text, freeTime_note: noteController.text, freeTime_statedTime: cubit.freeTimeStart, freeTime_day: DateFormat('EEEE').format(cubit.freeTimeDate!), freeTime_endTime: cubit.freeTimeEnd, freeTime_doctor_id: freeTime.freeTimeDoctorId.toString(), freeTime_id: freeTime.freeTimeId.toString());
                        }
                        // await NotificationService().showNotification(id: 1 , title: 'اضافة موعد'  , body: 'تم اضافة الموعد بنجاح');
                      }),
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

