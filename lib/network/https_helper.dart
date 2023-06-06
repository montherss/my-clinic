import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myclinics/component/component.dart';
import 'package:path/path.dart';

import '../constant/constant.dart';




class Crud {
  static Future<Map> postData({
    required String linkUrl ,
    required String name ,
    required String name2 ,
    required String name3 ,
    required String  email,
    required String gender ,
    required String phoneNumber ,
    required String age ,
    required String passWord ,
})async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders, body:{
        "userName":name,
        "user_name2": name2,
        "user_name3": name3,
        "user_age": age,
        "user_gender": gender,
        "user_phoneNumber": "0$phoneNumber",
        "user_password": passWord,
        "user_email": email,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      throw(e.toString());
    }
  }
  static Future<Map> getDate({ required String linkUrl }) async {
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.get(url,headers: myheaders,);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> checkPhoneEmail({ required String linkUrl  , required String userPhone , required String userEmail}) async {
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders ,body: {
        "user_phoneNumber":"0$userPhone",
        "user_email":userEmail,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost(e.toString(), Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> loginUser({
    required String linkUrl ,
    required String phoneNumber ,
    required String password ,
})async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_phoneNumber":phoneNumber,
        "user_password":password,
      });
      print(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost(e.toString(), Colors.red);
      throw(e.toString());
    }


  }

  static Future<Map> loginDoctors({
    required String linkUrl ,
    required String phoneNumber ,
    required String password ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "doctor_phoneNumber":phoneNumber,
        "doctor_password":password,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }


  static Future<Map> getUerFromHttp({
    required String linkUrl ,
    required String id ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":id,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> subMitUserScedule({
    required String linkUrl ,
    required String user_id ,
    required String user_name ,
    required String doctor_id ,
    required String startTime ,
    required String date ,
    required String endTime ,
    required String freeTimeId ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":user_id,
        "user_name":user_name,
        "doctor_id":doctor_id,
        "startTime":startTime,
        "date":date,
        "endTime":endTime,
        "freeTime_id":freeTimeId,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> upDateUserData({
    required String linkUrl ,
    required String user_id ,
    required String name ,
    required String name2 ,
    required String name3 ,
    required String  email,
    required String phoneNumber ,
    required String age ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "user_id" : user_id,
        "userName":name,
        "user_name2": name2,
        "user_name3": name3,
        "user_age": age,
        "user_phoneNumber": phoneNumber,
        "user_email": email,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> cancelUpComing({
    required String linkUrl ,
    required String user_id ,
    required String freeTimeId ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "user_id" : user_id,
        "freeTime_id":freeTimeId,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> getDoctorFromHttp({
    required String linkUrl ,
    required String id ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "doctor_id":id,
      });
      print(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> approveDoctor({
    required String linkUrl ,
    required String user_id ,
    required String doctor_id,
    required String upcoming_id,
    required String doctor_image,
    required String freeTime_id,
    required String doctor_name,
    required String date,
    required String houre,
  })async{
    try{
      print("HI ALL");
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "user_id" : user_id,
        "doctor_id": doctor_id,
        "upcoming_id":upcoming_id,
        "freeTime_id":freeTime_id,
        "doctor_name":doctor_name,
        "doctor_image":doctor_image,
        "time":date,
        "houre":houre,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost(e.toString(), Colors.red);
      print(e.toString());
      throw(e.toString());
    }
  }
  static Future<Map> cancelDoctor({
    required String linkUrl ,
    required String user_id ,
    required String doctor_id,
    required String freeTime_id,
    required String upcoming_id,
    required String doctor_name,
    required String note,
    required String date,
    required String houre,
    required String doctor_image,

  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "user_id" : user_id,
        "doctor_id": doctor_id,
        "upcoming_id":upcoming_id,
        "doctor_name":doctor_name,
        "freeTime_id":freeTime_id,
        "doctor_image":doctor_image,
        "note":note,
        "time":date,
        "houre":houre,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> addFreeTimeDoctor({
    required String linkUrl ,
    required String freeTime_date ,
    required String freeTime_title,
    required String freeTime_note,
    required String freeTime_statedTime,
    required String freeTime_day,
    required String freeTime_endTime,
    required String freeTime_doctor_id,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "freeTime_date" : freeTime_date,
        "freeTime_title": freeTime_title,
        "freeTime_note":freeTime_note,
        "freeTime_statedTime":freeTime_statedTime,
        "freeTime_day":freeTime_day,
        "freeTime_endTime":freeTime_endTime,
        "freeTime_doctor_id":freeTime_doctor_id,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> updateFreeTimeDoctor({
    required String linkUrl ,
    required String freeTime_date ,
    required String freeTime_title,
    required String freeTime_note,
    required String freeTime_statedTime,
    required String freeTime_day,
    required String freeTime_endTime,
    required String freeTime_doctor_id,
    required String freeTime_id,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "freeTime_date" : freeTime_date,
        "freeTime_title": freeTime_title,
        "freeTime_note":freeTime_note,
        "freeTime_statedTime":freeTime_statedTime,
        "freeTime_day":freeTime_day,
        "freeTime_endTime":freeTime_endTime,
        "freeTime_doctor_id":freeTime_doctor_id,
        "freeTime_id":freeTime_id,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }


  static Future<Map> deleteFreeTimeDoctor({
    required String linkUrl ,
    required String freeTime_doctor_id,
    required String freeTime_id,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "doctor_id":freeTime_doctor_id,
        "freeTime_id":freeTime_id,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> updateDoctorProfile({
    required String linkUrl ,
    required String doctor_name,
    required String doctor_certification,
    required String doctor_experience,
    required String doctor_insuranceCompanies,
    required String doctor_openTime,
    required String doctor_location,
    required String doctor_id,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "doctor_id":doctor_id,
        "doctor_name":doctor_name,
        "doctor_certification":doctor_certification,
        "doctor_experience":doctor_experience,
        "doctor_insuranceCompanies":doctor_insuranceCompanies,
        "doctor_openTime":doctor_openTime,
        "doctor_location":doctor_location,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> addSatisfactoyRecord({
    required String linkUrl ,
    required String satisfactoRyrecord_user_id,
    required String satisfactoRyrecord_doctor_id,
    required String doctor_name,
    required String doctor_image,
    required String satisfactoRyrecord_date,
    required String satisfactoRyrecord_inspection,
    required String satisfactoRyrecord_pharmaceutical,
    required String satisfactoRyrecord_notes,
    required String upcomingSchedule_id,
    required String satisfactoRyrecord_time,
    required String satisfactoRyrecord_status,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "satisfactoRyrecord_user_id":satisfactoRyrecord_user_id,
        "satisfactoRyrecord_doctor_id":satisfactoRyrecord_doctor_id,
        "doctor_name":doctor_name,
        "doctor_image":doctor_image,
        "satisfactoRyrecord_date":satisfactoRyrecord_date,
        "satisfactoRyrecord_inspection":satisfactoRyrecord_inspection,
        "satisfactoRyrecord_pharmaceutical":satisfactoRyrecord_pharmaceutical,
        "satisfactoRyrecord_notes":satisfactoRyrecord_notes,
        "upcomingSchedule_id":upcomingSchedule_id,
        "satisfactoRyrecord_time":satisfactoRyrecord_time,
        "satisfactoRyrecord_status":satisfactoRyrecord_status,
        "file":"",
      });
      print(res.body);
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> addFav({
    required String linkUrl ,
    required String user_id ,
    required String doctor_id ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":user_id,
        "doctor_id":doctor_id,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> deleteFav({
    required String linkUrl ,
    required String user_id ,
    required String doctor_id ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":user_id,
        "doctor_id":doctor_id,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> updateUserToken({
    required String linkUrl ,
    required String user_id ,
    required String token ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":user_id,
        "token":token ,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> updateDoctorToken({
    required String linkUrl ,
    required String doctor_id ,
    required String token ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "doctor_id":doctor_id,
        "token":token ,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> addChildren({
    required String linkUrl ,
    required String user_id ,
    required String chiled_name ,
    required String age ,
    required String gender ,

  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "children_user_id": user_id,
        "children_name": chiled_name,
        "children_age": age,
        "children_gender": gender,

      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> removeChildren({
    required String linkUrl ,
    required String children_id ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "children_id":children_id,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> subMitUserChildrenScedule({
    required String linkUrl ,
    required String user_id ,
    required String user_name ,
    required String doctor_id ,
    required String startTime ,
    required String date ,
    required String endTime ,
    required String freeTimeId ,
    required String chiled_name ,
    required String chiled_age ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body: {
        "user_id":user_id,
        "user_name":user_name,
        "doctor_id":doctor_id,
        "startTime":startTime,
        "date":date,
        "endTime":endTime,
        "freeTime_id":freeTimeId,
        "chiled_name":chiled_name,
        "chiled_age":chiled_age,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<dynamic , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
  static Future<Map> getUserNotification({
    required String linkUrl ,
    required String user_id ,

  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url ,headers: myheaders , body:{
        "user_id" : user_id,
      });
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> addSatisfactoyRecordImage({
    required Map data ,
    required String linkUrl ,
    required File file ,
  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      var image = http.MultipartRequest("POST" , url );
      image.headers.addAll(myheaders);
      var length = await file.length();
      var stream =  http.ByteStream(file.openRead());
      var multipartFile = http.MultipartFile("file", stream, length , filename: basename(file.path));
      image.files.add(multipartFile);
      data.forEach((key, value) {
        image.fields[key]=value;
      });
      var myReq = await image.send();
      var resPonse = await http.Response.fromStream(myReq);
      //print(resPonse.body);
      if(myReq.statusCode == 200 || myReq.statusCode == 201){
        Map resBody =jsonDecode(resPonse.body);
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }

  static Future<Map> getNews({
    required String linkUrl ,

  })async{
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.get(url);
      if(res.statusCode == 200 || res.statusCode == 201){
        Map resBody =jsonDecode(res.body);
        client.close();
        return resBody ;
      }else{
        throw("ERROR REQ");
      }
    }catch(e){
      showTost("SERVER ERROR !", Colors.red);
      throw(e.toString());
    }
  }
}