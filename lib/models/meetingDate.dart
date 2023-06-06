import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDateSource extends CalendarDataSource{
  MeetingDateSource(List<Appointment> source){
    appointments=source;
  }
}