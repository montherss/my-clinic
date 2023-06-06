import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myclinics/ServerError.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/network/https_helper.dart';

import '../../component/component.dart';
import '../../connectionError.dart';
import '../cubit/home_cubit.dart';

class MainPationtScreen extends StatelessWidget {


  @override

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
        if (state is HomeSubMitUserLoading) {
        } else if (state is HomeSubMitUserSuss) {
          if(state.verification.status=="success"){
            showTost("تم اضافة طلبك بنجاح , سيتم الرد على طلبك من قبل الطبيب",
                Colors.green);
            HomeCubit.get(context).getUser(USERID);
          }
        } else if (state is HomeSubMitUserError) {
          showTost("حدث خطأ , الرجاء المحاولة فيما بعد", Colors.red);
        }else if (state is HomeSubMitUserCheldrenSuss){
          if(state.verification.status=="success"){
            showTost("تم اضافة طلبك بنجاح , سيتم الرد على طلبك من قبل الطبيب",
                Colors.green);
            HomeCubit.get(context).getUser(USERID);
          }else {
            showTost("حدث خطأ , الرجاء المحاولة فيما بعد", Colors.red);
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.userHome = useRHome;
        cubit.getUserNotification(user_id: cubit.userHome!.data!.user![0].userId.toString() );
        FirebaseMessaging.instance.subscribeToTopic("users${useRHome?.data?.user?[0].userId}");
        cubit.getUserToken();
        cubit.upDateUserToken(user_id: cubit.userHome!.data!.user![0].userId.toString(), token: cubit.token.toString());
        return ConditionalBuilder(
            condition: cubit.userHome != null,
            builder: (context) => StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  return Scaffold(
                    body:snapshot.data==ConnectivityResult.none?ConncectionError():cubit.screen[cubit.currentIndex],
                    bottomNavigationBar: BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(IconlyBroken.home) , label: 'الرئيسية'),
                        BottomNavigationBarItem(icon: Icon(IconlyBroken.calendar) , label: 'المواعيد'),
                        BottomNavigationBarItem(icon: Icon(IconlyBroken.heart) , label: 'المفضل'),
                        BottomNavigationBarItem(icon: Icon(IconlyBroken.paper) , label: 'اخبار'),
                        BottomNavigationBarItem(icon: Icon(IconlyBroken.setting) , label: 'الضبط'),
                      ],
                      elevation: 0,
                      onTap: (value) {
                        cubit.changeIndex(value);
                      },
                      currentIndex:cubit.currentIndex,
                      type: BottomNavigationBarType.fixed,
                    ),
                  );
                }
            ),
            fallback: (context) => ServerError(),
        );
      },
    );
  }
}

