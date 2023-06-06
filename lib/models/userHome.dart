class UserHome {
  String? status;
  Data? data;

  UserHome({this.status, this.data});

  UserHome.fromJson(Map<dynamic, dynamic> json) {
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
  List<Users>? user;
  List<Doctor>? doctor;
  List<Favorite>? favorite;
  List<Children>? children;
  List<Bannel>? bannel;
  List<Satisfactoryrecord>? satisfactoryrecord;
  List<Reservation>? reservation;
  List<Upcomingschedule>? upcomingschedule;

  Data(
      {this.user,
        this.doctor,
        this.satisfactoryrecord,
        this.reservation,
        this.bannel,
        this.upcomingschedule});

  Data.fromJson(Map<dynamic, dynamic> json) {
    if (json['user'] != null) {
      user = <Users>[];
      json['user'].forEach((v) {
        user!.add(new Users.fromJson(v));
      });
    }
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
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
    if (json['favorite'] != null) {
      favorite = <Favorite>[];
      json['favorite'].forEach((v) {
        favorite!.add(new Favorite.fromJson(v));
      });
    }
    if (json['bannel'] != null) {
      bannel = <Bannel>[];
      json['bannel'].forEach((v) {
        bannel!.add(new Bannel.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
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
    if (this.bannel != null) {
      data['bannel'] = this.bannel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  String? userName;
  String? userName2;
  String? userName3;
  String? userAge;
  String? userGender;
  String? userPhoneNumber;
  String? userToken;
  String? userPassword;
  int? userAuthentication;
  String? userEmail;

  Users(
      {this.userId,
        this.userName,
        this.userName2,
        this.userName3,
        this.userAge,
        this.userGender,
        this.userPhoneNumber,
        this.userToken,
        this.userPassword,
        this.userAuthentication,
        this.userEmail});

  Users.fromJson(Map<dynamic, dynamic> json) {
    userId = json['user_id'];
    userName = json['userName'];
    userName2 = json['user_name2'];
    userName3 = json['user_name3'];
    userAge = json['user_age'];
    userGender = json['user_gender'];
    userPhoneNumber = json['user_phoneNumber'];
    userToken = json['user_Token'];
    userPassword = json['user_password'];
    userAuthentication = json['user_Authentication'];
    userEmail = json['user_email'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['user_id'] = this.userId;
    data['userName'] = this.userName;
    data['user_name2'] = this.userName2;
    data['user_name3'] = this.userName3;
    data['user_age'] = this.userAge;
    data['user_gender'] = this.userGender;
    data['user_phoneNumber'] = this.userPhoneNumber;
    data['user_Token'] = this.userToken;
    data['user_password'] = this.userPassword;
    data['user_Authentication'] = this.userAuthentication;
    data['user_email'] = this.userEmail;
    return data;
  }
}

class Doctor {
  String? doctorId;
  String? doctorName;
  String? doctorImageUrl;
  String? doctorRate;
  String? doctorSubScription;
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
  int ? favourtie ;
  List<Freetime>? freetime;

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
        this.favourtie,
        this.freetime});

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
    favourtie = json['favourtie'] ;
    if (json['freetime'] != null) {
      freetime = <Freetime>[];
      json['freetime'].forEach((v) {
        freetime!.add(new Freetime.fromJson(v));
      });
    }
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
    data['favourtie'] = this.favourtie;
    if (this.freetime != null) {
      data['freetime'] = this.freetime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Bannel {
  int? bannelImadeId;
  String? bannelImadeName;
  int? bannelImadeState;

  Bannel({this.bannelImadeId, this.bannelImadeName, this.bannelImadeState});

  Bannel.fromJson(Map<String, dynamic> json) {
    bannelImadeId = json['bannel_imade_id'];
    bannelImadeName = json['bannel_imade_name'];
    bannelImadeState = json['bannel_imade_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannel_imade_id'] = this.bannelImadeId;
    data['bannel_imade_name'] = this.bannelImadeName;
    data['bannel_imade_state'] = this.bannelImadeState;
    return data;
  }
}
class Children {
  int? childrenId;
  String? childrenName;
  String? childrenAge;
  String? childrenGender;
  int? childrenUserId;

  Children(
      {this.childrenId,
        this.childrenName,
        this.childrenAge,
        this.childrenGender,
        this.childrenUserId});

  Children.fromJson(Map<String, dynamic> json) {
    childrenId = json['children_id'];
    childrenName = json['children_name'];
    childrenAge = json['children_age'];
    childrenGender = json['children_gender'];
    childrenUserId = json['children_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['children_id'] = this.childrenId;
    data['children_name'] = this.childrenName;
    data['children_age'] = this.childrenAge;
    data['children_gender'] = this.childrenGender;
    data['children_user_id'] = this.childrenUserId;
    return data;
  }
}

class Favorite {
  int? doctorId;
  int? favoriteId;

  Favorite({this.doctorId, this.favoriteId});

  Favorite.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    favoriteId = json['favorite_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['favorite_id'] = this.favoriteId;
    return data;
  }
}

class Freetime {
  String? freeTimeDate;
  String? freeTimeTitle;
  String? freeTimeNote;
  String? freeTimeStatedTime;
  String? freeTimeDay;
  String? freeTimeEndTime;
  String? remider;
  String? freeTimeDoctorId;
  String? freeTimeId;

  Freetime(
      {this.freeTimeDate,
        this.freeTimeTitle,
        this.freeTimeNote,
        this.freeTimeStatedTime,
        this.freeTimeDay,
        this.freeTimeEndTime,
        this.remider,
        this.freeTimeDoctorId,
        this.freeTimeId});

  Freetime.fromJson(Map<dynamic, dynamic> json) {
    freeTimeDate = json['freeTime_date'];
    freeTimeTitle = json['freeTime_title'];
    freeTimeNote = json['freeTime_note'];
    freeTimeStatedTime = json['freeTime_statedTime'];
    freeTimeDay = json['freeTime_day'];
    freeTimeEndTime = json['freeTime_endTime'];
    remider = json['remider'];
    freeTimeDoctorId = json['freeTime_doctor_id'];
    freeTimeId = json['freeTime_id'];
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
  String? satisfactoRyrecordTime;
  int? satisfactoRyrecordId;
  String? satisfactoryrecordImage;
  int? satisfactoRyrecordStatus;
  String? doctorName;
  String? doctorImageUrl;
  String? doctorState;
  String? doctorSpecialization;

  Satisfactoryrecord(
      {this.satisfactoRyrecordUserId,
        this.satisfactoRyrecordDoctorId,
        this.satisfactoRyrecordDate,
        this.satisfactoRyrecordInspection,
        this.satisfactoRyrecordPharmaceutical,
        this.satisfactoRyrecordNotes,
        this.satisfactoRyrecordTime,
        this.satisfactoRyrecordId,
        this.doctorName,
        this.doctorImageUrl,
        this.satisfactoryrecordImage,
        this.satisfactoRyrecordStatus,
        this.doctorState,
        this.doctorSpecialization});

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
    doctorName = json['doctor_name'];
    satisfactoryrecordImage = json['satisfactoryrecord_image'];
    satisfactoRyrecordStatus = json['satisfactoRyrecord_status'];
    doctorImageUrl = json['doctor_imageUrl'];
    doctorState = json['doctor_state'];
    doctorSpecialization = json['doctor_specialization'];
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
    data['doctor_name'] = this.doctorName;
    data['doctor_imageUrl'] = this.doctorImageUrl;
    data['doctor_state'] = this.doctorState;
    data['satisfactoryrecord_image'] = this.satisfactoryrecordImage;
    data['satisfactoRyrecord_status'] = this.satisfactoRyrecordStatus;
    data['doctor_specialization'] = this.doctorSpecialization;
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
  String? upcomingScheduleDate;
  String? upcomingScheduleStatuse;
  String? upcomingScheduleNotest;
  String? upcomingScheduleStartTime;
  String? upcomingScheduleEndTime;
  int? upcomingscheduleFreeTimeId;
  int ? upcomingschedule_user_satis;
  String? doctorName;
  String? doctorImageUrl;
  String? doctorState;
  String? doctorSpecialization;

  Upcomingschedule(
      {this.upcomingScheduleDate,
        this.upcomingScheduleStatuse,
        this.upcomingScheduleNotest,
        this.upcomingScheduleStartTime,
        this.upcomingScheduleEndTime,
        this.doctorName,
        this.doctorImageUrl,
        this.doctorState,
        this.doctorSpecialization,
        this.upcomingscheduleFreeTimeId,
        this.upcomingschedule_user_satis,
        });

  Upcomingschedule.fromJson(Map<dynamic, dynamic> json) {
    upcomingScheduleDate = json['upcomingSchedule_date'];
    upcomingScheduleStatuse = json['upcomingSchedule_statuse'];
    upcomingScheduleNotest = json['upcomingSchedule_notest'];
    upcomingScheduleStartTime = json['upcomingSchedule_startTime'];
    upcomingScheduleEndTime = json['upcomingSchedule_endTime'];
    doctorName = json['doctor_name'];
    doctorImageUrl = json['doctor_imageUrl'];
    doctorState = json['doctor_state'];
    doctorSpecialization = json['doctor_specialization'];
    upcomingscheduleFreeTimeId = json['upcomingschedule_freeTime_id'];
    upcomingschedule_user_satis = json['upcomingschedule_user_satis'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['upcomingSchedule_date'] = this.upcomingScheduleDate;
    data['upcomingSchedule_statuse'] = this.upcomingScheduleStatuse;
    data['upcomingSchedule_notest'] = this.upcomingScheduleNotest;
    data['upcomingSchedule_startTime'] = this.upcomingScheduleStartTime;
    data['upcomingSchedule_endTime'] = this.upcomingScheduleEndTime;
    data['doctor_name'] = this.doctorName;
    data['doctor_imageUrl'] = this.doctorImageUrl;
    data['doctor_state'] = this.doctorState;
    data['doctor_specialization'] = this.doctorSpecialization;
    data['upcomingschedule_freeTime_id'] = this.upcomingscheduleFreeTimeId;
    data['upcomingschedule_user_satis'] = this.upcomingschedule_user_satis;
    return data;
  }
}
