import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myclinics/component/component.dart';

import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/home_pationt/doctor_scedule.dart';

import '../../models/userHome.dart';

class DoctorInfo extends StatelessWidget {
  final Doctor doctors;

  DoctorInfo(this.doctors);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
            backgroundColor: HexColor('#8a00e6'),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(""),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Hero(
                                  tag: '${doctors.doctorImageUrl}',
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                      ),
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            NetworkImage('${doctors.doctorImageUrl}'),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${doctors.doctorName}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${doctors.doctorSpecialization}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if(doctors.doctorFaceBook!.isNotEmpty)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: HexColor('#b84dff'),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: (){
                                            cubit.UrlLancher('${doctors.doctorFaceBook}');
                                          },
                                          icon: Icon(FontAwesomeIcons.facebook , color: Colors.white,),
                                        )
                                    ),
                                    if(doctors.doctorInstgram!.isNotEmpty)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: HexColor('#b84dff'),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: (){
                                            cubit.UrlLancher('${doctors.doctorInstgram}');
                                          },
                                          icon: Icon(FontAwesomeIcons.instagram, color: Colors.white,),
                                        )
                                    ),
                                    if(doctors.doctorMap!.isNotEmpty)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: HexColor('#b84dff'),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: (){
                                            cubit.UrlLancher('${doctors.doctorMap}');
                                          },
                                          icon: Icon(FontAwesomeIcons.mapLocation , color: Colors.white,),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: BorderDirectional(
                                            top:
                                                BorderSide(color: Colors.white),
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            end:
                                                BorderSide(color: Colors.white),
                                            start:
                                                BorderSide(color: Colors.white),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: HexColor('#b84dff'),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            NavegatTo(
                                               context,
                                                Directionality(
                                                    textDirection:
                                                       TextDirection.rtl,
                                                    child: DoctorScheduleScreen(doctors: doctors , doctorsID: doctors.doctorId.toString())));
                                            cubit.sortedFreeTimeScedule(doctors, cubit.getDayString(DateTime.now()));
                                          },
                                          child: Text(
                                            'احجز موعد الأن',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )),
                                    Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: BorderDirectional(
                                            top:
                                                BorderSide(color: Colors.white),
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            end:
                                                BorderSide(color: Colors.white),
                                            start:
                                                BorderSide(color: Colors.white),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: HexColor('#b84dff'),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            cubit.callNumber(
                                                doctors.doctorPhoneNumber.toString());
                                          },
                                          child: Text(
                                            'اتصل الأن',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )),

                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 20, left: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
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
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.badge_outlined,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'الشهادات',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${doctors.doctorCertification}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.verified_outlined,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'الخبرات',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${doctors.doctorExperience}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.health_and_safety_outlined,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'شركات التأمين',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${doctors.doctorInsuranceCompanies}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'الموقع',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${doctors.doctorLocation}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
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
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_outlined,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'أوقات الدوام',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${doctors.doctorOpenTime}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
