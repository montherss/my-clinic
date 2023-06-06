import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

import '../models/news.dart';


class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<HomeCubit,HomeState>(
     listener: (context, state) {
     },
     builder: (context, state) {
       HomeCubit cubit = HomeCubit.get(context);
       return Scaffold(
           body:SafeArea(
             child: SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Padding(
                 padding: const EdgeInsets.all(20),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text(
                           'الأخبار' , style:  TextStyle(
                           fontSize: 30,
                           color: Colors.deepPurple,
                           fontWeight: FontWeight.w500,
                         ),
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 40,
                     ),
                     ListView.separated(
                       physics: BouncingScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index) => NewsBulder(cubit.news!.articles![index] , cubit),
                       separatorBuilder: (context, index) => SizedBox(height: 20,),
                       itemCount: cubit.news!.articles!.length,
                     )
                   ],
                 ),
               ),
             ),
           )
       );
     },
   );
  }
}
Widget NewsBulder(Articles news , HomeCubit cubit)=> InkWell(
  onTap: (){
    cubit.UrlLancher("${news.url}");
  },
  child:   Container(

    padding: EdgeInsets.symmetric(vertical: 5),

    decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(10),

        boxShadow: [

          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)

        ]),

    child: Row(

      children: [

        Container(

          height: 100,

          width: 100,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage("${news.urlToImage==null?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKFnl9yM1QbkjB63EvlE5eqtVl7E2IgGiJCA&usqp=CAU":news.urlToImage}"),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(

          width: 10,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text("${news.title}" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , maxLines: 2 , overflow: TextOverflow.ellipsis,),

              Text("${news.publishedAt}"),

            ],

          ),

        )

      ],

    ),

  ),
);