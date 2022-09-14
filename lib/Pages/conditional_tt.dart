import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_online/Components/drawer_side.dart';
import 'package:tt_online/Pages/time_table.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tt_online/Pages/login.dart';

class hol_unit{
  String? name;
  DateTime? dt;
  hol_unit(String a,DateTime b) {
    this.name = a;
    this.dt = b;
  }
}

class CTT extends StatelessWidget {
  String userName,classId;
  CTT({Key? key,required this.userName,required this.classId}) : super(key: key);
  //Only modify these lines to change the timetable according to your needs
  //start_________________________________________________________________________________________________________________________________
  final List<String> mon= ['9:00AM-9:50AM ➔ Mobile Int Lab','12:00PM-12:50PM ➔ Biz Comm','❖','1:30PM-2:20PM ➔ Graph Theory'];
  final List<String> tue= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ Biz Comm','11:00AM-11:50AM ➔ Constitution','12:00PM-12:50PM ➔ ML','❖','1:30PM-2:20PM ➔ Comp Grp','2:30PM-3:20PM ➔ Compiler Dsgn'];
  final List<String> wed= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ ML','11:00AM-11:50AM ➔ Comp Grp','12:00PM-12:50PM ➔ Constitution','❖','1:30PM-4:20PM ➔ Comp Des Lab'];
  final List<String> thu= ['9:00AM-11:50AM ➔ Graphics Lab','12:00PM-12:50PM ➔ Comp Grp','❖','1:30PM-2:20PM ➔ Graph Theory','2:30PM-3:20PM ➔ Compiler Dsgn'];
  final List<String> fri= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ Graph Theory','11:00AM-11:50AM ➔ ML','12:00PM-12:50PM ➔ Compiler Dsgn','❖','1:30PM-4:20PM ➔ ML Lab'];
  //final List<String> sat= [''];

  final List<hol_unit> hol=[
  ];
  //end_________________________________________________________________________________________________________________________________

  static final DateTime now = DateTime.now();
  static final DateFormat f1 = DateFormat('EEEE');
  final String curr_day = f1.format(now);
  static final DateFormat f2 = DateFormat('d MMM y');
  final String mon_dt = f2.format(now);
  static final DateFormat f3 = DateFormat('MMM');
  final String Mon_name  = f3.format(now);
  static final DateFormat hol_format = DateFormat('d MMM');


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  void scrollbymon(){
    final position = _scrollController.position.minScrollExtent;
    int a=0;
    //currently scrolling to nearest hol by month
    for ( var it in hol){
      if(it.dt!.isAfter(now)){
        break;
      }
      a=a+200;
    };
    //formula for a: no of hol before this month x 200
    _scrollController.animateTo(
      position+a,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        backgroundColor: const Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        fontFamily: 'ProductSans',
        brightness: Brightness.dark,
      ),
      title: 'BIT Timetable',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Timetable [ $classId ]'),
          leading: new IconButton(
              icon: new Icon(Icons.info,color:Color(0xFFB6B2B8),),
              color: Color(0xFF1f1f1f),
              onPressed: () => _scaffoldKey.currentState?.openDrawer()),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text('${curr_day}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Sherlyn',color: Color(0xFF809fff),fontSize: 85)),
              ),
              SizedBox(
                height: 10,
              ),
              //This is from a plugin, so commands are from the documentation

              Text('${mon_dt}',textAlign:TextAlign.center,style:TextStyle( fontSize:15,color: Colors.white)),

              SizedBox(
                height: 10,
              ),

              DigitalClock(
                is24HourTimeFormat: false,
                showSecondsDigit : false,
                hourMinuteDigitDecoration : BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(0)
                ),
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 24,
                ),
                amPmDigitTextStyle: TextStyle(color: Color(0xFF809fff),fontSize:13, fontWeight: FontWeight.bold),
              ),
              Text('_________________',textAlign: TextAlign.center,style: TextStyle(color:Color(0xFF4d4d4d),fontSize: 20)),


              SizedBox(
                height: 30,
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('class/$classId/classes').doc(curr_day.toLowerCase()).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    var output = snapshot.data!.data();
                    String finalOutput='';
                    output!.forEach((key, value) {finalOutput=finalOutput+value+'\n\n';});
                    return Text(finalOutput,style: TextStyle(fontSize: 21),textAlign: TextAlign.center,);
                  }
                  else{
                    return Text('No classes scheduled',style: TextStyle(fontSize: 21),textAlign: TextAlign.center,);
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
              Text('_________________',textAlign: TextAlign.center,style: TextStyle(color:Color(0xFF4d4d4d),fontSize: 20)),

              SizedBox(
                height: 55,
              ) ,

            ],

          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => TimeTable(userName: userName,classId: classId),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          child: Icon(Icons.sort_sharp,color:Color(0xFF000000),),
          backgroundColor: Color(0xFF809fff),
        ),
        drawer: DrawerSide()

      ),
    );
  }
}