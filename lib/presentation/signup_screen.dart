import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:intl/intl.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/presentation/signup_complet.dart';
import 'package:myclinics/users/cubit/login_signup_cubit.dart';
import 'package:myclinics/users/otp_screen.dart';

class SignUpScreen extends StatelessWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var firstNameController = TextEditingController();
    var sacandNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailConroller = TextEditingController();
    var passwordController = TextEditingController();

    return  BlocConsumer<LoginSignupCubit , LoginSignupState>(
      listener: (context, state) {
        if(state is LoginSignupOTPErrorPhoneNumber){
          showTost('${state.error.message}', Colors.red);
        }
        LoginSignupCubit cubit = LoginSignupCubit.get(context);
        if(state is LoginSighupCheckPhoneEmailSuss){
          if(state.verification!.status == 'success'){
            showTost("الرجاء الأنتظار .....", Colors.green);
            cubit.otpAuth(email: emailConroller.text , firstName: firstNameController.text , lastName: lastNameController.text , password: passwordController.text , secandName: sacandNameController.text , context: context , phoneNumber: phoneController.text.substring(1) , gender:cubit.gender  , age:DateFormat('dd-MM-yyyy').format(cubit.currentDate).toString() );
          }else{
            showTost(state.verification!.message!, Colors.red);
          }
        }
      },
      builder: (context, state) {
        LoginSignupCubit cubit = LoginSignupCubit.get(context);
        return Scaffold(
          body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(snapshot.data==ConnectivityResult.none)
                            Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('الرجاء التحقق من الأتصال بالانترنت',style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                                  Icon(Icons.error_outline , color:  Colors.white,),

                                ],
                              ),
                            ),
                          if(state is LoginSignupCheckInterNetError)
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline , color:  Colors.white,),
                                  Text('الرجاء التحقق من الأتصال بالانترنت',style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("assets/image/doctors.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.person) ,
                              keyboardType: TextInputType.name ,
                              labelText: 'الأسم الأول',
                              controller: firstNameController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال الأسم الأول';
                                }return null ;
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          TextFeild(
                              prefixIcon: Icon(Icons.person) ,
                              keyboardType: TextInputType.name ,
                              labelText: 'الأسم الأب',
                              controller: sacandNameController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال الأسم الثاني';
                                }return null ;
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.person) ,
                              keyboardType: TextInputType.name ,
                              labelText: 'الأسم العائلة',
                              controller: lastNameController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال اسم العائلة';
                                }return null ;
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.email) ,
                              keyboardType: TextInputType.emailAddress ,
                              labelText: 'البريد الألكتروني',
                              controller: emailConroller,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال البريد الألكتروني';
                                }else if (EmailValidator.validate(value)!=true){
                                  return 'الرجاء كتابة صيغة صحيحة للبريد الألكتروني';
                                }
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('الجنس:' , style: TextStyle(fontSize: 25),),
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
                                  Text('ذكر' , style: TextStyle(fontSize: 20),),
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
                                  Text('أنثى',style: TextStyle(fontSize: 20),),
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
                            height: 20,
                          ),
                          DoctorFormFiled(
                              title: 'تاريخ الميلاد' ,
                              hint: DateFormat('dd-MM-yyyy').format(cubit.currentDate) ,
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
                          TextFeild(
                              prefixIcon: Icon(Icons.phone) ,
                              keyboardType: TextInputType.phone ,
                              labelText: 'رقم الهاتف',
                              hintText: '07XXXXXXXX',
                              controller: phoneController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال رقم الهاتف';
                                }else if (value.length!= 10){
                                  return 'الرجاء ادخال رقم صحيح';
                                }
                              }
                          ),
                          Text(' رقم الهاتف مكون من 10 ارقام'),
                          SizedBox(
                            height: 20,
                          ),
                          TextFeild(
                              prefixIcon: Icon(Icons.lock) ,
                              keyboardType: TextInputType.visiblePassword ,
                              labelText: 'كلمة السر',
                              controller: passwordController,
                              obscureText: cubit.ObsText,
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.ObsTextChange(cubit.ObsText);
                                  },
                                  icon:  cubit.ObsText?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'الرجاء ادخال كلمة السر';
                                }return null ;
                              }
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FlutterPwValidator(
                            controller: passwordController,
                            width: 400,
                            height: 225,
                            minLength: 6,
                            numericCharCount: 1,
                            uppercaseCharCount: 1,
                            specialCharCount: 1,
                            onSuccess: (){
                              cubit.ChangepasswordRols(true);
                            },
                            onFail: (){
                              cubit.ChangepasswordRols(false);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                             condition:state is!LoginSighupCheckPhoneEmailLoding ,
                             builder: (context) =>  Container(
                               width: double.infinity,
                               height: 60,
                               decoration: BoxDecoration(
                                 color: Colors.deepPurple ,
                                 borderRadius: BorderRadius.circular(15),
                               ),
                               child: MaterialButton(
                                 onPressed: (){
                                   cubit.loadingAuth = true ;
                                   if(formKey.currentState!.validate()){
                                     if(cubit.group!=0 && cubit.passwordRols==true && DateFormat('dd-MM-yyyy').format(cubit.currentDate)!=DateFormat('dd-MM-yyyy').format(DateTime.now())){
                                       cubit.inteNetReselt();
                                       if(cubit.checkConnection == false){
                                         showTost('الرجاء تاكد من الأتصال بالانترنت', Colors.red);
                                       }else if(snapshot.data!=ConnectivityResult.none){
                                         cubit.checkPhoneEmail(userPhone: phoneController.text , userEmail: emailConroller.text);
                                         //cubit.emailAuth(emailConroller.text, passwordController.text);
                                       }else{
                                         showTost("الرجاء التحقق من الأتصال بالانترنت", Colors.red);
                                       }
                                     }else if(cubit.passwordRols==false){
                                       showTost('الرجاء تاكد من كلمة السر', Colors.red);
                                     }
                                     else if(DateFormat('dd-MM-yyyy').format(cubit.currentDate)==DateFormat('dd-MM-yyyy').format(DateTime.now())){
                                       showTost('الرجاء ادخال تاريخ الميلاد', Colors.red);
                                     } else {
                                       showTost('الرجاءالتأكد من ادخال جميع الحقول', Colors.red);
                                     }
                                   }
                                 },
                                 child: Text('تسجيل الحساب' , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),),
                               ),
                             ),
                             fallback: (context) => Center(child: CircularProgressIndicator(),),
                         ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
}

