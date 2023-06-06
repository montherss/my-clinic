import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:myclinics/doctors/add_free_time.dart';
import 'package:myclinics/doctors/done_screen.dart';
import 'package:myclinics/doctors/home_screen_doctors.dart';
import 'package:myclinics/doctors/schedule_screen_doctors.dart';
import 'package:myclinics/doctors/settings_screen_doctors.dart';
import 'package:myclinics/doctors/table_time_screen.dart';
import 'package:myclinics/doctors/wating_screen.dart';
import 'package:myclinics/models/doctorHome.dart';
import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/models/doctors_chart.dart';
import 'package:myclinics/models/free_time.dart';
import 'package:myclinics/models/notification.dart';
import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/social_media.dart';
import 'package:myclinics/models/upcoming.dart';
import 'package:myclinics/models/user.dart';
import 'package:myclinics/models/users_to_doctors.dart';
import 'package:myclinics/models/verification..dart';
import 'package:myclinics/network/https_helper.dart';
import 'package:myclinics/notification_helper/notification_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/component.dart';
import '../../constant/constant.dart';
import '../final_result.dart';
import '../satisfactory_Screen.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial());

  static DoctorsCubit get(context) => BlocProvider.of(context);
  DateTime? freeTimeDate = DateTime.now();
  String freeTimeStart='';
  String freeTimeEnd='';
  int curentIndex = 0;
  DateTime currentDate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  DateTime? notifi ;
  String finshedTime = '';
  int selectedReminder = 5 ;
  Verification? verification ;
  List<FreeTime> freeTimeLastList = [];
  XFile? xfile ;
  File? myImage;
  String? token ;
  var refuserController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  void getDoctorToken()async{
    token = await FirebaseMessaging.instance.getToken();
  }
  void selectImageFromeGallary()async{
    xfile=null;
    myImage=null;
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    myImage = File(xfile!.path);
    emit(DoctorSelectImageGallary());
  }
  void clrearImage(){
    xfile =null ;
    myImage=null;
    print(xfile?.path.toString());
    emit(DoctorCleareImage());
  }
  void selectImageFromeCamera()async{
    xfile=null;
    myImage=null;
    xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    myImage = File(xfile!.path);
    emit(DoctorSelectImageCamera());
  }
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];
  DoctorHome? doctorHome;
  bool?checkConnection;
  void getDoctor(String id)async{
    try{
      await Crud.getDoctorFromHttp(linkUrl: DOCTOR_DATA, id: id).then((value){
        doctoRHome = DoctorHome.fromJson(value);
        print(doctoRHome!.data!.doctor![0].doctorName);
        emit(DoctorsGetHomeSuss());
      }).catchError((onError){
        emit(DoctorServerError(onError.toString()));
        print(onError.toString());
      });
    }catch(e){

    }
  }
  inteNetReselt()async{
    checkConnection = await CheckInterNetConnection() ;
    emit(DoctorsCheckInterNet());
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
  List<Satisfactoryrecord> searchUser = [];
  void searchUserPhone(String number){
    searchUser = doctorHome!.data!.satisfactoryrecord!.where((character) => character.userPhoneNumber!.startsWith(number)).toList();
    emit(DoctorSearchUser());
  }
  void selectedDateTime(DateTime time){
    currentDate = time ;
    emit(DoctorsSelectedDateTime());
  }
  void selectedDateTimeForUpdate(DateTime time){
    freeTimeDate = time ;
    print(freeTimeDate);
    print(DateFormat('EEEE').format(time));
    emit(DoctorsSelectedDateTimeUpdate());
  }
  void addFreeTimeDoctor({
    required String freeTime_date ,
    required String freeTime_title,
    required String freeTime_note,
    required String freeTime_statedTime,
    required String freeTime_day,
    required String freeTime_endTime,
    required String freeTime_doctor_id,
})async{
    await Crud.addFreeTimeDoctor(linkUrl: ADD_FREE_TIME_DOCTOR, freeTime_date: freeTime_date, freeTime_title: freeTime_title, freeTime_note: freeTime_note, freeTime_statedTime: freeTime_statedTime, freeTime_day: freeTime_day, freeTime_endTime: freeTime_endTime, freeTime_doctor_id: freeTime_doctor_id).then((value){
      emit(DoctorAddFreeTimeDoctorSuss());
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void selectedTime(TimeOfDay time , context){

    startTime = time.format(context);
    emit(DoctorsSelectedTime());
  }
  void selectedTimeUpdate(TimeOfDay time , context){

    freeTimeStart = time.format(context);
    print(freeTimeStart);
    emit(DoctorsSelectedTimeUpdate());
  }
  void selectedTimeFinshed(TimeOfDay time , context){
    finshedTime = time.format(context);
    emit(DoctorsSelectedTimeFinshed());
  }
  void selectedTimeFinshedUpdate(TimeOfDay time , context){
    freeTimeEnd = time.format(context);
    print(freeTimeEnd);
    emit(DoctorsSelectedTimeFinshedUpdate());
  }
  void dropDownListShange(String value){
    selectedReminder = int.parse(value);
    emit(DoctorsSelectedTimeReminder());
  }
  void ChangeNavBar(int index) {
    curentIndex = index;
    if(curentIndex == 0){
      getDoctor(DOCTORID);
    }else{
      getDoctor(DOCTORID);
    }
    emit(DoctorsChangeNavBar());
  }
  int Suss = 0 ;
  int Reject = 0;
  int wating  = 0 ;
  List <DoctorsChart> Chart =[];
  List<Widget> Screens = [
    HomeScreenDoctors(),
    ScheduleScreenDoctors(),
    FinalResult(),
    SettingsScreenDoctors(),
  ];

  final doctor = DoctorsS(
      name: 'الدكتور أحمد ',
      imageUrl:
          'https://img.freepik.com/free-photo/smiling-touching-arms-crossed-room-hospital_1134-799.jpg',
      rate: 5,
      Subscription: 1,
      gender: 'ذكر',
      specialization: 'الطب العام',
      state: 'معان',
      phoneNumber: '0788888823',
      certificate: 'طب عام من جامعة الأردنية تقدير امتياز',
      experience: 'طبيب مدة 10 سنين ',
      location: 'معان - طريق اذرح',
      openTime: 'كل يوم من الساعه التاسعة الى الساعة السادسة',
      insuranceCompanies: 'شركة الفجر , شركة الأمل , شركة GIG',
      freeTime: [
        DoctorFreeTime(date: '2012-02-27 13:27:00', title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-05-20 11:30:00',title: 'فحص عام', startedTime: '12:30 PM' , endTime: '1:30 PM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-06-20 12:30:00',title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-08-20 09:30:00',title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-09-20 09:30:00',title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-10-20 09:30:00',title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
        DoctorFreeTime(date: '2023-11-20 09:30:00',title: 'فحص عام', startedTime: '10:30 AM' , endTime: '11:30 AM'  ,note: 'كشفية' , remider: 10),
      ],
      facebook: 'https//facebook.com',
      instgram: 'https//instagram.com',
      map: 'https://goo.gl/maps/5MB4spsYk4zT9EG39',
      users:[
        Users(
          name: 'محمد',
          name2: 'علي',
          name3: 'المعايطة',
          id: '2',
          gender: 'ذكر',
          age: '40',
          phoneNumber: '0787722479',
          upcomingSchedule: UpcomingSchedule(
            doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
            ),
            pashName: 'محمد علي',
            statuse: 'تم الموافقة',
            date: '2023-04-20',
            startTime: '17:00',
            endTime : '17:30',
            houres: '1730',
          )
        ),
        Users(
            name: 'احمد',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '67',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              pashName: 'احمد علي',
              statuse: 'تم الموافقة',
              startTime: '18:00',
              endTime : '19:00',
              date: '2023-04-17',
              houres: '1830',
            )
        ),
        Users(
            name: 'خالد',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '45',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              pashName: 'خالد علي محمود علي',
              startTime: '12:00',
              endTime : '16:30',
              statuse: 'تم الموافقة',
              date: '2023-04-23',
              houres: '1030',
            )
        ),
        Users(
            name: 'خليل',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '55',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              statuse: 'تم الرفض',
              date: '10/5/2023',
              houres: '10:30',
              notest: 'سبب السفر'
            )
        ),
        Users(
            name: 'خليل',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '55',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              statuse: 'تم الرفض',
              notest: 'بسبب عدم التواجد في العيادة',
              date: '10/5/2023',
              houres: '10:30',
            )
        ),
        Users(
            name: 'خليل',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '55',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              statuse: 'تم الرفض',
              notest: 'بسبب عدم التفرغ',
              date: '10/5/2023',
              houres: '10:30',
            )
        ),
        Users(
            name: 'محمود',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '22/10/1988',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
              doctors: DoctorsS(
                name: 'الدكتور أحمد خليل خليل' ,
                specialization: 'الطب العام' ,
                state: 'معان',
              ),
              statuse: 'بانتظار الموافقة',
              date: '10/5/2023',
              houres: '10:30',
              pashName: 'محمود'
            )
        ),
        Users(
            name: 'محمود',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '22/10/1988',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
                doctors: DoctorsS(
                  name: 'الدكتور أحمد خليل خليل' ,
                  specialization: 'الطب العام' ,
                  state: 'معان',
                ),
                statuse: 'بانتظار الموافقة',
                date: '10/5/2023',
                houres: '10:30',
                pashName: 'محمود'
            )
        ),
        Users(
            name: 'محمود',
            name2: 'علي',
            name3: 'المعايطة',
            id: '2',
            gender: 'ذكر',
            age: '22/10/1988',
            phoneNumber: '0787722479',
            upcomingSchedule: UpcomingSchedule(
                doctors: DoctorsS(
                  name: 'الدكتور أحمد خليل خليل' ,
                  specialization: 'الطب العام' ,
                  state: 'معان',
                ),
                statuse: 'بانتظار الموافقة',
                date: '10/5/2023',
                houres: '10:30',
                pashName: 'محمود'
            )
        ),
      ],
  );

  List<Upcomingschedule> upComingFinal=[];
  List<UpcomingSchedule> upComing=[];
  void getDataAndCalendarShart(){
    Suss = 0 ;
    Reject = 0 ;
    wating = 0 ;
    upComingFinal=[];
    for(int i = 0 ; i <= doctorHome!.data!.upcomingschedule!.length-1;i++){
      if(doctorHome!.data!.upcomingschedule![i].upcomingScheduleStatuse =='تم الموافقة'){
        upComingFinal.add(doctorHome!.data!.upcomingschedule![i]);
        Suss = Suss +1;
      }else if(doctorHome!.data!.upcomingschedule![i].upcomingScheduleStatuse=='تم الرفض'){
        Reject = Reject+1;
      } else{
        wating = wating+1;
      }
    }
    Chart = [
      DoctorsChart(
        states: 'تم الموافقة' , number: Suss ,
      ),
      DoctorsChart(
        states: 'تم الرفض' , number: Reject ,
      ),
      DoctorsChart(
          states: 'بانتظار الموافقة' , number: wating),
    ];
    emit(DoctorsGetDataChart());
  }
  convToDate(String string){
    return DateTime.tryParse(string);
  }
  String convert12HourTo24Hour(String time) {
    final format = DateFormat.jm(); // create DateFormat object for 12-hour format
    final DateTime dateTime = format.parse(time); // parse the timestamp string into a DateTime object
    final format24 = DateFormat.Hm(); // create DateFormat object for 24-hour format
    return format24.format(dateTime); // format the DateTime object into a timestamp in 24-hour format
  }

  convToHours(String hours){
    String? myval = hours ;//10:30
    TimeOfDay releaseTime = TimeOfDay(hour:int.parse(hours.split(':')[0]),minute: int.parse(hours.split(':')[1]));
    return releaseTime ;
  }
  void upDateDoctorFreeTime({
    required String freeTime_date ,
    required String freeTime_title,
    required String freeTime_note,
    required String freeTime_statedTime,
    required String freeTime_day,
    required String freeTime_endTime,
    required String freeTime_doctor_id,
    required String freeTime_id,
  })async{
    await Crud.updateFreeTimeDoctor(linkUrl: UPDATE_FREETIME_DOCTOR, freeTime_date: freeTime_date, freeTime_title: freeTime_title, freeTime_note: freeTime_note, freeTime_statedTime: freeTime_statedTime, freeTime_day: freeTime_day, freeTime_endTime: freeTime_endTime, freeTime_doctor_id: freeTime_doctor_id, freeTime_id: freeTime_id)
        .then((value){
      emit(DocrosUpdateFreeTimeSuss());
    })
        .catchError((onError){

    });
  }

  void deleteFreeTimeDoctor({
    required String freeTime_doctor_id,
    required String freeTime_id,
})async{
    await Crud.deleteFreeTimeDoctor(linkUrl: DELETE_FREETIME_DOCTOR, freeTime_doctor_id: freeTime_doctor_id, freeTime_id: freeTime_id)
        .then((value){
          verification = Verification.fromJson(value);
          emit(DocrosDeleteFreeTimeSuss(verification!));
    })
        .catchError((onError){
          print(onError.toString());
    });
  }
  void updateDoctorProfile({
    required String doctor_name,

    required String doctor_certification,
    required String doctor_experience,
    required String doctor_insuranceCompanies,
    required String doctor_openTime,
    required String doctor_location,
    required String doctor_id,
})async{
    await Crud.updateDoctorProfile(linkUrl: UPDATE_DOCTOR_PROFILE, doctor_name: doctor_name, doctor_certification: doctor_certification, doctor_experience: doctor_experience, doctor_insuranceCompanies: doctor_insuranceCompanies, doctor_openTime: doctor_openTime, doctor_location: doctor_location, doctor_id: doctor_id)
        .then((value){
          verification = Verification.fromJson(value);
          emit(DocrosUpdateProfileSuss(verification!));
    })
        .catchError((onError){
          print(onError.toString());
    });
  }
  List<Appointment>meetings = [];
  void getSorceCalendar (){
    meetings = [] ;
    for(int i = 0 ; i<= upComingFinal.length -1; i++){
      DateTime time = convToDate(upComingFinal[i].upcomingScheduleDate!);
      TimeOfDay hoursAndMinStartedTime  = convToHours(convert12HourTo24Hour(upComingFinal[i].upcomingScheduleStartTime!));
      TimeOfDay hoursAndMinEndTime  = convToHours(convert12HourTo24Hour(upComingFinal[i].upcomingScheduleEndTime!));

      meetings.add(
        Appointment(
            startTime:DateTime(time.year , time.month , time.day , hoursAndMinStartedTime.hour , hoursAndMinStartedTime.minute ),
            endTime:DateTime(time.year , time.month , time.day , hoursAndMinEndTime.hour , hoursAndMinEndTime.minute ) , subject: '${upComingFinal[i].userName}' , color: Colors.deepPurple)
      );
    }
  }
  List<Widget> scheduleScreen=[
    WatingScreenDoctors(),
    DoneScreenDoctors(),
  ];
  List<Widget> finalResultScreen=[
    TableTimeScreen(),
    SatisFactoryScreen(),
  ];
  void cancelDoctor({
    required String user_id ,
    required String doctor_id,
    required String upcoming_id,
    required String doctor_name,
    required String freeTime_id,
    required String doctor_image,
    required String note,
    required String date,
    required String houre,
})async{
    emit(DoctorCancelDoctorLoading());
    await Crud.cancelDoctor(linkUrl: CANCEL_DOCTOR, user_id: user_id, doctor_id: doctor_id, upcoming_id: upcoming_id, note: note,doctor_name: doctor_name , date: date , houre: houre , freeTime_id: freeTime_id , doctor_image: doctor_image)
        .then((value){
          verification = Verification.fromJson(value);
      emit(DoctorCancelDoctorSuss(verification!));
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void addSatisfactoryImage({
    required String satisfactoRyrecord_user_id,
    required String satisfactoRyrecord_doctor_id,
    required String doctor_name,
    required String doctor_image,
    required String satisfactoRyrecord_date,
    required String upcomingSchedule_id,
    required String satisfactoRyrecord_time,
    required String satisfactoRyrecord_status ,
    required File file ,
  })async{
    emit(DoctorAddSatisFactoryRecordImageLoading());
    await Crud.addSatisfactoyRecordImage(
        data: {
      "satisfactoRyrecord_user_id":satisfactoRyrecord_user_id,
      "satisfactoRyrecord_doctor_id":satisfactoRyrecord_doctor_id,
      "doctor_name":doctor_name,
      "doctor_image":doctor_image,
      "satisfactoRyrecord_inspection":"",
          "satisfactoRyrecord_pharmaceutical":"",
          "satisfactoRyrecord_notes":"",
          "upcomingSchedule_id":upcomingSchedule_id,
      "satisfactoRyrecord_date":satisfactoRyrecord_date,
      "satisfupcomingSchedule_idactoRyrecord_date":upcomingSchedule_id,
      "satisfactoRyrecord_time":satisfactoRyrecord_time,
      "satisfactoRyrecord_status":satisfactoRyrecord_status,
    }, linkUrl: ADD_SatisfactoyRecord_IMAGE_Doctor ,file: file).then((value){
      verification = Verification.fromJson(value);
      emit(DoctorAddSatisFactoryRecordImageSuss(verification!));
    }).catchError((onError){
      print(onError.toString());
      showTost(onError.toString(), Colors.red);
    });
  }
  void addSatisfactoryRecorf({
    required String doctor_name,
    required String satisfactoRyrecord_user_id,
    required String satisfactoRyrecord_doctor_id,
    required String satisfactoRyrecord_date,
    required String satisfactoRyrecord_inspection,
    required String satisfactoRyrecord_pharmaceutical,
    required String satisfactoRyrecord_notes,
    required String upcomingSchedule_id,
    required String doctor_image,
    required String satisfactoRyrecord_time,
    required String satisfactoRyrecord_status,
})async{
    emit(DoctorAddSatisDoctorLoading());
    await Crud.addSatisfactoyRecord(linkUrl: ADD_SatisfactoyRecord_Doctor, satisfactoRyrecord_user_id: satisfactoRyrecord_user_id, satisfactoRyrecord_doctor_id: satisfactoRyrecord_doctor_id, satisfactoRyrecord_date: satisfactoRyrecord_date, satisfactoRyrecord_inspection: satisfactoRyrecord_inspection, satisfactoRyrecord_pharmaceutical: satisfactoRyrecord_pharmaceutical, satisfactoRyrecord_notes: satisfactoRyrecord_notes, upcomingSchedule_id: upcomingSchedule_id, satisfactoRyrecord_time: satisfactoRyrecord_time , doctor_name: doctor_name , doctor_image: doctor_image , satisfactoRyrecord_status: satisfactoRyrecord_status)
        .then((value){
          verification = Verification.fromJson(value);
          emit(DoctorAddSatisDoctorSuss(verification!));
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void approveDoctor({
    required String user_id ,
    required String doctor_id,
    required String upcoming_id,
    required String freeTime_id,
    required String doctor_name,
    required String date,
    required String doctor_image,
    required String houre,
})async{
    emit(DoctorApproveDoctorLoading());
    await Crud.approveDoctor(linkUrl: APROVE_DOCTOR, user_id: user_id, doctor_id: doctor_id, upcoming_id: upcoming_id , freeTime_id: freeTime_id ,doctor_name: doctor_name , date: date , houre: houre , doctor_image: doctor_image)
        .then((value){
          verification = Verification.fromJson(value);
      emit(DoctorApproveDoctorSuss(verification!));
    }).catchError((onError){
      print("Approve Error");
      showTost(onError.toString(), Colors.red);
    });
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
    emit(DoctorCallPationt());
  }
  int schedule = 0 ;
  void ChangeScheduleScreen (int index){
    schedule = index;
    emit(DoctorsChangeSchedule());
  }
  List<Upcomingschedule> userWhoWating = [];
  List<Upcomingschedule> userWhoAcceptOrReject = [] ;

  void getUserWhoWating (){
    userWhoWating = [] ;
    userWhoAcceptOrReject = [] ;
    for(int i = 0 ; i<=doctorHome!.data!.upcomingschedule!.length-1 ; i++){
      if (doctorHome!.data!.upcomingschedule![i].upcomingScheduleStatuse=='بانتظار الموافقة'){
        userWhoWating.add(doctorHome!.data!.upcomingschedule![i]);
      }else {
        userWhoAcceptOrReject.add(doctorHome!.data!.upcomingschedule![i]);
      }
    }


    userWhoWating.sort((a,b) =>DateTime.parse(b.upcomingScheduleDate!).compareTo(DateTime.parse(a.upcomingScheduleDate!)));
    userWhoAcceptOrReject.sort((a,b) =>DateTime.parse(b.upcomingScheduleDate!).compareTo(DateTime.parse(a.upcomingScheduleDate!)));
  }
  getSatisfactoryRecord(int userId){
    for(int i = 0 ;i<= doctorHome!.data!.satisfactoryrecord!.length-1; i ++){
      if(doctorHome!.data!.satisfactoryrecord![i].satisfactoRyrecordUserId==userId){
        return doctorHome!.data!.satisfactoryrecord![i];
      }
    }
  }
  void sortFreeTime(){
    freeTimeLastList.sort((a,b) =>DateTime.parse(b.freeTimeDate!).compareTo(DateTime.parse(a.freeTimeDate!)));

  }
  void filterFreeTime(){
    freeTimeLastList.removeWhere( (item) => item.freeTimeAvailable == 2 || item.freeTimeAvailable == 3);
  }

  void getFreeTime(){
    freeTimeLastList = [] ;
    for(int i = 0 ; i <= doctorHome!.data!.freeTime!.length-1; i++){
      if(DateTime.now().compareTo(DateTime.tryParse( doctorHome!.data!.freeTime![i].freeTimeDate!)!)<0){
        freeTimeLastList.add(doctorHome!.data!.freeTime![i]);
      }

    }
  }
  void upDateDoctorToken({
    required String doctor_id,
    required String token ,
  })async{
    await Crud.updateDoctorToken(linkUrl: UPDATE_DOCTOR_TOKEN, doctor_id: doctor_id, token: token).then((value){
      verification = Verification.fromJson(value);
    }).catchError((onError){
      print(onError.toString());
    });
  }
}
