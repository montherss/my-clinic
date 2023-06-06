import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/edit_doctor_profile.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/settings/edit_profile.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المعلومات الشخصية', style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                        ),
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
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('الأسم' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorName}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.badge_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('الشهادات' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorCertification}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.badge_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('التخصص' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorSpecialization}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.verified_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('الخبرات' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorExperience}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.health_and_safety_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('شركات التأمين' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorInsuranceCompanies}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(cubit.doctorHome!.data!.doctor![0].doctorGender==('ذكر') ? Icons.male_outlined : Icons.female_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('الجنس' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorGender}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.phone, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('رقم الهاتف' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorPhoneNumber}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('الموقع' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.symmetric(vertical: 10),
                                   child: Text('${cubit.doctorHome!.data!.doctor![0].doctorLocation}' , style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.w300
                                   ),),
                                 ),

                                 Padding(
                                   padding:  EdgeInsets.symmetric(vertical: 10),
                                   child: Text('${cubit.doctorHome!.data!.doctor![0].doctorMap}' , style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.w300
                                   ),),
                                 ),
                               ],
                             )
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.facebook, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('صفحة الفيسبوك' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorFaceBook}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.instagram, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('صفحة الأنستغرام' , textDirection: TextDirection.ltr,style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.doctorHome!.data!.doctor![0].doctorInstgram}' , style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                            onPressed: (){
                              NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child: EditeDoctorProfile()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'تعديل المعلومات الشخصية',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                                Icon(Icons.edit , color: Colors.white,),
                              ],
                            )
                        ),
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

