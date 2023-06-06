import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/main_screen_doctors.dart';
import 'package:myclinics/firebase_options.dart';
import 'package:myclinics/local/shared_pref/cach_helper.dart';
import 'package:myclinics/models/doctorHome.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/network/https_helper.dart';
import 'package:myclinics/notification_helper/notification_helper.dart';
import 'package:myclinics/presentation/login_screen.dart';
import 'package:myclinics/presentation/presentation_screen.dart';
import 'package:myclinics/presentation/signup_complet.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/cubit/login_signup_cubit.dart';
import 'package:myclinics/users/cubit/obsBloc.dart';
import 'package:myclinics/users/cubit/obsBloc.dart';
import 'package:myclinics/users/home_pationt/main_pationt.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'component/component.dart';
import 'fcm.dart';
import 'models/notification_user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHepler.init();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestPermissionNotification();
  NotificationService().initNotification();
  USERID = CacheHepler.getData(key: "id");
  DOCTORID = CacheHepler.getData(key: "DoctorID");
  Widget firstScreen;
  if(USERID!=null){
    firstScreen = MainPationtScreen();
    await Crud.getUserNotification(linkUrl: GET_USER_NOTIFICATION, user_id: USERID.toString()).then((value){
      notificatioNUser = NotificationUser.fromJson(value);
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
    });
     await Crud.getUerFromHttp(linkUrl: USERHOME, id: USERID.toString()).then((value){
       useRHome = UserHome.fromJson(value);
     }).catchError((onError){
       showTost(onError.toString(), Colors.red);
     });
  }else if(DOCTORID != null) {
    firstScreen = MainScreenDoctors();
    await Crud.getDoctorFromHttp(linkUrl: DOCTOR_DATA, id:DOCTORID.toString() ).then((value){
      doctoRHome = DoctorHome.fromJson(value);
    }).catchError((onError){
      print(onError.toString());
    });
  } else {
    firstScreen = PresentationScreen();
  }
  fcmConfig(Doctorid: DOCTORID , Userid:USERID);
  requestPermissionNotification();
  tz.initializeTimeZones();
  await CacheHepler.init();
  runApp( MyApp(firstScreen));
}

class MyApp extends StatelessWidget {
  final Widget firstScreen ;
  MyApp(this.firstScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getNews()),
        BlocProvider(create: (context)=>  LoginSignupCubit()),
        BlocProvider(create: (context) => DoctorsCubit()..inteNetReselt()),
      ],
      child:
      MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                elevation: 0 ,
                backgroundColor: Colors.grey[50],
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness:Brightness.dark,
                  statusBarColor: Colors.grey[50],
                )
            ),
            fontFamily: 'jannah',
            primarySwatch: Colors.deepPurple,
          ),
          home:  Directionality(
              textDirection: TextDirection.rtl,
              child: AnimatedSplashScreen(
                splashIconSize: 300,
                backgroundColor: Colors.white,
                  splash: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image/logoFinal.png"))
                    )
                    ,), nextScreen: Directionality(textDirection: TextDirection.rtl, child: firstScreen))
          )
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}