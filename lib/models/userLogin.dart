class UserLogin {
  String? status;
  String? message;
  List<Data>? data;

  UserLogin({this.status, this.message, this.data});

  UserLogin.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;

  Data({this.userId});

  Data.fromJson(Map<dynamic, dynamic> json) {
    userId = json['user_id'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}
