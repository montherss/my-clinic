import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

class SatisFactoryRecordScreen extends StatelessWidget {
  const SatisFactoryRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(10),
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
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SatisfactoryBuilder(cubit.userHome!.data!.satisfactoryrecord![index] , context),
                        separatorBuilder: (context, index) => Divider(
                          height: 50,
                        ),
                        itemCount: cubit.userHome!.data!.satisfactoryrecord!.length
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
Widget SatisfactoryBuilder(Satisfactoryrecord models , context)=>
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
                '${models.doctorName}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                  '${models.doctorSpecialization}  ,  ${models.doctorState}'
              ),
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${models.doctorImageUrl}'),
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
                    '${models.satisfactoRyrecordInspection}',
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
                    '${models.satisfactoRyrecordPharmaceutical}',
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
                    '${models.satisfactoRyrecordNotes}',
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
                        '${models.satisfactoRyrecordDate}',
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
                            '${models.satisfactoRyrecordTime}',
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
                InkWell(
                  onTap: () {
                    HomeCubit.get(context).pdfFileDetiles(models);
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
                        'طباعة ملف PDF',
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

