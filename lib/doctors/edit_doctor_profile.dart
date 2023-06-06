import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../constant/constant.dart';

class EditeDoctorProfile extends StatelessWidget {
  const EditeDoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var NameController = TextEditingController();
    var CelrController = TextEditingController();
    var ExpController = TextEditingController();
    var IndesController = TextEditingController();
    var LocationController = TextEditingController();
    var OpenTimeController = TextEditingController();
    return BlocConsumer<DoctorsCubit,DoctorsState>(
      listener: (context, state) {
        if(state is DocrosUpdateProfileSuss){
          if(state.verification.status=="success"){
            showTost("تم التعديل بنجاح", Colors.green);
            DoctorsCubit.get(context).getDoctor(DOCTORID);
          }else{
            showTost("فشل", Colors.red);
          }
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        DateTime? mydate ;
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('تعديل المعلومات الشخصية' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
                          Spacer(),
                          IconButton(
                              onPressed: () {
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
                          labelText:'الأسم' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorName}',
                          controller: NameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الشهادات' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorCertification}',
                          controller: CelrController,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الخبرات' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorExperience}',
                          controller: ExpController,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'شركات التأمين' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorInsuranceCompanies}',
                          controller: IndesController,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الموقع' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorLocation}',
                          controller: LocationController,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'وقت فتح العيادة' ,
                          keyboardType: TextInputType.name,
                          hintText:'${cubit.doctorHome!.data!.doctor![0].doctorOpenTime}',
                          controller: OpenTimeController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Button(text: 'تعديل المعلومات الشخصية', function: (){
                        cubit.updateDoctorProfile(doctor_name:NameController.text.isEmpty ? cubit.doctorHome!.data!.doctor![0].doctorName !: NameController.text,
                             doctor_certification: CelrController.text.isEmpty?cubit.doctorHome!.data!.doctor![0].doctorCertification!:CelrController.text,
                             doctor_experience: ExpController.text.isEmpty?cubit.doctorHome!.data!.doctor![0].doctorExperience!:ExpController.text,
                            doctor_insuranceCompanies:IndesController.text.isEmpty?cubit.doctorHome!.data!.doctor![0].doctorInsuranceCompanies!:IndesController.text,
                            doctor_openTime: OpenTimeController.text.isEmpty?cubit.doctorHome!.data!.doctor![0].doctorOpenTime!:OpenTimeController.text,
                            doctor_location: LocationController.text.isEmpty?cubit.doctorHome!.data!.doctor![0].doctorLocation!:LocationController.text,
                            doctor_id: cubit.doctorHome!.data!.doctor![0].doctorId.toString());
                      }),
                      SizedBox(
                        height: 20,
                      ),
                          Text('ملاحظة:- للتعديل على معلومات اخرى الرجاء التواصل مع الدعم الفني ' , style: TextStyle( color: Colors.black54 , fontWeight: FontWeight.bold),)
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

