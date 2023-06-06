import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myclinics/constant/constant.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../../component/component.dart';
import '../../models/userHome.dart';
import 'add_Children.dart';

class AllChildren extends StatelessWidget {
  const AllChildren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
        if(state is HomeRemoveChildrenSuss){
          if(state.verification.status =="success"){
            showTost("تم حذف الأبن بنجاح !", Colors.green);
            HomeCubit.get(context).getUser(USERID);
          }else{
            showTost("حدث خطأ !", Colors.red);
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('الأبناء' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.deepPurple)),
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
                      height: 25,
                    ),
                    ConditionalBuilder(
                        condition: cubit.userHome!.data!.children!.isNotEmpty,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ChildrenBulder(context , cubit.userHome!.data!.children![index] , cubit ,state),
                          separatorBuilder: (context, index) => SizedBox(height: 20,),
                          itemCount: cubit.userHome!.data!.children!.length,
                        ),
                        fallback: (context) => Center(
                          child: Column(
                            children: [
                              Text(
                                "لا يوجد أبناء !",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Lottie.asset("assets/lottie/empty.json"),
                            ],
                          ),
                        ),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              NavegatTo(context , Directionality(textDirection: TextDirection.rtl, child: AddChildren()));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
Widget ChildrenBulder(context , Children children ,HomeCubit cubit , HomeState state)=>
    Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
          ]),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("الأسم :- ${children.childrenName} "),
                    Text("تاريخ الميلاد : - ${children.childrenAge}"),
                    Text("الجنس :- ${children.childrenGender} "),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConditionalBuilder(
                            condition: state is! HomeRemoveChildrenLoading,
                            builder: (context) => Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  ShowDialog(
                                      context:  context,
                                      title: Text("هل انت متأكد ؟"),
                                      actions: [
                                        TextButton(onPressed: (){
                                          cubit.removeChildren(children_id: children.childrenId.toString());
                                        }, child: Text("تأكيد")),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("عودة"))
                                      ],
                                      content: Text("هل تريد حذف الأبن ؟")
                                  );
                                },
                                child: Text("حذف" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                              ),
                            ),
                            fallback: (context) => CircularProgressIndicator(),
                        )
                      ],
                    )
                  ],
                )
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );