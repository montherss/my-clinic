import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

class EditeProfile extends StatelessWidget {
  const EditeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  name1Controller = TextEditingController();
    var  name2Controller = TextEditingController();
    var  name3Controller = TextEditingController();
    var  emailController = TextEditingController();
    var  ageController = TextEditingController();
    var  phoneNumberController = TextEditingController();
    var FormKey = GlobalKey<FormState>();
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
        if(state is HomeUpdateUserSuss){
          showTost('تم التعديل بنجاح', Colors.green);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('تعديل الملف الشخصي' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
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
                        height: 30,
                      ),
                      TextFeild(
                          labelText:'الأسم الأول' ,
                          keyboardType: TextInputType.name,
                          hintText:cubit.userHome!.data!.user![0].userName!,
                        controller: name1Controller,
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return"الرجاء ادخال الأسم الأول";
                          }
                        }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                TextFeild(
                    labelText:'الأسم الثاني' ,
                    keyboardType: TextInputType.name,
                    hintText:  cubit.userHome!.data!.user![0].userName2!,
                    controller: name2Controller,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return"الرجاء ادخال الأسم الثاني";
                      }
                    }
                ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'الأسم العائلة' ,
                          keyboardType: TextInputType.name,
                          hintText:  cubit.userHome!.data!.user![0].userName3!,
                          controller: name3Controller,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال الأسم العائلة";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'تاريخ الميلاد' ,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          hintText: DateFormat('dd-MM-yyyy').format(cubit.currentDate) ,
                          suffixIcon: IconButton(
                          onPressed: ()async{
                            cubit.selectedDateTime(await getDateFromUser(context));
                          },
                          icon: Icon(Icons.calendar_month)
                      ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'رقم الهاتف' ,
                          keyboardType: TextInputType.number,
                          hintText:  cubit.userHome!.data!.user![0].userPhoneNumber!,
                          controller: phoneNumberController,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return"الرجاء ادخال رقم الهاتف";
                            }else if (value.length!=10){
                              return "الرجاء ادخال رقم الهاتف بشكل صحيح";
                            }
                          }
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFeild(
                          labelText:'البريد الألكتروني' ,
                          keyboardType: TextInputType.emailAddress,
                          hintText:cubit.userHome!.data!.user![0].userEmail!,
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'الرجاء ادخال البريد الألكتروني';
                            }else if (EmailValidator.validate(value)!=true){
                              return 'الرجاء كتابة صيغة صحيحة للبريد الألكتروني';
                            }
                          }
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                          condition: state is! HomeUpdateUserLoading,
                          builder: (context) => Button(text: 'تعديل المعلومات الشخصية', function: (){
                            if(FormKey.currentState!.validate()){
                              print(ageController.text);
                              ShowDialog(
                                  context: context ,
                                  title: Text('تعديل الملف الشخصي',style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                                  content: Text('سيتم تعديل البيانات الشخصية عند الموافقة'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      cubit.upDateUserData(user_id: USERID, name: name1Controller.text, name2: name2Controller.text, name3: name3Controller.text, email: emailController.text, phoneNumber: phoneNumberController.text, age:DateFormat('dd-MM-yyyy').format(cubit.currentDate).toString());
                                      Navigator.pop(context);
                                      cubit.getUser(USERID);
                                    }, child: Text('تعديل')) ,
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('الغاء')) ,
                                  ]
                              );
                            }
                          }),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

