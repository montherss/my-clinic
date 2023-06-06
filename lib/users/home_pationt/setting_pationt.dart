import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/local/shared_pref/cach_helper.dart';
import 'package:myclinics/presentation/presentation_screen.dart';
import 'package:myclinics/users/settings/all_Children.dart';
import 'package:myclinics/users/settings/profile.dart';
import 'package:myclinics/users/settings/satisfactory_record_screen.dart';


import '../../constant/constant.dart';
import '../cubit/home_cubit.dart';
import '../settings/add_Children.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الضبط' , style:  TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
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
                      backgroundImage: NetworkImage(cubit.user.imageUrl!),
                    ),
                    title: Text(
                      '${cubit.userHome!.data!.user![0].userName}',
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
                      NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: ProfileScreen()));
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
                    onTap: (){
                      HomeCubit.get(context).getUser(USERID);
                      NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: AllChildren()));
                    },
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.family_restroom, color: Colors.purple,size: 30,),
                    ),
                    title: Text(
                      'عائلتي',
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
                    onTap: (){
                      NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child: SatisFactoryRecordScreen()));
                    },
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.health_and_safety_outlined, color: Colors.green,size: 30,),
                    ),
                    title: Text(
                      'السجل المرضي',
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
                          title: Text('تسجيل الخروج'),
                          actions: [
                            TextButton(onPressed: (){
                              FirebaseMessaging.instance.unsubscribeFromTopic("users");
                              FirebaseMessaging.instance.unsubscribeFromTopic("users${useRHome!.data!.user![0].userId}");
                              CacheHepler.removeData(key: "id");
                              cubit.currentIndex=0;
                              NavegatAndFinish(context, Directionality(textDirection: TextDirection.rtl, child: PresentationScreen()));
                            }, child: Text('تأكيد')),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('عودة')),
                          ],
                          content: Text('هل انت متأكد في تسجيل الخروج ؟')
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
        );
      },
    );
  }
}

