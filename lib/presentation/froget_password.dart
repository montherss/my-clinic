import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('اعادة تعيين كلمة السر' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
