import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';



class Calendar extends StatefulWidget {
  const Calendar({ Key? key }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}
class _CalendarState extends State<Calendar> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.black,
    title:  Text('Todo Calender',
    style: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      color: Colors.green
     ),
    ),
   centerTitle: true,
     ),
     body:  SafeArea(
           child: TableCalendar(
            firstDay: DateTime.utc(2020,02,03),
            lastDay: DateTime.utc(2040,02,03),
            focusedDay: DateTime.now(),
            headerVisible: true,
            daysOfWeekVisible: true,
            sixWeekMonthsEnforced: true,
            shouldFillViewport: false,
            headerStyle:  HeaderStyle(
              titleTextStyle: GoogleFonts.lato(
           fontSize: 25,
           color: Colors.green,
           fontWeight: FontWeight.bold
              ),
            ),
            calendarStyle: const CalendarStyle(
         todayTextStyle: TextStyle(fontSize: 20,
         color: Colors.black,
         fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    
  }
}