import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/models/upcoming.dart';

class Notifications{
  DateTime? time ;
  String? title ;
  DoctorsS? doctors ;
  String? note ;
  UpcomingSchedule? upcomingSchedule ;
  Notifications({this.doctors,this.note,this.time,this.title,this.upcomingSchedule});
}