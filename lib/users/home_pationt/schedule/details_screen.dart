import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myclinics/component/component.dart';

import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constant/constant.dart';
import '../../pdf_helper/pdf_gen.dart';

class DetailsScreen extends StatelessWidget {
 final Satisfactoryrecord  satisfactoRyrecord;
 DetailsScreen({ required this.satisfactoRyrecord});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
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
                              cubit.angle = 0 ;
                              cubit.degreess = 0 ;
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
                    if(satisfactoRyrecord.satisfactoRyrecordStatus==1)
                      Column(
                        children: [
                          Transform.rotate(
                            angle: HomeCubit.get(context).angle,
                            child: InteractiveViewer(
                              clipBehavior: Clip.none,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Hero(
                                  tag: "${IMAGE_SATISFACTORY}/${satisfactoRyrecord.satisfactoryrecordImage}",
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(image: NetworkImage("${IMAGE_SATISFACTORY}/${satisfactoRyrecord.satisfactoryrecordImage}") ,)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(onPressed: (){
                                cubit.getDegreesImage(cubit.degreess! + 90);
                              }, icon: Icon(Icons.rotate_right , size: 30,)),

                              IconButton(onPressed: (){
                                cubit.getDegreesImage(cubit.degreess! - 90);
                              }, icon: Icon(Icons.rotate_left , size: 30))
                            ],
                          )
                        ],
                      ),
                    if(satisfactoRyrecord.satisfactoRyrecordStatus!=1)
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
                            ListTile(
                              title: Text(
                                '${satisfactoRyrecord.doctorName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Text(
                                  '${satisfactoRyrecord.doctorSpecialization}  ,  ${satisfactoRyrecord.doctorState}'
                              ),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${satisfactoRyrecord.doctorImageUrl}'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                height: 20,
                              ),
                            ),
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
                                    '${satisfactoRyrecord.satisfactoRyrecordInspection}',
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
                                    '${satisfactoRyrecord.satisfactoRyrecordPharmaceutical}',
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
                                    '${satisfactoRyrecord.satisfactoRyrecordNotes}',
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
                                        '${satisfactoRyrecord.satisfactoRyrecordDate}',
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
                                            '${satisfactoRyrecord.satisfactoRyrecordTime}',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: HexColor('#f4f6fa'),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: MaterialButton(
                                      onPressed: ()async{
                                        PermissionStatus storeg = await Permission.manageExternalStorage.request();
                                        if(storeg == PermissionStatus.granted){
                                          HomeCubit.get(context).pdfFileDetiles(satisfactoRyrecord);
                                        }else {
                                          showTost("يجب الموافقة على الأذونات للحصول على الخدمة ! ", Colors.red);
                                        }
                                      },
                                      child: Text(
                                        'طباعة ملف PDF',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
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

