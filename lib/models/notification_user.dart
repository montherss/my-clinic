class NotificationUser {
  String? status;
  List<Notificationss>? notification;

  NotificationUser({this.status, this.notification});

  NotificationUser.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['notification'] != null) {
      notification = <Notificationss>[];
      json['notification'].forEach((v) {
        notification!.add(new Notificationss.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.notification != null) {
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notificationss {
  int? notificationId;
  String? notificationTitle;
  String? notificationBody;
  String? notificationTime;
  int? notificationState;
  int? notificationUserId;
  String? notificationUserHoure;
  String?notificationUserDoctorImage;

  Notificationss(
      {this.notificationId,
        this.notificationTitle,
        this.notificationBody,
        this.notificationTime,
        this.notificationState,
        this.notificationUserId,
        this.notificationUserHoure,
        this.notificationUserDoctorImage,
      });

  Notificationss.fromJson(Map<dynamic, dynamic> json) {
    notificationId = json['notification_id'];
    notificationTitle = json['notification_title'];
    notificationBody = json['notification_body'];
    notificationTime = json['notification_time'];
    notificationState = json['notification_state'];
    notificationUserId = json['notification_user_id'];
    notificationUserHoure = json['notification_user_houre'];
    notificationUserDoctorImage = json['notification_user_doctor_image'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_title'] = this.notificationTitle;
    data['notification_body'] = this.notificationBody;
    data['notification_time'] = this.notificationTime;
    data['notification_state'] = this.notificationState;
    data['notification_user_id'] = this.notificationUserId;
    data['notification_user_houre'] = this.notificationUserHoure;
    data['notification_user_doctor_image'] = this.notificationUserDoctorImage;
    return data;
  }
}