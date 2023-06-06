import 'package:flutter/material.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/doctors/cubit_doctors/doctors_cubit.dart';
import 'package:myclinics/doctors/search_stesfactory.dart';
import 'package:myclinics/models/doctors_chart.dart';
import 'package:myclinics/models/meetingDate.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constant/constant.dart';

class HomeScreenDoctors extends StatelessWidget {
  const HomeScreenDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DoctorsCubit cubit = DoctorsCubit.get(context);

    late TooltipBehavior tooltipBehavior = (TooltipBehavior(enable: true)) ;
    cubit.getDataAndCalendarShart();
    cubit.getSorceCalendar() ;
     return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('مرحبا ${cubit.doctorHome!.data!.doctor![0].doctorName}' , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),maxLines: 2 , overflow: TextOverflow.ellipsis,)),
                    Spacer(),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('${cubit.doctorHome!.data!.doctor![0].doctorImageUrl}'),
                    ),
                    SizedBox(width: 20,),
                    IconButton(onPressed: (){
                      NavegatTo(context, Directionality(textDirection: TextDirection.rtl, child: SearchSatisfactoryRecord()));
                    }, icon: Icon(Icons.search , size: 40, color: Colors.deepPurple,))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SfCircularChart(
                  tooltipBehavior: tooltipBehavior,
                  title: ChartTitle(text: 'مؤشر المواعيد' , textStyle: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold , fontFamily: 'jannah')),
                  legend: Legend(isVisible: true , overflowMode: LegendItemOverflowMode.wrap),
                  series: <CircularSeries>[
                  PieSeries<DoctorsChart , String>(
                  dataSource: cubit.Chart,
                    xValueMapper: (DoctorsChart data,_)=> data.states ,
                    yValueMapper: (DoctorsChart data ,_) => data.number ,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    enableTooltip: true,
                  )
                ],
                ),
                SizedBox(
                  height: 10,
                  child: Divider(
                    height: 10,
                    thickness: 2,
                  ),
                ),
                Center(child: Text('جدول المواعيد' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 10,
                ),
                SfCalendar(
                  appointmentTextStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'jannah',
                  ),
                  view: CalendarView.week,
                  firstDayOfWeek: 6,
                  dataSource: MeetingDateSource(cubit.meetings),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
