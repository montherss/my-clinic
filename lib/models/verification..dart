class Verification{
  String? status;
  String? message;

  Verification({this.status, this.message});

  Verification.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}