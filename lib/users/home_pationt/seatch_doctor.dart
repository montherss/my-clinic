import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/models/userHome.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../component/component.dart';
import 'doctor_info.dart';

class SearchDoctors extends StatelessWidget {
  const SearchDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'البحث', style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple
                        ),
                        ),
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFeild(
                      labelText: 'اسم الطبيب' ,
                      hintText: 'الرجاء ادخال اسم الطبيب' ,
                      prefixIcon: Icon(Icons.search) ,
                      keyboardType: TextInputType.name,
                      onChanged: (value){
                        if(value.isEmpty){
                          cubit.searchDoctors=[];
                        }
                        cubit.searchDoctor(value);
                      }
                    ),
                    SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: cubit.searchDoctors.isNotEmpty,
                        builder: (context) =>  ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.searchDoctors.length,
                          itemBuilder: (context, index) => SearchResult(context , cubit.searchDoctors[index]) ,
                          separatorBuilder: (context, index) => SizedBox( height: 30,child: Divider(color: Colors.grey , thickness: 2,)),
                        ),
                        fallback: (context) => Column(
                          children: [
                            Text("لا توجد نتائج !" , style: TextStyle(fontSize: 25 , color: Colors.black54 , fontWeight: FontWeight.bold),),
                            Lottie.asset("assets/lottie/empty.json"),
                          ],
                        )
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
Widget SearchResult (context , Doctor doctors)=> InkWell(
  onTap: (){
    NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: DoctorInfo(doctors)));
  },
  child:   Container(

    padding: EdgeInsets.symmetric(vertical: 5),

    decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(10),

        boxShadow: [

          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)

        ]),

    child: SizedBox(

        width: MediaQuery.of(context).size.width,

        child: Padding(

          padding: const EdgeInsets.all(8.0),

          child: Row(

            children: [

              Hero(
                tag: "${doctors.doctorImageUrl}",
                child: CircleAvatar(

                  radius: 45,

                  backgroundImage: NetworkImage("${doctors.doctorImageUrl}"),

                ),
              ),

              SizedBox(width: 10,),

              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text('${doctors.doctorName}' , style: TextStyle(fontSize: 20 , color: Colors.deepPurple , fontWeight: FontWeight.bold), maxLines: 1 , overflow: TextOverflow.ellipsis,),

                    Text('${doctors.doctorSpecialization} , ${doctors.doctorState}' , style: TextStyle(color: Colors.black54 , ),)

                  ],

                ),

              )

            ],

          ),

        )

    ),

  ),
);
