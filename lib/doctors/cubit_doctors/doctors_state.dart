part of 'doctors_cubit.dart';

@immutable
abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState {}
class DoctorsChangeNavBar extends DoctorsState {}
class DoctorsGetDataChart extends DoctorsState {}
class DoctorsChangeSchedule extends DoctorsState{}
class DoctorsSelectedDateTime extends DoctorsState{}
class DocrosUpdateFreeTimeSuss extends DoctorsState{}

class DocrosDeleteFreeTimeSuss extends DoctorsState{
  final Verification verification;
  DocrosDeleteFreeTimeSuss(this.verification);
}
class DocrosUpdateProfileSuss extends DoctorsState{
  final Verification verification;
  DocrosUpdateProfileSuss(this.verification);
}
class DoctorsSelectedTime extends DoctorsState{}
class DoctorsSelectedTimeFinshed extends DoctorsState{}
class DoctorsSelectedDateTimeUpdate extends DoctorsState{}
class DoctorsSelectedTimeUpdate extends DoctorsState{}
class DoctorsSelectedTimeFinshedUpdate extends DoctorsState{}
class DoctorsSelectedTimeReminder extends DoctorsState{}
class DoctorsShowNotification extends DoctorsState{}
class DoctorsCheckInterNet extends DoctorsState{}
class DoctorSearchUser extends DoctorsState{}
class DoctorServerError extends DoctorsState{
  final String error ;
  DoctorServerError(this.error);
}
class DoctorsGetHomeSuss extends DoctorsState{}
class DoctorCallPationt extends DoctorsState{}
class DoctorApproveDoctorSuss extends DoctorsState{
  final Verification verification;
  DoctorApproveDoctorSuss(this.verification);
}
class DoctorApproveDoctorLoading extends DoctorsState{}
class DoctorCancelDoctorSuss extends DoctorsState{
  final Verification verification;
  DoctorCancelDoctorSuss(this.verification);
}
class DoctorCancelDoctorLoading extends DoctorsState{}
class DoctorAddFreeTimeDoctorSuss extends DoctorsState{}
class DoctorAddSatisDoctorSuss extends DoctorsState{
  final Verification verification;
  DoctorAddSatisDoctorSuss(this.verification);
}
class DoctorAddSatisDoctorLoading extends DoctorsState{}
class DoctorSelectImageGallary extends DoctorsState{}
class DoctorSelectImageCamera extends DoctorsState{}
class DoctorCleareImage extends DoctorsState{}
class DoctorAddSatisFactoryRecordImageSuss extends DoctorsState{
  final Verification verification;
  DoctorAddSatisFactoryRecordImageSuss(this.verification);
}
class DoctorAddSatisFactoryRecordImageLoading extends DoctorsState{
}