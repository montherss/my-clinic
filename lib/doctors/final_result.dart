import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit_doctors/doctors_cubit.dart';

class FinalResult extends StatelessWidget {
  const FinalResult({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الجدول' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: HexColor('#f4f6fa'),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              cubit.ChangeScheduleScreen(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                              decoration: BoxDecoration(
                                  color: cubit.schedule==0 ? HexColor('#8a00e6'):HexColor('#f4f6fa'),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                'حالة المواعيد',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: cubit.schedule==0 ? Colors.white : Colors.black54
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              cubit.ChangeScheduleScreen(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                              decoration: BoxDecoration(
                                  color: cubit.schedule==1 ? HexColor('#8a00e6'):HexColor('#f4f6fa'),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                'الكشف الطبي',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: cubit.schedule==1? Colors.white : Colors.black54
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    cubit.finalResultScreen[cubit.schedule],
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
