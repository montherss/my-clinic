
 import 'dart:convert';

import 'package:myclinics/models/doctorHome.dart';
import 'package:myclinics/models/notification_user.dart';
import 'package:myclinics/models/userHome.dart';

 UserHome? useRHome;
 DoctorHome? doctoRHome;
 NotificationUser? notificatioNUser;
 var USERID ;
 var DOCTORID;
 String NewsApi = "https://newsapi.org/v2/top-headlines?language=ar&category=health&apiKey=c5549744f3ea42fd8e2cd488bf16f122";
 String SERVER = "http://192.168.1.206/nyClinicApp";
 String TEST = "$SERVER/test.php";
 String IMAGE_BANNER = "$SERVER/upload";
 String IMAGE_SATISFACTORY = "$SERVER/satisFactoryImage";
 String UPDATE_USER_TOKEN = "$SERVER/updateUserToken.php";
 String UPDATE_DOCTOR_TOKEN = "$SERVER/updateDoctorToken.php";
 String _basicAuth = 'Basic ' +
     base64Encode(utf8.encode("Almontherss41@:Almontherss41@!"));
 Map<String,String>myheaders = {
  'authorization':_basicAuth
 };
 //===============================AUTH==============================//
 String AUTH = "$SERVER/auth";
 String SIGNUP = "$AUTH/signup.php";
 String VERIFICATION = "$AUTH/verification.php";
 String LOGIN_USER = "$AUTH/login.php";
 String LOGIN_DOCTORS = "$AUTH/loginDoctors.php";
 //=============================HOME===============================//
 String USERHOME = "$SERVER/userhome.php";
 String SUBMITUSERSCEDULE = "$SERVER/submitSca.php";
 String DELETEFAV = "$SERVER/changeFavourtie.php";
 String ADDFAV = "$SERVER/addFavourtie.php";
 String ADD_CHILDREN = "$SERVER/addChildren.php";
 String REMOVE_CHILDREN = "$SERVER/removeChildren.php";
 String SUBMITUSERSCEDULE_CHILDREN = "$SERVER/submitScaChildren.php";
 String GET_USER_NOTIFICATION = "$SERVER/getNotificationUser.php";
 //=============================UPDATE-USER===============================//
 String UPDATE_USER = "$SERVER/updateUser.php";
 //=============================DELETE-UPCOMING===============================//
 String CANCEL_UPCOMING = "$SERVER/cancelUpcoming.php";
 //=============================DOCTOR-DATA===============================//
 String DOCTOR_DATA = "$SERVER/doctorhome.php";
 //=============================APPROVE-DOCTOR===============================//
 String APROVE_DOCTOR = "$SERVER/approvalDoctor.php";
 //=============================CANCEL-DOCTOR===============================//
 String CANCEL_DOCTOR = "$SERVER/cancelDoctor.php";
 //=============================ADD-FREE-TIME-DOCTOR===============================//
 String ADD_FREE_TIME_DOCTOR = "$SERVER/addNewFreeTime.php";
 String UPDATE_FREETIME_DOCTOR="$SERVER/updateFreeTime.php";
 String DELETE_FREETIME_DOCTOR = "$SERVER/deleteFreeTime.php";
 String UPDATE_DOCTOR_PROFILE = "$SERVER/updateDoctor.php";
 String ADD_SatisfactoyRecord_Doctor = "$SERVER/addSatisfactory.php";
 String ADD_SatisfactoyRecord_IMAGE_Doctor = "$SERVER/addSatisfactoryImage.php";