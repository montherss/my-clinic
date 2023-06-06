import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/upcoming.dart';

class Users{
  String ? name;
  String ? name2;
  String ? name3;
  String ? age ;
  String ? gender;
  String ? id ;
  String ? phoneNumber;
  UpcomingSchedule ? upcomingSchedule;
  SatisfactoRyrecord ? satisfactoRyrecord ;
  Users({this.name,this.name2,this.name3,this.age,this.gender,this.id,this.phoneNumber,this.satisfactoRyrecord,this.upcomingSchedule});
}