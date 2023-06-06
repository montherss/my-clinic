import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/presentation/login_screen.dart';

class SignUpComplete extends StatelessWidget {
  const SignUpComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Lottie.asset('assets/lottie/completed-icon.json'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'تم انشاء الحساب بنجاح ! ',
                style: TextStyle(fontSize: 30, color: Colors.deepPurple),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: () {
                    NavegatAndFinish(context, Directionality(textDirection: TextDirection.rtl, child: LogInScreen()));
                  },
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
