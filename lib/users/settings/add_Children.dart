import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

class AddChildren extends StatelessWidget {
  const AddChildren({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
        if(state is HomeAddChildrenSuss){
          if(state.verification.status=="success"){
            showTost("تم اضافة الأبن بنجاح !", Colors.green);
          }else {
            showTost("حدث خطأ", Colors.red);
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('اضافة ابن' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple)),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.deepPurple,
                              )
                          ),
                        ],
                      ) ,
                      SizedBox(
                        height: 50,
                      ),
                      TextFeild(
                        labelText: "اسم الأبن" ,
                        keyboardType: TextInputType.name ,
                        controller: nameController,
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return"الرجاء ادخال اسم الأبن";
                          }
                        }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DoctorFormFiled(
                          title: 'التاريخ الميلاد' ,
                          hint: DateFormat('yyyy-MM-dd').format(cubit.currentDate) ,
                          validator: (value){
                            if(value == DateFormat('yyyy-MM-dd').format(DateTime.now())){
                              showTost("الرجاء اختيار التاريخ ", Colors.red);
                            }
                          },
                          widget: IconButton(
                              onPressed: ()async{
                                cubit.selectedDateTime(await getDateFromUser(context));
                              },
                              icon: Icon(Icons.calendar_month_outlined , color: Colors.grey,)
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('الجنس:' , style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10,),
                          if(cubit.group!=0)
                            Icon(
                                cubit.group ==1 ?
                                Icons.male_outlined :
                                Icons.female
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text('ذكر' , style: TextStyle(fontSize: 15),),
                              Radio(
                                value: 1,
                                groupValue: cubit.group,
                                onChanged: (T){
                                  cubit.ChangeRadio(T!);
                                } ,
                                activeColor: Colors.blue,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('أنثى',style: TextStyle(fontSize: 15),),
                              Radio(
                                value: 2,
                                groupValue: cubit.group,
                                onChanged: (T){
                                  cubit.ChangeRadio(T!);
                                },
                                activeColor: Colors.pink,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                          condition: state is! HomeAddChildrenLoading,
                          builder: (context) => Button(text: "اضافة", function: (){
                            if(FormKey.currentState!.validate()){
                              if(DateFormat('yyyy-MM-dd').format(cubit.currentDate)== DateFormat('yyyy-MM-dd').format(DateTime.now())){
                                showTost("الرجاء اختيار تاريخ ميلاد الأبن", Colors.red);
                              }else if (cubit.gender==''||cubit.gender.isEmpty ){
                                showTost("الرجاء اختيار الجنس الأبن", Colors.red);
                              } else {
                                cubit.addChildren(user_id: USERID, chiled_name: nameController.text, age:DateFormat('yyyy-MM-dd').format(cubit.currentDate), gender: cubit.gender);
                              }
                            }
                          }),
                          fallback: (context) => CircularProgressIndicator(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      },
    );
  }
}
