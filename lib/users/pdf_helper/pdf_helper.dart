import 'dart:io';

import 'package:flutter/services.dart';
import 'package:myclinics/models/satisfactory_record.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/pdf_helper/pdf_opener.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;


class PdfDetails{
  static Future<File> generate(Satisfactoryrecord satisfactoRyrecord)async{
    Document pdf = Document();
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    var myFont = Font.ttf(data);
    pdf.addPage(
      Page(
        theme: ThemeData.withFont(
          base: myFont,
        ),
        build: (context) => Directionality(textDirection: TextDirection.rtl, child: buildTitle(satisfactoRyrecord),)
      )
    );
    return PdfOpener.saveDocument(name: 'DoctorVisits.pdf', pdf: pdf);
  }
  static Widget buildTitle (Satisfactoryrecord satisfactoRyrecord){
    return  Align(
      alignment: Alignment.topRight,
      child: Column(
          children: [
            Center(
              child: Text('عيادتي' , style: TextStyle(fontSize: 35  ),textDirection: TextDirection.rtl,),
            ),
            SizedBox(
                height: 0.8*PdfPageFormat.cm
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('السجل المرضي' , style: TextStyle(fontSize: 30  ),textDirection: TextDirection.rtl,),
              ]
            ),
            SizedBox(
                height: 0.8*PdfPageFormat.cm
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${satisfactoRyrecord.doctorName}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                Text('اسم الطبيب :-',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
              ]
            ),
            SizedBox(
                height: 1*PdfPageFormat.cm
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' المعاينة :-',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Text('${satisfactoRyrecord.satisfactoRyrecordInspection}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
              ]
            ),
            SizedBox(
                height: 0.8*PdfPageFormat.cm
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' الأدوية الموصوفة :-',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Text('${satisfactoRyrecord.satisfactoRyrecordPharmaceutical}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                ]
            ),
            SizedBox(
                height: 0.8*PdfPageFormat.cm
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('الملاحظات :-',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Text('${satisfactoRyrecord.satisfactoRyrecordNotes}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25)),
                ]
            ),
            SizedBox(
                height:2*PdfPageFormat.cm
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${satisfactoRyrecord.satisfactoRyrecordDate}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20)),
                      Text('التاريخ الزيارة :-',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Text('طاقم عمل عيادتكم يتمنون لكم الصحة و السلامة',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20)),
              ]
            ),
            Spacer(),
            Text('جميع الحقوق محفوظة'),
          ]
      )
    );
  }
}