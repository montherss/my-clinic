import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/constant/constant.dart';

import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/models/free_time.dart';
import 'package:myclinics/models/notification.dart';
import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/upcoming.dart';
import 'package:myclinics/models/user.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/network/https_helper.dart';
import 'package:myclinics/users/home_pationt/favorite_screen.dart';

import 'package:myclinics/users/home_pationt/home_pationt.dart';
import 'package:myclinics/users/home_pationt/schedule/completed.dart';
import 'package:myclinics/users/home_pationt/schedule/upcoming.dart';
import 'package:myclinics/users/home_pationt/schedule_pationt.dart';
import 'package:myclinics/users/home_pationt/setting_pationt.dart';
import 'package:myclinics/users/pdf_helper/pdf_helper.dart';
import 'package:myclinics/users/pdf_helper/pdf_opener.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/news.dart';
import '../../models/notification_user.dart';
import '../../models/verification..dart';
import '../news_screen.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);
  String input1 = '2012-02-27 13:27:00';
  int currentIndex = 0 ;
  int group = 0;
  int schedule = 0;
  bool notification = false ;
  String? mydate ;
  int stateSelected = 20 ;
  double? degreess = 0 ;
  double angle  = 0;
  bool?checkConnection;
  DateTime currentDate = DateTime.now();
  UserHome? userHome ;
  String gender = '';
  int root = 0 ;
  Verification? verification;
  String? token;
  int selectedRadio = 0;
  String childName = '';
  //String Age =  useRHome!.data!.user![0].userAge!;
  List<Doctor> doctorNewList=[];
  List<Doctor> searchDoctors=[];
  List<Doctor> favorites = [] ;

  void selectedState(int index){
    stateSelected = index ;
  }
  void getDegreesImage (double degrees){
    degreess = degrees ;
    angle = degrees * pi / 180 ;
    emit(HomeRotImage());
  }
  void ChangeRadio(int i ){
    group = i ;
    if(i == 1){
      gender = 'ذكر';
    }else{
      gender = 'انثى';
    }
    emit(HomeChangeRadio());
  }
  getCurrentDay(){
    return DateFormat.yMMMMd().format(currentDate);
  }
  getDayString(DateTime day){
    return DateFormat("yyyy-MM-dd").format(day);
  }
  List<Freetime> sortedFreeTime = [] ;
  void sortedFreeTimeScedule(Doctor doctor , String date){
    sortedFreeTime = [] ;
    for(int i = 0 ; i<= doctor.freetime!.length-1 ; i++){
      if(doctor.freetime![i].freeTimeDate == date){
        sortedFreeTime.add(doctor.freetime![i]);
      }
    }
   // sortedFreeTime.sort((a,b)=>b.freeTimeStatedTime!.compareTo(a.freeTimeStatedTime!));
    emit(HomeSortDoctorFreeTimeSc());
  }
  void removeChildren({
    required String children_id ,
})async{
    emit(HomeRemoveChildrenLoading());
    await Crud.removeChildren(linkUrl: REMOVE_CHILDREN, children_id: children_id).then((value){
      verification = Verification.fromJson(value);
      emit(HomeRemoveChildrenSuss(verification!));
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
    });
  }
  void addChildren({
    required String user_id ,
    required String chiled_name ,
    required String age ,
    required String gender ,
})async{
    emit(HomeAddChildrenLoading());
    await Crud.addChildren(linkUrl: ADD_CHILDREN, user_id: user_id, chiled_name: chiled_name, age: age, gender: gender).then((value){
      verification = Verification.fromJson(value);
      emit(HomeAddChildrenSuss(verification!));
    }).catchError((onError){
       showTost(onError.toString(), Colors.red);
    });
  }
  void getFav(){
    favorites = [] ;
    for(int i = 0 ; i <= doctorNewList.length-1 ; i++ ){
      if(doctorNewList[i].favourtie==1){
        favorites.add(doctorNewList[i]);
      }
    }

  }
  void getUserToken()async{
    token = await FirebaseMessaging.instance.getToken();
  }
  void searchDoctor(String later){
    searchDoctors = doctorNewList.where((character) => character.doctorName!.startsWith(later)).toList();
    emit(HomeSearchDoctor());
  }
  void getUser(String id)async{
      try{
        await Crud.getUerFromHttp(linkUrl: USERHOME, id: id).then((value){
          useRHome = UserHome.fromJson(value);
          emit(HomeGetUserSussecc());
        }).catchError((onError){
          print(onError.toString());
        });
      }catch(e){
        print(e.toString());
      }
  }
  void addFav({
    required String user_id ,
    required String doctor_id ,
})async{
    emit(HomeAddFavLoading());
    await Crud.addFav(linkUrl: ADDFAV, user_id: user_id, doctor_id: doctor_id)
        .then((value){
      verification = Verification.fromJson(value);
      emit(HomeAddFavSuss(verification!));
    }).catchError((onError){});
}
  void deleteFav({
    required String user_id ,
    required String doctor_id ,
  })async{
    emit(HomeDeleteFavLoading());
    await Crud.deleteFav(linkUrl: DELETEFAV, user_id: user_id, doctor_id: doctor_id)
        .then((value){
          verification = Verification.fromJson(value);
          emit(HomeDeleteFavSuss(verification! , doctor_id));
    }).catchError((onError){});
  }
  void upDateUserData({
    required String user_id ,
    required String name ,
    required String name2 ,
    required String name3 ,
    required String  email,
    required String phoneNumber ,
    required String age ,
})async{
    emit(HomeUpdateUserLoading());
    await Crud.upDateUserData(linkUrl: UPDATE_USER, user_id: user_id, name: name, name2: name2, name3: name3, email: email, phoneNumber: phoneNumber, age: age)
        .then((value){
          print(value);
          emit(HomeUpdateUserSuss());
    })
        .catchError((onError){
          print(onError.toString());
          emit(HomeUpdateUserError());
        });
  }
  void cancelUpComing({required String user_id ,required String freeTimeId })async{
    await Crud.cancelUpComing(linkUrl: CANCEL_UPCOMING, user_id: user_id, freeTimeId: freeTimeId).then((value){
      print(value);
      emit(HomeCancelUpcomingSuss());
    }).catchError((onError){
      print(onError.toString());
    });
}
  inteNetReselt()async{
    checkConnection = await CheckInterNetConnection() ;
    emit(HomeCheckInterNet());
  }
  CheckInterNetConnection()async{
    try{
      var res = await InternetAddress.lookup("google.com");
      if(res.isNotEmpty && res[0].rawAddress.isNotEmpty){
        return true ;
      }
    }catch(e){
      return false ;
    }
  }
  News? news ;
  void getNews()async{
    await Crud.getNews(linkUrl: NewsApi).then((value) {
      news = News.fromJson(value);
      print(news?.articles?[0].title);
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void getAllDoctors(){
    doctorNewList = [] ;
    for(int i = 0 ; i<=useRHome!.data!.doctor!.length-1 ; i++){
        doctorNewList.add(useRHome!.data!.doctor![i]);
      }
    root = 1 ;
  }
  void selectedDateTime(DateTime time){
    currentDate = time;
    emit(HomeSelectedDateTime());
  }
  void showDate(DateTime date){
    mydate = DateFormat('dd/MM/yyyy').format(date);
    emit(HomeGetDate());
  }
  void changeNotification(noti){
    notification = noti ;
    emit(HomeChangeNotification());
  }
  void changeIndex (int index){
    currentIndex = index ;
    if(currentIndex==0){
      getUser(USERID);
      stateSelected = 20;
    }
    if(currentIndex==1){
      getUser(USERID);
      stateSelected = 20;
    }else if(currentIndex==2){
      getUser(USERID);
      stateSelected = 20;
    }
    emit(HomeChangeIndex());
  }
  List<Widget> screen = [
    HomePationtScreen(),
    SchedulePationtScreen(),
    FavoriteScreen(),
    NewsScreen(),
    SettingsScreen(),
  ];
  List<DoctorsS> doctorsList =[
    DoctorsS(
        name: 'الدكتور أحمد خليل خليل' ,
        imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg' ,
        rate: 5 ,
        Subscription: 1,
        specialization: 'الطب العام' ,
        state: 'معان' ,
        phoneNumber: '0788888823',
        certificate: 'طب عام من جامعة الأردنية تقدير امتياز',
        experience: 'طبيب مدة 10 سنين ',
        location: 'معان - طريق اذرح',
        openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
        insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
        facebook: 'https//facebook.com',
        instgram: 'https//instagram.com',
        map: 'https://goo.gl/maps/5MB4spsYk4zT9EG39',
        freeTime:[
          DoctorFreeTime(date: '2012-02-27 13:27:00' , day: 'الثلاثاء'),
          DoctorFreeTime(date: '2023-05-20 11:30:00' , day: 'الأربعاء'),
          DoctorFreeTime(date: '2023-06-20 12:30:00', day: 'الخميس'),
          DoctorFreeTime(date: '2023-07-20 09:30:00', day: 'الجمعة'),
          DoctorFreeTime(date: '2023-07-20 09:30:00', day: 'السبت'),
          DoctorFreeTime(date: '2023-07-20 09:30:00', day: 'الأحد'),
          DoctorFreeTime(date: '2023-07-20 09:30:00', day: 'الاثنين'),
        ] ,

    ),
    DoctorsS(
        name: 'الدكتور خالد' ,
        imageUrl: 'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=1200:*' ,
        rate: 4 ,
        Subscription: 1,
        specialization: 'طب الأطفال' ,
        state: 'الكرك',
        phoneNumber: '0788118823',
        certificate: 'طب اطفال من جامعة الأردنية تقدير امتياز',
        experience: 'طبيب مدة 10 سنين ',
        location: 'الكرك - طريق اذرح',
        openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
        insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
        freeTime:[],
        facebook: 'https//facebook.com',
        instgram: 'https//instagram.com',
        map: 'https://goo.gl/maps/o275LFDH9Yjyh87K7',
    ),
    DoctorsS(name: 'الدكتورة خديجة' , imageUrl: 'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip' , rate: 3 , specialization: 'الطب العام' , state: 'معان', phoneNumber: '0788856823' ,
      certificate: 'طب عام من جامعة الأردنية تقدير امتياز',
      experience: 'طبيب مدة 10 سنين ',
      Subscription: 2,
      location: 'معان - طريق اذرح',
      openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
      insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
      freeTime:[],
        facebook: 'https//facebook.com',
        instgram: 'https//instagram.com',
        map: 'https://goo.gl/maps/RL2mJaisoycL7FY29',

    ),
    DoctorsS(
      name: 'الدكتور خليل' ,
      imageUrl: 'https://www.eatthis.com/wp-content/uploads/sites/4/2020/12/serious-doctor-hospital.jpg?quality=82&strip=1' , rate: 5 , specialization: 'جراحة القلب' , state: 'الطفيلة', phoneNumber: '0788888853',
      certificate: 'طب قلب من جامعة الأردنية تقدير امتياز',
      experience: 'طبيب مدة 10 سنين ',
      Subscription: 2,
      location: 'الطفيلة - طريق اذرح',
      openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
      insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
      freeTime:[],
        facebook: 'https//facebook.com',
        instgram: 'https//instagram.com',
        map: 'https://goo.gl/maps/86pQXHyJC32u7mbs9',
    ),
    DoctorsS(
      name: 'الدكتور ماريا الصرايرة' ,
      imageUrl: 'https://1.bp.blogspot.com/-XTle2yqm1FI/YASXfgt18ZI/AAAAAAAAI-A/Jl3QVb4UW3Iby_ySCivTsMLL8TIun-w_wCLcBGAsYHQ/s1024/2.jpg' ,
      rate: 5 , specialization: 'طب الأسنان' , state: 'الكرك', phoneNumber: '101',certificate: 'طب اسنان من جامعة الأردنية تقدير امتياز',
      experience: 'طبيب مدة 10 سنين ',
      Subscription: 3,
      location: 'الكرك -  اذرح',
      openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
      insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
      freeTime: [],
        facebook: 'https//facebook.com',
        instgram: 'https//instagram.com',
        map: 'https://goo.gl/maps/qApfX1UygYWD41FJ9',
    ),
  ];
  final user = User(
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU',
    name: 'محمد',
    name2: 'خالد',
    name3: 'المعايطة',
    age: '28/8/1980',
    gender: 'ذكر',
    id: '2',
    phoneNumber: '0787722479',
    satisfactoryrecord: [
      SatisfactoRyrecord(
        id: '1',
        date: '12/9/2022',
        houer: '11:30 AM',
        doctors: DoctorsS(
          name: 'الدكتور أحمد خليل خليل' ,
          imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg' ,
          rate: 5 , specialization: 'الطب العام' ,
          state: 'معان' ,
          phoneNumber: '0788888823',
        ),
        inspection: 'يعاني من التهاب في الأمعاء الدقيقة ',
        pharmaceutical: 'اليرفين' ,
        notes: 'يراجع بعد انتهاء الأدوية',
      ),
      SatisfactoRyrecord(
        id: '1',
        date: '12/9/2022',
        houer: '11:30 AM',
        doctors: DoctorsS(
            name: 'الدكتور أحمد خليل خليل' ,
            imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg' ,
            rate: 5 , specialization: 'الطب العام' ,
            state: 'معان' ,
            phoneNumber: '0788888823',
        ),
        inspection: 'يعاني من التهاب في الأمعاء الدقيقة ',
        pharmaceutical: 'اليرفين' ,
        notes: 'يراجع بعد انتهاء الأدوية',
      ),
      SatisfactoRyrecord(
        id: '1',
        date: '12/12/2022',
        houer: '1:30 PM',
        doctors: DoctorsS(
            name: 'الدكتور ماريا الصرايرة' ,
            imageUrl: 'https://1.bp.blogspot.com/-XTle2yqm1FI/YASXfgt18ZI/AAAAAAAAI-A/Jl3QVb4UW3Iby_ySCivTsMLL8TIun-w_wCLcBGAsYHQ/s1024/2.jpg' ,
            rate: 5 ,
            specialization: 'طب الأسنان' ,
            state: 'الكرك',
            phoneNumber: '101'
        ),
        inspection: 'خلع طاحونة العقل اليمنى السفلية',
        pharmaceutical: 'اليرفين' ,
        notes: ' يراجع بعد انتهاء الأدوية و اختفاء الألتهاب',
      ),
    ],
    upcomingSchedule: [
      UpcomingSchedule(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        date: '12/10/2000',
        houres: '10:30 AM',
        statuse: 'تم الموافقة',
      ),
      UpcomingSchedule(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        date: '12/10/2011',
        houres: '10:30 AM',
        statuse: 'تم الموافقة',
      ),
      UpcomingSchedule(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        date: '12/10/2022',
        houres: '10:30 AM',
        statuse: 'بانتظار الموافقة',
      ),
      UpcomingSchedule(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        date: '12/10/2033',
        houres: '10:30 AM',
        statuse: 'تم الرفض',
        notest: ' بسسب عدم التواجد في العيادة بسسب عدم التواجد في العيادة بسسب عدم التواجد في العيادةبسسب عدم التواجد في العيادة',
      ),
    ],
    notifications: [
      Notifications(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        title: 'تم ارسال طلبك بنجاح',
        time: DateTime(2023 , 05 , 12 , 8 , 30),
        upcomingSchedule:  UpcomingSchedule(
            doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
            date: '12/10/2022',
            houres: '10:30 AM',
            statuse: 'بانتظار الموافقة',
          ),
      ),
      Notifications(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        title: 'تم ارسال طلبك بنجاح',
        time: DateTime(2023 , 06 , 12 , 12 , 30),
        upcomingSchedule:  UpcomingSchedule(
          doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
          date: '12/10/2022',
          houres: '10:30 AM',
          statuse: 'بانتظار الموافقة',
        ),
      ),
      Notifications(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        title: 'تم رفض طلبك',
        time: DateTime(2023 , 05 , 12 , 8 , 30),
        upcomingSchedule:  UpcomingSchedule(
          doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
          date: '12/10/2022',
          houres: '10:30 AM',
          statuse: 'تم الرفض',
          notest: 'بسبب عدم الوجود في العيادة'
        ),
      ),
      Notifications(
        doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
        title: 'تم قبول طلبك',
        time: DateTime(2023 , 05 , 12 , 8 , 30),
        upcomingSchedule:  UpcomingSchedule(
          doctors: DoctorsS(name: 'الدكتور أحمد خليل خليل' , specialization: 'الطب العام' , state: 'معان', imageUrl: 'https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg'),
          date: '12/10/2022',
          houres: '10:30 AM',
          statuse: 'تم الموافقة',
        ),
      )
    ]
  );

  List State = [
    'الكرك',
    'معان',
    'الطفيلة',
    'عمان',
    'الزرقاء',
    'اربد',
    'جرش',
    'العقبة',
  ];
  String? value ;
  String states ='';
  String specialization = 'اختر التخصص';
  List<Doctor> sortedDoctorLit =[];


  List<Doctor> sortedDoctorListSpecilization=[];
  List<String> specializations= [
  'الطب العام',
  'طب الأطفال',
  'طب الأسنان',
  'جراحة القلب',
  'الطب النفسي',
  'الطب النووي',
  'أمراض الكلى',
  'أمراض الغدد',
  'جراحة الدماغ',
  'الطب البصري',
  'أمراض النخاع',
  'مرض السكري',
  'أمراض العضلات',
  'الأمراض الجلدية',
  'الجراحات التجميلية',
  'طب النسائية والتوليد',
  'طب الأمراض التنفسية',
  'الأمراض العقلية والنفسية',
  'السرطان والأورام المختلفة',
  'أمراض الأذن والأنف والحنجرة',
  'طب العظام والمفاصل والغضاريف',
  ];

  void SubscriptionDoctorNewList(){
    doctorNewList.sort((a, b) => a.doctorSubScription!.compareTo(b.doctorSubScription!));
    emit(HomeSubscripthionDoctorsNew());
  }
  void sortStateDoctorLists (String state){
    sortedDoctorLit =[];
    states = state ;
    for(int i = 0 ; i<= userHome!.data!.doctor!.length-1 ; i++){
      if(userHome!.data!.doctor![i].doctorState==state){
        sortedDoctorLit.add(userHome!.data!.doctor![i]);
      }
    }
    emit(HomeSortDoctor());
  }
  void sortSpecializationDoctorLists (String specialization){
    sortedDoctorListSpecilization = [];
    for(int i = 0 ; i<= sortedDoctorLit.length-1 ; i++){
      if(sortedDoctorLit[i].doctorSpecialization==specialization){
        sortedDoctorListSpecilization.add(sortedDoctorLit[i]);
      }
    }
    emit(HomeSortDoctorSpecialization());
  }
  void Drop_Down_item(String value2){
    value = value2 ;
    emit(HomeDropDown());
  }

  void callNumber (String number)async{
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if(await canLaunchUrl(launchUri)){
      await launchUrl(launchUri);
    }
    else{
      print('error');
    }
    emit(HomeCallDoctor());
  }
  void UrlLancher (String url)async{
    final Uri launchUri = Uri.parse(url);
    if(await canLaunchUrl(launchUri)){
      await launchUrl(launchUri,mode: LaunchMode.externalApplication,);
    }
    else{
      print('error');
    }

  }
  List<Widget> scheduleScreen=[
    UpcomingScreen(),
    CompletedScreen(),
  ];
  void ChangeScheduleScreen (int index){
    schedule = index;
    emit(HomeChangeSchedule());
  }
  void pdfFileDetiles(Satisfactoryrecord satisfactoRyrecord)async{

    await PdfDetails.generate(satisfactoRyrecord).then((value){
      PdfOpener.openFile(value);
      emit(HomeOpenPdf());
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void subMitUserScedule({
    required String user_id ,
    required String user_name ,
    required String doctor_id ,
    required String startTime ,
    required String date ,
    required String endTime ,
    required String freeTimeId ,
})async{
    emit(HomeSubMitUserLoading());
    await Crud.subMitUserScedule(linkUrl:SUBMITUSERSCEDULE, user_id: user_id, doctor_id: doctor_id, startTime: startTime, date: date, endTime: endTime , freeTimeId: freeTimeId , user_name: user_name)
        .then((value){
          verification = Verification.fromJson(value);
          emit(HomeSubMitUserSuss(verification!));
    }).catchError((onError){
      print(onError.toString());
      emit(HomeSubMitUserError());
    });
  }

  void getUserNotification({
    required String user_id ,
  })async{
    print("Hi all");
    await Crud.getUserNotification(linkUrl: GET_USER_NOTIFICATION, user_id: user_id).then((value){
      notificatioNUser = NotificationUser.fromJson(value);
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
    });
  }
  void subMitUserChildrenScedule({
    required String user_id ,
    required String user_name ,
    required String doctor_id ,
    required String startTime ,
    required String date ,
    required String endTime ,
    required String freeTimeId ,
    required String chiled_name ,
    required String chiled_age ,
  })async{
    emit(HomeSubMitUserLoading());
    await Crud.subMitUserChildrenScedule(linkUrl:SUBMITUSERSCEDULE_CHILDREN, user_id: user_id, doctor_id: doctor_id, startTime: startTime, date: date, endTime: endTime , freeTimeId: freeTimeId , user_name: user_name , chiled_age: chiled_age , chiled_name: chiled_name)
        .then((value){
          verification = Verification.fromJson(value);
      emit(HomeSubMitUserCheldrenSuss(verification!));
    }).catchError((onError){
      showTost(onError.toString(), Colors.red);
    });
  }
  void filterUpcoming(){

    for(int i = 0 ; i<=userHome!.data!.upcomingschedule!.length-1 ; i++){
      if(userHome!.data!.upcomingschedule![i].upcomingschedule_user_satis == 1){
        userHome!.data!.upcomingschedule!.remove(userHome!.data!.upcomingschedule![i]);
      }
    }

  }
  List<Notificationss> sortedNotifi=[];
  void sortNotification(){
    sortedNotifi=[];
    for(int i = 0 ; i<=notificatioNUser!.notification!.length-1 ; i++){
      sortedNotifi.add(notificatioNUser!.notification![i]);
    }
    sortedNotifi.sort((a,b) =>DateTime.parse(b.notificationTime!).compareTo(DateTime.parse(a.notificationTime!)));
  }
  void sortSatisfac(){
    userHome!.data!.satisfactoryrecord!.sort((a,b) =>DateTime.parse(b.satisfactoRyrecordDate!).compareTo(DateTime.parse(a.satisfactoRyrecordDate!)));
  }
  void upDateUserToken({
    required String user_id,
    required String token ,
  })async{

    await Crud.updateUserToken(linkUrl: UPDATE_USER_TOKEN, user_id: user_id, token: token).then((value){
      verification = Verification.fromJson(value);
    }).catchError((onError){
      print(onError.toString());
    });
  }
}

