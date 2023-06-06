class DoctorHome {
  String? status;
  Data? data;

  DoctorHome({this.status, this.data});

  DoctorHome.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Doctor>? doctor;
  List<FreeTime>? freeTime;
  List<Satisfactoryrecord>? satisfactoryrecord;
  List<Reservation>? reservation;
  List<Upcomingschedule>? upcomingschedule;

  Data(
      {this.doctor,
        this.freeTime,
        this.satisfactoryrecord,
        this.reservation,
        this.upcomingschedule});

  Data.fromJson(Map<dynamic, dynamic> json) {
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
    if (json['freeTime'] != null) {
      freeTime = <FreeTime>[];
      json['freeTime'].forEach((v) {
        freeTime!.add(new FreeTime.fromJson(v));
      });
    }
    if (json['satisfactoryrecord'] != null) {
      satisfactoryrecord = <Satisfactoryrecord>[];
      json['satisfactoryrecord'].forEach((v) {
        satisfactoryrecord!.add(new Satisfactoryrecord.fromJson(v));
      });
    }
    if (json['reservation'] != null) {
      reservation = <Reservation>[];
      json['reservation'].forEach((v) {
        reservation!.add(new Reservation.fromJson(v));
      });
    }
    if (json['upcomingschedule'] != null) {
      upcomingschedule = <Upcomingschedule>[];
      json['upcomingschedule'].forEach((v) {
        upcomingschedule!.add(new Upcomingschedule.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
    }
    if (this.freeTime != null) {
      data['freeTime'] = this.freeTime!.map((v) => v.toJson()).toList();
    }
    if (this.satisfactoryrecord != null) {
      data['satisfactoryrecord'] =
          this.satisfactoryrecord!.map((v) => v.toJson()).toList();
    }
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingschedule != null) {
      data['upcomingschedule'] =
          this.upcomingschedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  int? doctorId;
  String? doctorName;
  String? doctorImageUrl;
  int? doctorRate;
  int? doctorSubScription;
  String? doctorGender;
  String? doctorFaceBook;
  String? doctorInstgram;
  String? doctorMap;
  String? doctorState;
  String? doctorSpecialization;
  String? doctorPhoneNumber;
  String? doctorCertification;
  String? doctorExperience;
  String? doctorInsuranceCompanies;
  String? doctorLocation;
  String? doctorOpenTime;
  String? doctorToken;
  String? doctorPassword;

  Doctor(
      {this.doctorId,
        this.doctorName,
        this.doctorImageUrl,
        this.doctorRate,
        this.doctorSubScription,
        this.doctorGender,
        this.doctorFaceBook,
        this.doctorInstgram,
        this.doctorMap,
        this.doctorState,
        this.doctorSpecialization,
        this.doctorPhoneNumber,
        this.doctorCertification,
        this.doctorExperience,
        this.doctorInsuranceCompanies,
        this.doctorLocation,
        this.doctorOpenTime,
        this.doctorToken,
        this.doctorPassword});

  Doctor.fromJson(Map<dynamic, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    doctorImageUrl = json['doctor_imageUrl'];
    doctorRate = json['doctor_rate'];
    doctorSubScription = json['doctor_subScription'];
    doctorGender = json['doctor_gender'];
    doctorFaceBook = json['doctor_faceBook'];
    doctorInstgram = json['doctor_instgram'];
    doctorMap = json['doctor_map'];
    doctorState = json['doctor_state'];
    doctorSpecialization = json['doctor_specialization'];
    doctorPhoneNumber = json['doctor_phoneNumber'];
    doctorCertification = json['doctor_certification'];
    doctorExperience = json['doctor_experience'];
    doctorInsuranceCompanies = json['doctor_insuranceCompanies'];
    doctorLocation = json['doctor_location'];
    doctorOpenTime = json['doctor_openTime'];
    doctorToken = json['doctor_token'];
    doctorPassword = json['doctor_password'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['doctor_imageUrl'] = this.doctorImageUrl;
    data['doctor_rate'] = this.doctorRate;
    data['doctor_subScription'] = this.doctorSubScription;
    data['doctor_gender'] = this.doctorGender;
    data['doctor_faceBook'] = this.doctorFaceBook;
    data['doctor_instgram'] = this.doctorInstgram;
    data['doctor_map'] = this.doctorMap;
    data['doctor_state'] = this.doctorState;
    data['doctor_specialization'] = this.doctorSpecialization;
    data['doctor_phoneNumber'] = this.doctorPhoneNumber;
    data['doctor_certification'] = this.doctorCertification;
    data['doctor_experience'] = this.doctorExperience;
    data['doctor_insuranceCompanies'] = this.doctorInsuranceCompanies;
    data['doctor_location'] = this.doctorLocation;
    data['doctor_openTime'] = this.doctorOpenTime;
    data['doctor_token'] = this.doctorToken;
    data['doctor_password'] = this.doctorPassword;
    return data;
  }
}

class FreeTime {
  String? freeTimeDate;
  String? freeTimeTitle;
  String? freeTimeNote;
  String? freeTimeStatedTime;
  String? freeTimeDay;
  String? freeTimeEndTime;
  int? remider;
  int? freeTimeDoctorId;
  int? freeTimeId;
  int? freeTimeAvailable;

  FreeTime(
      {this.freeTimeDate,
        this.freeTimeTitle,
        this.freeTimeNote,
        this.freeTimeStatedTime,
        this.freeTimeDay,
        this.freeTimeEndTime,
        this.remider,
        this.freeTimeDoctorId,
        this.freeTimeId,
        this.freeTimeAvailable});

  FreeTime.fromJson(Map<dynamic, dynamic> json) {
    freeTimeDate = json['freeTime_date'];
    freeTimeTitle = json['freeTime_title'];
    freeTimeNote = json['freeTime_note'];
    freeTimeStatedTime = json['freeTime_statedTime'];
    freeTimeDay = json['freeTime_day'];
    freeTimeEndTime = json['freeTime_endTime'];
    remider = json['remider'];
    freeTimeDoctorId = json['freeTime_doctor_id'];
    freeTimeId = json['freeTime_id'];
    freeTimeAvailable = json['freeTime_available'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['freeTime_date'] = this.freeTimeDate;
    data['freeTime_title'] = this.freeTimeTitle;
    data['freeTime_note'] = this.freeTimeNote;
    data['freeTime_statedTime'] = this.freeTimeStatedTime;
    data['freeTime_day'] = this.freeTimeDay;
    data['freeTime_endTime'] = this.freeTimeEndTime;
    data['remider'] = this.remider;
    data['freeTime_doctor_id'] = this.freeTimeDoctorId;
    data['freeTime_id'] = this.freeTimeId;
    data['freeTime_available'] = this.freeTimeAvailable;
    return data;
  }
}

class Satisfactoryrecord {
  int? satisfactoRyrecordUserId;
  int? satisfactoRyrecordDoctorId;
  String? satisfactoRyrecordDate;
  String? satisfactoRyrecordInspection;
  String? satisfactoRyrecordPharmaceutical;
  String? satisfactoRyrecordNotes;
  int? satisfactoRyrecordId;
  String? satisfactoRyrecordTime;
  String? satisfactoryrecordImage;
  int? satisfactoRyrecordStatus;
  String? userPhoneNumber;
  String? userName;
  String? userAge;
  String? userEmail;

  Satisfactoryrecord(
      {this.satisfactoRyrecordUserId,
        this.satisfactoRyrecordDoctorId,
        this.satisfactoRyrecordDate,
        this.satisfactoRyrecordInspection,
        this.satisfactoRyrecordPharmaceutical,
        this.satisfactoRyrecordNotes,
        this.satisfactoRyrecordId,
        this.satisfactoRyrecordTime,
        this.satisfactoryrecordImage,
        this.satisfactoRyrecordStatus,
        this.userPhoneNumber,
        this.userName,
        this.userAge,
        this.userEmail
      });

  Satisfactoryrecord.fromJson(Map<dynamic, dynamic> json) {
    satisfactoRyrecordUserId = json['satisfactoRyrecord_user_id'];
    satisfactoRyrecordDoctorId = json['satisfactoRyrecord_doctor_id'];
    satisfactoRyrecordDate = json['satisfactoRyrecord_date'];
    satisfactoRyrecordInspection = json['satisfactoRyrecord_inspection'];
    satisfactoRyrecordPharmaceutical =
    json['satisfactoRyrecord_pharmaceutical'];
    satisfactoRyrecordNotes = json['satisfactoRyrecord_notes'];
    satisfactoRyrecordId = json['satisfactoRyrecord_id'];
    satisfactoRyrecordTime = json['satisfactoRyrecord_time'];
    userPhoneNumber = json['user_phoneNumber'];
    satisfactoryrecordImage = json['satisfactoryrecord_image'];
    satisfactoRyrecordStatus = json['satisfactoRyrecord_status'];
    userName = json['userName'];
    userAge = json['user_age'];
    userEmail = json['user_email'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['satisfactoRyrecord_user_id'] = this.satisfactoRyrecordUserId;
    data['satisfactoRyrecord_doctor_id'] = this.satisfactoRyrecordDoctorId;
    data['satisfactoRyrecord_date'] = this.satisfactoRyrecordDate;
    data['satisfactoRyrecord_inspection'] = this.satisfactoRyrecordInspection;
    data['satisfactoRyrecord_pharmaceutical'] =
        this.satisfactoRyrecordPharmaceutical;
    data['satisfactoRyrecord_notes'] = this.satisfactoRyrecordNotes;
    data['satisfactoRyrecord_id'] = this.satisfactoRyrecordId;
    data['satisfactoRyrecord_time'] = this.satisfactoRyrecordTime;
    data['user_phoneNumber'] = this.userPhoneNumber;
    data['userName'] = this.userName;
    data['satisfactoryrecord_image'] = this.satisfactoryrecordImage;
    data['satisfactoRyrecord_status'] = this.satisfactoRyrecordStatus;
    data['user_age'] = this.userAge;
    data['user_email'] = this.userEmail;
    return data;
  }
}

class Reservation {
  int? reservationId;
  int? doctorId;
  int? userId;
  int? freetimeId;

  Reservation(
      {this.reservationId, this.doctorId, this.userId, this.freetimeId});

  Reservation.fromJson(Map<dynamic, dynamic> json) {
    reservationId = json['reservation_id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    freetimeId = json['freetime_id'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['reservation_id'] = this.reservationId;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['freetime_id'] = this.freetimeId;
    return data;
  }
}

class Upcomingschedule {
  int? upcomingScheduleId;
  int? upcomingScheduleUserId;
  int? upcomingScheduleDoctorId;
  String? upcomingScheduleDate;
  String? upcomingScheduleStatuse;
  String? upcomingScheduleNotest;
  String? upcomingScheduleStartTime;
  String? upcomingScheduleEndTime;
  int? upcomingscheduleFreeTimeId;
  String? userName;
  int? upcomingschedule_user_satis;
  String? upcomingscheduleUserChildren;
  String? upcomingscheduleUserChildrenAge;
  String ? user_age ;
  String ? user_gender;
  String ? user_phoneNumber ;
  String ? user_email ;

  Upcomingschedule(
      {this.upcomingScheduleId,
        this.upcomingScheduleUserId,
        this.upcomingScheduleDoctorId,
        this.upcomingScheduleDate,
        this.upcomingScheduleStatuse,
        this.upcomingScheduleNotest,
        this.upcomingScheduleStartTime,
        this.upcomingScheduleEndTime,
        this.userName,
        this.user_age,
        this.user_email,
        this.user_gender,
        this.user_phoneNumber,
        this.upcomingscheduleFreeTimeId,
        this.upcomingschedule_user_satis,
        this.upcomingscheduleUserChildren,
        this.upcomingscheduleUserChildrenAge,
      });

  Upcomingschedule.fromJson(Map<dynamic, dynamic> json) {
    upcomingScheduleId = json['upcomingSchedule_id'];
    userName = json['userName'];
    upcomingScheduleUserId = json['upcomingSchedule_user_id'];
    upcomingScheduleDoctorId = json['upcomingSchedule_doctor_id'];
    upcomingScheduleDate = json['upcomingSchedule_date'];
    upcomingScheduleStatuse = json['upcomingSchedule_statuse'];
    upcomingScheduleNotest = json['upcomingSchedule_notest'];
    upcomingScheduleStartTime = json['upcomingSchedule_startTime'];
    upcomingScheduleEndTime = json['upcomingSchedule_endTime'];
    upcomingscheduleFreeTimeId = json['upcomingschedule_freeTime_id'];
    user_age = json['user_age'];
    user_email = json['user_email'];
    user_gender = json['user_gender'];
    user_phoneNumber = json['user_phoneNumber'];
    upcomingschedule_user_satis = json['upcomingschedule_user_satis'];
    upcomingscheduleUserChildren = json['upcomingschedule_user_children'];
    upcomingscheduleUserChildrenAge =json['upcomingschedule_user_children_age'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['upcomingSchedule_id'] = this.upcomingScheduleId;
    data['upcomingSchedule_user_id'] = this.upcomingScheduleUserId;
    data['upcomingSchedule_doctor_id'] = this.upcomingScheduleDoctorId;
    data['upcomingSchedule_date'] = this.upcomingScheduleDate;
    data['upcomingSchedule_statuse'] = this.upcomingScheduleStatuse;
    data['upcomingSchedule_notest'] = this.upcomingScheduleNotest;
    data['upcomingSchedule_startTime'] = this.upcomingScheduleStartTime;
    data['upcomingSchedule_endTime'] = this.upcomingScheduleEndTime;
    data['upcomingschedule_freeTime_id'] = this.upcomingscheduleFreeTimeId;
    data['userName'] = this.userName;
    data['user_age'] = this.user_age;
    data['user_email'] = this.user_email;
    data['user_gender'] = this.user_gender;
    data['user_phoneNumber'] = this.user_phoneNumber;
    data['upcomingschedule_user_satis'] = this.upcomingschedule_user_satis;
    data['upcomingschedule_user_children'] = this.upcomingscheduleUserChildren;
    data['upcomingschedule_user_children_age'] = this.upcomingscheduleUserChildrenAge;
    return data;
  }
}
