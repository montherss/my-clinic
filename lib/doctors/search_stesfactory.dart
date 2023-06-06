import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';

import '../component/component.dart';
import '../constant/constant.dart';
import '../models/doctorHome.dart';

class SearchSatisfactoryRecord extends StatelessWidget {
  const SearchSatisfactoryRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit , DoctorsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('البحث عن مريض' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple),),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.searchUser = [] ;
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
                      labelText: 'رقم هاتف المريض' ,
                      hintText: 'الرجاء ادخال رقم الهاتف' ,
                      prefixIcon: Icon(Icons.search) ,
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        if(value.isEmpty){
                          cubit.searchUser = [] ;
                          //cubit.searchDoctors=[];
                        }
                        cubit.searchUserPhone(value);
                        //cubit.searchDoctor(value);
                      }
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ConditionalBuilder(
                      condition: cubit.searchUser.isNotEmpty,
                      builder:(context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SearchUser(context , cubit.searchUser[index]),
                        separatorBuilder: (context, index) => SizedBox(height: 20,),
                        itemCount:cubit.searchUser.length ,
                      ),
                      fallback: (context) => Column(
                        children: [
                          Text("لا توجد نتائج !" , style: TextStyle(fontSize: 25 , color: Colors.black54 , fontWeight: FontWeight.bold),),
                          Lottie.asset("assets/lottie/empty.json"),
                        ],
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }
}

Widget SearchUser(context , Satisfactoryrecord user)=> Container(
  padding: EdgeInsets.symmetric(vertical: 5),
  decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2
        )
      ]
  ),
  child: SizedBox(
    width: MediaQuery
        .of(context)
        .size
        .width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            title: Text(
              'اسم المريض :- ${user.userName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تاريخ الميلاد : - ${user.userAge}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('رقم الهاتف :-  ${user.userPhoneNumber}'),
                    TextButton(onPressed: (){
                      //cubit.callNumber(users.user_phoneNumber.toString());
                    }, child: Row(
                      children: [
                        Text('اتصل الأن'),
                        SizedBox(width: 5,),
                        Icon(Icons.phone),
                      ],
                    )
                    )
                  ],
                ),
                Text('البريد الألكتروني :-   ${user.userEmail}')
              ],
            )
        ),
        user.satisfactoRyrecordStatus==1?
        InteractiveViewer(
          clipBehavior: Clip.none,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: "${IMAGE_SATISFACTORY}/${user.satisfactoryrecordImage}",
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: NetworkImage("${IMAGE_SATISFACTORY}/${user.satisfactoryrecordImage}") ,)
                ),
              ),
            ),
          ),
        ):
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المعاينة : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                '${user.satisfactoRyrecordInspection}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  height: 20,
                ),
              ),
              Text(
                'الأدوية الموصوفة : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                '${user.satisfactoRyrecordPharmaceutical}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  height: 20,
                ),
              ),
              Text(
                'الملاحظات : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                '${user.satisfactoRyrecordNotes}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_outlined,
                    color: Colors.black54,),
                  SizedBox(width: 5,),
                  Text(
                    '${user.satisfactoRyrecordDate}',
                    style: TextStyle(
                        color: Colors.black54
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                        color: Colors.black54,),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${user.satisfactoRyrecordTime}',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  ),
);