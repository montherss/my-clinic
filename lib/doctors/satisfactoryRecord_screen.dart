import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';

import 'package:myclinics/models/satisfactory_record.dart';

import 'package:myclinics/users/cubit/home_cubit.dart';

import '../constant/constant.dart';
import '../models/doctorHome.dart';

class satisfactoryRecord_screen extends StatelessWidget {
  final Satisfactoryrecord satisfactoryrecord;
  satisfactoryRecord_screen(this.satisfactoryrecord);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'السجل المرضي', style: TextStyle(
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if(satisfactoryrecord.satisfactoRyrecordStatus==1)
                      InteractiveViewer(
                        clipBehavior: Clip.none,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Hero(
                            tag: "${IMAGE_SATISFACTORY}/${satisfactoryrecord.satisfactoryrecordImage}",
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: NetworkImage("${IMAGE_SATISFACTORY}/${satisfactoryrecord.satisfactoryrecordImage}") ,)
                              ),
                            ),
                          ),
                        ),
                      ),
                    if(satisfactoryrecord.satisfactoRyrecordStatus!=1)
                      Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2
                            )
                          ]
                      ),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'المعاينة : ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    '${satisfactoryrecord.satisfactoRyrecordInspection}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(
                                      thickness: 1,
                                      height: 20,
                                    ),
                                  ),
                                  Text(
                                    'الأدوية الموصوفة : ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    '${satisfactoryrecord.satisfactoRyrecordPharmaceutical}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(
                                      thickness: 1,
                                      height: 20,
                                    ),
                                  ),
                                  Text(
                                    'الملاحظات : ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    '${satisfactoryrecord.satisfactoRyrecordNotes}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(
                                      thickness: 1,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined,
                                        color: Colors.black54,),
                                      SizedBox(width: 5,),
                                      Text(
                                        '${satisfactoryrecord.satisfactoRyrecordDate}',
                                        style: TextStyle(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_outlined,
                                            color: Colors.black54,),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${satisfactoryrecord.satisfactoRyrecordTime}',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
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

