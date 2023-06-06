import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/settings/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
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
                                child: Text('${cubit.userHome!.data!.user![0].userName} ${cubit.userHome!.data!.user![0].userName2} ${cubit.userHome!.data!.user![0].userName3}' , style: TextStyle(
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
                                  Icon(Icons.calendar_month_outlined, size: 30,color: Colors.black54,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('تاريخ الميلاد' , style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600 ,
                                      color: Colors.black54
                                  ),),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: Text('${cubit.userHome!.data!.user![0].userAge}' , style: TextStyle(
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
                                  Icon(cubit.userHome!.data!.user![0].userGender==('ذكر') ? Icons.male_outlined : Icons.female_outlined, size: 30,color: Colors.black54,),
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
                                child: Text('${cubit.userHome!.data!.user![0].userGender}' , style: TextStyle(
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
                                child: Text('${cubit.userHome!.data!.user![0].userPhoneNumber}' , style: TextStyle(
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
                            NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child: EditeProfile()));
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

