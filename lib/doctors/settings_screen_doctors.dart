import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/doctor_profile.dart';
import 'package:myclinics/local/shared_pref/cach_helper.dart';

import '../presentation/presentation_screen.dart';

class SettingsScreenDoctors extends StatelessWidget {
  const SettingsScreenDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الضبط' , style:  TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(cubit.doctor.imageUrl!),
                      ),
                      title: Text(
                        '${cubit.doctorHome!.data!.doctor![0].doctorName}',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                          'الصفحة الشخصية'
                      ),
                    ),
                    Divider(
                      height: 50,
                    ),
                    ListTile(
                      onTap: (){
                        NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: DoctorProfile()));
                      },
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(CupertinoIcons.person , color: Colors.blue,size: 30,),
                      ),
                      title: Text(
                        'المعلومات الشخصية',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: (){},
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.info_outline, color: Colors.orange,size: 30,),
                      ),
                      title: Text(
                        'حول التطبيق',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      height: 40,
                    ),
                    ListTile(
                      onTap: (){
                        ShowDialog(
                            context: context,
                            title: Text("تسجيل الخروج"),
                            actions: [
                              TextButton(onPressed: (){
                                FirebaseMessaging.instance.unsubscribeFromTopic("doctor");
                                FirebaseMessaging.instance.unsubscribeFromTopic("doctor${doctoRHome!.data!.doctor![0].doctorId}");
                                CacheHepler.removeData(key: "DoctorID");
                                cubit.curentIndex=0;
                                NavegatAndFinish(context, Directionality(textDirection: TextDirection.rtl, child: PresentationScreen()));
                              }, child: Text('تأكيد')),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('عودة')),
                            ],
                            content: Text("هل انت متأكد من تسجيل الخروج ؟")
                        );
                      },
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.logout_outlined, color: Colors.cyan,size: 30,),
                      ),
                      title: Text(
                        'تسجيل خروج',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
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

