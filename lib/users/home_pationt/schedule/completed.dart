import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';

import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/home_pationt/schedule/details_screen.dart';

import '../../../models/userHome.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.sortSatisfac();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ConditionalBuilder(
                  condition: cubit.userHome!.data!.satisfactoryrecord!.isNotEmpty,
                  builder: (context) =>  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>CompletedBuilderIteme(cubit.userHome!.data!.satisfactoryrecord![index] , context) ,
                    separatorBuilder: (context, index) => Divider(
                      height: 50,
                    ),
                    itemCount: cubit.userHome!.data!.satisfactoryrecord!.length,
                  ),
                  fallback: (context) => Center(
                    child: Column(
                      children: [
                        Text(
                          "لا توجد نتائج !",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset("assets/lottie/empty.json"),
                      ],
                    ),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
Widget CompletedBuilderIteme(Satisfactoryrecord models , context)=>
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${models.doctorName}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                  '${models.doctorSpecialization} , ${models.doctorState}'
              ),
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${models.doctorImageUrl}'),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined , color: Colors.black54,),
                          Text(
                            '${models.satisfactoRyrecordDate}',
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined , color: Colors.black54,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${models.satisfactoRyrecordTime}',
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
                InkWell(
                  onTap: (){
                    NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: DetailsScreen(satisfactoRyrecord: models,)));
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: HexColor('#f4f6fa'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'تفاصيل',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );