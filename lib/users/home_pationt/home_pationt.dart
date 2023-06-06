import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';

import 'package:myclinics/models/doctors.dart';
import 'package:myclinics/users/home_pationt/doctor_info.dart';
import 'package:myclinics/users/home_pationt/seatch_doctor.dart';
import 'package:myclinics/users/home_pationt/state_screen.dart';

import '../../constant/constant.dart';
import '../../models/userHome.dart';
import '../cubit/home_cubit.dart';
import 'schedule/notification _screen.dart';

class HomePationtScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return  BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
        if(state is HomeAddFavSuss){
          if(state.verification.status == "success"){
            showTost("تم الأضافة بنجاح", Colors.green);
            HomeCubit.get(context).getUser(USERID.toString());
          }
        }
        else if (state is HomeDeleteFavSuss){
          if(state.verification.status == "success"){
            showTost("تم الألغاء بنجاح", Colors.green);
            HomeCubit.get(context).getUser(USERID.toString());
          }
        }
      },
      builder: (context, state) {
        cubit.getAllDoctors();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مرحبا ${cubit.userHome!.data!.user![0].userName}' , style:  TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage('https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1684071055~exp=1684071655~hmac=e94baaec74e63fd5a3fcc6d16d102c143115d675cde11820d155f8c6821ad88c'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                           onTap: (){
                             NavegatTo(context,Directionality(textDirection: TextDirection.rtl, child:  SearchDoctors()));
                           },
                             child: Icon(FontAwesomeIcons.search, color: Colors.deepPurple , size: 30,)),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: NotificationScreen()));
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Icon(FontAwesomeIcons.bell , size: 35,color: Colors.deepPurple,),
                                 if(notificatioNUser?.notification?.length!=null && notificatioNUser!.notification!.isNotEmpty)
                                    CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 10,
                                    child: Text("${notificatioNUser!.notification!.length>9?"+9":notificatioNUser!.notification!.length}",style: TextStyle(color: Colors.white , fontSize: 10 , fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SliderBuilder(cubit.userHome!),

                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'ما هي المحافظة ؟ ' , style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.State.length,
                      itemBuilder: (context, index) =>StateBulider( cubit,cubit.State[index] , index),
                    ),
                  ),
                   //
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButton(
                      isExpanded: true,
                      hint: Text(cubit.specialization),
                      items: cubit.specializations.map((e) =>
                          DropdownMenuItem<String>(
                              value: e,
                              child: Align(
                                alignment:  Alignment.centerRight,
                                child: Text(
                                  '${e}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          )
                      ).toList(),
                      value: cubit.value,
                      onChanged: (value){
                        cubit.Drop_Down_item(value!);
                        cubit.sortSpecializationDoctorLists(value);
                      }
                  ),
                  if(cubit.root ==1 && state is! HomeSortDoctor && state is! HomeSortDoctorSpecialization)
                    GridViewBuilder(context , cubit.doctorNewList , state),
                  if(state is HomeSortDoctor && cubit.sortedDoctorLit.isNotEmpty)
                    GridViewBuilder(context , cubit.sortedDoctorLit , state),
                  if(cubit.sortedDoctorLit.isEmpty && state is HomeSortDoctor )
                    Center(
                      child: Text(
                        'لا توجد نتائج' ,style: TextStyle(
                          fontWeight: FontWeight.bold ,
                          fontSize: 20,
                          color: Colors.black54
                      ),
                      ),
                    ),
                  if(state is HomeSortDoctorSpecialization && cubit.sortedDoctorListSpecilization.isNotEmpty)
                    GridViewBuilder(context , cubit.sortedDoctorListSpecilization , state),
                  if(cubit.sortedDoctorListSpecilization.isEmpty && state is HomeSortDoctorSpecialization)
                    Center(
                      child: Text(
                        'لا توجد نتائج' ,style: TextStyle(
                          fontWeight: FontWeight.bold ,
                          fontSize: 20,
                          color: Colors.black54
                      ),
                      ),
                    ),
                 // if(state is HomeSortDoctor)
                  //  GridViewBuilder(context,cubit.sortedDoctorLit),
                 // if(state is! HomeSortDoctor)
                  //  GridViewBuilder(context,cubit.sortedDoctorListSpecilization),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget StateBulider(HomeCubit cubit,String state , int index)=>
    InkWell(
      onTap: (){
        cubit.sortStateDoctorLists(state);
        cubit.selectedState(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color:cubit.stateSelected == index ?Colors.deepPurple : Colors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${state}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
Widget DoctorBulider( context,Doctor moduls , HomeState state)=>
    InkWell(
      onTap: (){
        NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: DoctorInfo(moduls)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: '${moduls.doctorImageUrl}',
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('${moduls.doctorImageUrl}'),
                  ),
                ),
                Text(
                  '${moduls.doctorName}' , maxLines: 1  , overflow: TextOverflow.ellipsis , style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                ),
                Text(
                  '${moduls.doctorSpecialization}', maxLines: 1 , overflow: TextOverflow.ellipsis , style: TextStyle(
                  color: Colors.black54,
                ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConditionalBuilder(
                        condition: state is! HomeDeleteFavLoading || state is! HomeAddFavLoading,
                        builder: (context) =>  IconButton(onPressed: (){
                          if(moduls.favourtie==1){
                            HomeCubit.get(context).deleteFav(user_id: USERID.toString(), doctor_id: moduls.doctorId.toString());
                          }else{
                            HomeCubit.get(context).addFav(user_id: USERID.toString(), doctor_id: moduls.doctorId.toString());
                          }
                        }, icon: moduls.favourtie==1? Icon(Icons.favorite , color: Colors.red,) : Icon(Icons.favorite_border) ),
                        fallback: (context) => CircularProgressIndicator(),
                    ),
                    SizedBox(width: 5,),
                    Text('${moduls.doctorRate}', ),
                    Icon(
                      Icons.star ,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5,
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
Widget GridViewBuilder(context,List<Doctor> moduls , HomeState state ){
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1/1.1,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(moduls.length, (index) => AnimationConfiguration.staggeredList(
          duration: Duration(milliseconds: 1000),
            position: index,
            child: ScaleAnimation(child: DoctorBulider(context,moduls[index], state)))),
      ),
    );}

Widget SliderBuilder(UserHome model)=>
    CarouselSlider(
        items: model.data!.bannel!.map((e) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  print(e.bannelImadeId);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage("${IMAGE_BANNER}/${e.bannelImadeName}"), fit: BoxFit.cover,))
                  ),
              ),
                 // child: Image(image: NetworkImage("${IMAGE}/${e.bannelImadeName}"),width: double.infinity , fit: BoxFit.cover,)),
            )
        ).toList(),
        options: CarouselOptions(
          height: 250,
          initialPage: 0,
          enableInfiniteScroll: true ,
          viewportFraction: 1,
          reverse: false ,
          autoPlay: true ,
          autoPlayAnimationDuration: Duration(seconds: 3),
          autoPlayInterval: Duration(seconds: 5),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
    );