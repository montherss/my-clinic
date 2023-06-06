part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeChangeIndex extends HomeState{}
class HomeSortDoctor extends HomeState{}
class HomeSortDoctorSpecialization extends HomeState{}
class HomeDropDown extends HomeState{}
class HomeGridView extends HomeState{}
class HomeCallDoctor extends HomeState{}
class HomeChangeSchedule extends HomeState{}
class HomeChangeNotification extends HomeState{}
class HomeOpenPdf extends HomeState{}
class HomeChangeRadio extends HomeState{}
class HomeChangeRadioChildren extends HomeState{}
class HomeChangeCaleMonth extends HomeState{}
class HomeSelectedDayCalendar extends HomeState{}
class HomeGetFreeTimeDoctors extends HomeState{}
class HomeGetDate extends HomeState{}
class GetFavLoading extends HomeState{}
class GetFavSuss extends HomeState{}
class HomeAddFavLoading extends HomeState{}
class HomeDeleteFavLoading extends HomeState{}
class HomeGetFavSuss extends HomeState{}
class HomeAddFavSuss extends HomeState{
  final Verification verification ;
  HomeAddFavSuss(this.verification);
}
class HomeDeleteFavSuss extends HomeState{
  final Verification verification ;
  final String doctIndex;
  HomeDeleteFavSuss(this.verification ,this.doctIndex);
}
class HomeSelectedDateTime extends HomeState{}
class HomeFilterUpcomingLoading extends HomeState{}
class HomeFilterUpcomingSuss extends HomeState{}
class HomeSubscripthionDoctorsNew extends HomeState{}
class HomeGetUserNotificationSuss extends HomeState{
 final NotificationUser notificationUser;
 HomeGetUserNotificationSuss(this.notificationUser);
}
class HomeCheckInterNet extends HomeState{}
class HomeGetUserNotificationLoading extends HomeState{}
class HomeGetUserNotificationError extends HomeState{}
class HomeGetUserSussecc extends HomeState{}
class HomeGetUserError extends HomeState{}
class HomeGetUserLoading extends HomeState{}

class HomeSubMitUserCheldrenSuss extends HomeState{
  final Verification verification ;
  HomeSubMitUserCheldrenSuss(this.verification);
}
class HomeSubMitUserCheldrenLoading extends HomeState{}
class HomeSubMitUserLoading extends HomeState{}
class HomeSubMitUserSuss extends HomeState{
  final Verification verification ;
  HomeSubMitUserSuss(this.verification);
}
class HomeSubMitUserError extends HomeState{}
class HomeSelectedState extends HomeState{}
class HomeSortAlldoctors extends HomeState{}

class ChangeState extends HomeState{}
class HomeRotImage extends HomeState{}
class HomeSortDoctorFreeTimeSc extends HomeState{}
class HomeUpdateUserSuss extends HomeState{
}
class HomeUpdateUserLoading extends HomeState{}
class HomeUpdateUserError extends HomeState{}
class HomeSearchDoctor extends HomeState{}

class HomeCancelUpcomingSuss extends HomeState{}

class HomeAddChildrenSuss extends HomeState{
  final Verification verification ;
  HomeAddChildrenSuss(this.verification);
}
class HomeAddChildrenLoading extends HomeState{
}

class HomeRemoveChildrenSuss extends HomeState{
  final Verification verification ;
  HomeRemoveChildrenSuss(this.verification);
}
class HomeRemoveChildrenLoading extends HomeState{
}