import 'package:myclinics/models/free_time.dart';
import 'package:myclinics/models/social_media.dart';
import 'package:myclinics/models/user.dart';
import 'package:myclinics/models/users_to_doctors.dart';

class DoctorsS {
  String? name ;
  String? imageUrl;
  int? rate ;
  int? Subscription ;
  String ? gender;
  String ? facebook ;
  String? instgram ;
  String ? map ;
  String? state ;
  String? specialization;
  String? phoneNumber;
  String? certificate ;
  String? experience;
  String? insuranceCompanies ;
  String ? location ;
  String ? openTime;
  List<DoctorFreeTime>?freeTime;
  List<Users> ? users ;
  DoctorsS({this.name,this.imageUrl,this.state,this.rate,this.facebook , this.instgram,this.map,this.specialization , this.phoneNumber ,this.gender, this.location, this.certificate,this.experience,this.freeTime,this.insuranceCompanies,this.openTime, this.Subscription ,this.users });
}