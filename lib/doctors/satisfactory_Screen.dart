import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/satisfactoryRecord_screen.dart';
import 'package:myclinics/models/doctorHome.dart';

class SatisFactoryScreen extends StatelessWidget {
  const SatisFactoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit,DoctorsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => SatisFactoryBuilder(context ,cubit.doctorHome!.data!.satisfactoryrecord![index]  , cubit),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: cubit.doctorHome!.data!.satisfactoryrecord!.length
        );
      },
    );
  }
}

Widget SatisFactoryBuilder(context , Satisfactoryrecord models , DoctorsCubit cubit)=>
    Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
          ]),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
                title: Text(
                  'اسم المريض :-  ${models.userName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تاريخ الميلاد :- ${models.userAge}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('رقم الهاتف :- ${models.userPhoneNumber}'),
                        TextButton(onPressed: (){
                          cubit.callNumber(models.userPhoneNumber.toString());
                        }, child: Row(
                          children: [
                            Text('اتصل الأن'),
                            SizedBox(width: 5,),
                            Icon(Icons.phone),
                          ],
                        ))
                      ],
                    ),
                    Text(' البريد الألكتروني :- ${models.userEmail}')
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(text: "تفاصيل", function: (){
                    NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: satisfactoryRecord_screen(models)));
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),

          ],
        ),
      ),
    );
