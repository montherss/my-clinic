import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyDialog extends StatelessWidget {
  final String mdFileName ;
  final double raduis ;
  PrivacyDialog({this.raduis=8 , required this.mdFileName}):assert(mdFileName.contains('.md'));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(raduis)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString('assets/$mdFileName');
              }),
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Markdown(
                    data: snapshot.data.toString(),

                );
              }return Center(child: CircularProgressIndicator(),);
            },
            ),
          ),
          TextButton(
              onPressed: (){
            Navigator.pop(context);
          }, child: Text("عودة") )
        ],
      ),
    );
  }
}
