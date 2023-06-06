import 'package:myclinics/models/notification.dart';
import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/upcoming.dart';

class User{
  String? name;
  String? name2;
  String? name3;
  String? imageUrl;
  String? age ;
  String ? gender;
  String? id ;
  String? phoneNumber;
  List<SatisfactoRyrecord>? satisfactoryrecord;
  List<UpcomingSchedule>? upcomingSchedule ;
  List<Notifications>? notifications;
  User({this.name,this.imageUrl ,this.id,this.age,this.gender , this.satisfactoryrecord , this.name2,this.name3 , this.phoneNumber , this.upcomingSchedule , this.notifications});
}