import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../component/component.dart';
import '../../models/userHome.dart';
import 'doctor_info.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
        if(state is HomeDeleteFavSuss){
          if(state.verification.status=="success"){
            showTost("تم الألغاء بنجاح", Colors.green);
            HomeCubit.get(context).getUser(USERID.toString());
            HomeCubit.get(context).currentIndex = 0 ;
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.getFav() ;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المفضل' , style:  TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ConditionalBuilder(
                      condition: state is! GetFavLoading,
                      builder: (context) => ConditionalBuilder(
                          condition: cubit.favorites.isNotEmpty,
                          builder: (context) =>  ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.favorites.length,
                            itemBuilder: (context, index) => SearchResult(context , cubit.favorites[index] , state) ,
                            separatorBuilder: (context, index) => SizedBox( height: 30,),
                          ),
                          fallback: (context) => Column(
                            children: [
                              Text("لا توجد نتائج !" , style: TextStyle(fontSize: 25 , color: Colors.black54 , fontWeight: FontWeight.bold),),
                              Lottie.asset("assets/lottie/empty.json"),
                            ],
                          )
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator(),),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget SearchResult (context , Doctor doctors , HomeState state)=> InkWell(
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

              ),
              IconButton(onPressed: (){
                HomeCubit.get(context).deleteFav(user_id: USERID.toString(), doctor_id: doctors.doctorId.toString());
              }, icon: Icon(Icons.favorite ,color: Colors.red,)),
            ],
          ),

        )

    ),

  ),
);
