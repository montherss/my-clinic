import 'package:myclinics/models/doctors.dart';

class UpcomingSchedule{
  DoctorsS? doctors ;
  String ? date ;
  String ? pashName;
  String ? houres ;
  String ? statuse;
  String ? notest ;
  String ? startTime;
  String ? endTime ;
  UpcomingSchedule({this.doctors,this.date,this.houres,this.statuse , this.notest , this.pashName , this.endTime , this.startTime});
}