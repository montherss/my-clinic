
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myclinics/models/userHome.dart';

void NavegatTo (context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
void NavegatAndFinish (context,Widget screen){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen , ),(route)=>false);
}
Widget Button ({
  required String text,
  required VoidCallback function ,
}
    )=>
    Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed:function,
        child: Text(text , style: TextStyle(color: Colors.white , fontSize: 18),),
      ),
    );
Widget TextFeild({
  required String labelText ,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  FormFieldValidator<String>? validator,
  bool obscureText= false,
  TextEditingController? controller ,
  TextInputType? keyboardType,
  String? hintText,
  bool readOnly = false,
  ValueChanged<String>? onChanged,
})=> TextFormField(

    obscureText: obscureText ,
    keyboardType: keyboardType ,
    validator: validator,
    controller: controller,
    onChanged: onChanged,
    readOnly: readOnly,
    decoration: InputDecoration(
      hintText: hintText ,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      labelText:labelText ,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    )
);

Widget DoctorFormFiled ({
  required String  title ,
  required String hint ,
  TextEditingController? controller ,
  Widget? widget ,
  FormFieldValidator<String>? validator ,
  TextInputType? textInputType ,

}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(title , style: TextStyle( fontSize:  16 , fontWeight: FontWeight.w400 , color: Colors.black54),),
    SizedBox(
      height: 8,
    ),
    Container(
      height: 52 ,
      padding:  EdgeInsets.only(right: 14),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
                validator: validator,
                readOnly: widget==null?false:true,
                autofocus: false,
                keyboardType: textInputType,
                cursorColor: Colors.grey[700],
               // controller: controller,
                style: TextStyle(
                  fontSize: 16 ,
                  fontWeight: FontWeight.w400 ,
                  color: Colors.grey[600],
                ),
                decoration: InputDecoration(
                  hintText: hint ,
                  hintStyle: TextStyle(
                    fontSize: 16 ,
                    fontWeight: FontWeight.w400 ,
                    color: Colors.grey[600],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:  Colors.white,
                      width: 0,
                    )
                  ) ,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color:  Colors.white,
                        width: 0,

                      )
                  ) ,
                ),
              )
          ),
          widget == null?Container():Container(
            child: widget,
          )
        ],
      ),
    )
  ],
);
Future<void>ShowDialog({
  required context ,
  required Widget? title ,
  required List<Widget> actions ,
  required Widget? content,
  double? elevation ,
})=> showDialog(
  context: context,
  builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child: AlertDialog(
    title: title,
    actions: actions,
    content: content,
    elevation: elevation,
  ),
  ),
  barrierDismissible: true ,
);
void showTost(@required String msg , @required Color msgColor)=> Fluttertoast.showToast(
    msg:  msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: msgColor,
    textColor: Colors.white,
    fontSize: 16.0
);

getDateFromUser(context)async{
   DateTime? selectTime =  await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
  );
   if(selectTime==null){
     return 0 ;
   }
   return selectTime ;
}
getDateFromDoctorsUser(context)async{
  DateTime? selectTime =  await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
  );
  if(selectTime==null){
    return null ;
  }
  return selectTime ;
}
getTimeFromUser(context)async{
   return await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 00),
     initialEntryMode: TimePickerEntryMode.input
  );
}
Future<void>ShowDialogList({
  required context ,
  required List<Children> children ,
})=> showDialog(
  context: context,
  builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child: AlertDialog(
    title: Text("asdasc"),
    actions: [
      TextButton(onPressed: (){}, child:Text("asxxaw"))
    ],
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for(int i = 0 ; i<=children.length-1 ; i++)
             RadioListTile(
              title: Text('${children[i].childrenName}'),
              value: 0,
              groupValue: 1,
              onChanged: (value) {
              },
            ),
          ],
        );
      },
    ),
    elevation: 1,
  ),
  ),
  barrierDismissible: true ,
);