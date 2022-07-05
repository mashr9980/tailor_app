import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/table_utils.dart';
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }
  LogoutBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const SizedBox(height: 20,),
                    Text("Logout".tr,textDirection: text_direction,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Text("Are_You_Sure".tr,textDirection: text_direction,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(

                          onTap:(){
                            Get.back();
                          },
                          child: Container(
                            width:  80,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.red,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child:Text(
                                "back".tr,
                                style: const TextStyle(color: buttoncolor,fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(

                          onTap:(){
                            Get.to(const SiginPage());
                          },
                          child: Container(
                            width:  80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Logout".tr,
                                textDirection: text_direction,
                                style: const TextStyle(color: Colors.white,fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //ok Google Map logo

                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }
  var lan=GetStorage();
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(

      textDirection:text_direction,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            actions: [
              Container(
                  padding: const EdgeInsets.all(5),
                  height: 35,
                  child: Image.asset(
                    logo_png,
                    height: 20,
                  )),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  icon_setting,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  icon_bell,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  logo_whatsapp,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  LogoutBox();
                },
                child: Image.asset(
                  icon_logout,
                  height: 35,
                  width: 35,
                ),
              ),
            ],
            toolbarHeight: 40,
            iconTheme: const IconThemeData(color: iconscolor),
            centerTitle: false,
            backgroundColor: APPBARCOLOR,
            title: Text(
              "Manage_Events".tr,
              textDirection: text_direction,
              style: appbartext,
            ),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar<Event>(
                headerStyle: HeaderStyle(

                  decoration: const BoxDecoration(
                    color: buttoncolor,
                  ),
                  titleTextStyle: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                  titleCentered: true,
                  headerPadding: const EdgeInsets.all(5),
                  leftChevronIcon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                  rightChevronIcon: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,) ,
                  formatButtonTextStyle: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)
                  )

                ),

                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    return Text('${events.length}',style: TextStyle(color: date.millisecondsSinceEpoch<DateTime.now().millisecondsSinceEpoch
                        ?  Colors.red
                        : Colors.green,fontSize: 12));                  // text: ',// color: ;
                  },
                ),
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  // canMarkersOverflow: true,
                  isTodayHighlighted: false,
                  markerSize: 20,
                  cellMargin: const EdgeInsets.all(5),
                  defaultTextStyle: const TextStyle(fontSize: 16),
                  tableBorder: TableBorder.all(color: const Color(0XFFC1C1C1)),
                  holidayTextStyle: const TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),
                  weekendTextStyle: const TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),
                  // defaultDecoration: BoxDecoration(
                  //   color: Colors.green
                  // ),
                  // outsideDecoration: BoxDecoration(
                  //   color: Colors.green
                  // ),
                  // rowDecoration:BoxDecoration(
                  //    color: Colors.green
                  //        ),
                  markersAnchor: 5,
                  markerMargin: const EdgeInsets.all(5),
                  markerSizeScale: 15,
                  // markerDecoration: BoxDecoration(color: Colors.red),
                  // Use `CalendarStyle` to customize the UI
                  outsideDaysVisible: true,
                ),
                daysOfWeekStyle:const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: buttoncolor,fontSize: 16,fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),
                ),
                rowHeight: 50,

                daysOfWeekHeight: 30,
                pageAnimationEnabled: true,
                onDaySelected: _onDaySelected,
                // onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 8.0),
              Container(
                margin: const EdgeInsets.only(top: 20),
                // color: Colors.red,
                height: 300,
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child:value[index]==0?Container(
                            height: 200,
                            child: Text("NoEventScheduleforThisDate".tr,textDirection: text_direction,style: TextStyle(color:buttoncolor,fontSize: 30,fontWeight: FontWeight.bold),),
                          ): ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
