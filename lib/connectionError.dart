import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConncectionError extends StatelessWidget {
  const ConncectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("لا يوجد اتصال بالأنترنت !" , style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),),
            Center(
              child: Container(
                child: Lottie.asset("assets/lottie/no-internet-connection.json"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
