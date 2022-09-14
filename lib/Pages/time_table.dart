import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tt_online/Pages/conditional_tt.dart';
import 'package:tt_online/Components/drawer_side.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TimeTable extends StatefulWidget {
  String userName,classId;
  TimeTable({Key? key,required this.userName,required this.classId}) : super(key: key);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('EEEE');

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final String curr_day = TimeTable.formatter.format(TimeTable.now);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Color day_color(day_given){
    if(day_given==curr_day){
      return Color(0xFF84f6c8);
    }
    return Color(0xFF809fff);
  }

  final List<String> mon= [];
  final List<String> tue= [];
  final List<String> wed= [];
  final List<String> thu= [];
  final List<String> fri= [];
  final List<String> sat= [];

  void getAllRoutines(){
    FirebaseFirestore.instance.collection('class/'+widget.classId+'/classes').get().then((res) {
      String sMon='\n',sTue='\n',sWed='\n',sThu='\n',sFri='\n';
      for(var obj in res.docs){
            obj.data().forEach((key, value) {
                 if(obj.id=='monday'){
                   sMon = sMon+value+'\n';
                 }
                 else if(obj.id=='tuesday'){
                   sTue = sTue+value+'\n';
                 }
                 else if(obj.id=='wednesday'){
                   sWed = sWed+value+'\n';
                 }
                 else if(obj.id=='thursday'){
                   sThu = sThu+value+'\n';
                 }
                 else if(obj.id=='friday'){
                   sFri = sFri+value+'\n';
                 }
            });
          }
          mon.add(sMon); tue.add(sTue); wed.add(sWed); thu.add(sThu); fri.add(sFri);
          setState(() {
            mon; tue; wed; thu; fri;
          });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRoutines();
  }

  @override
  Widget build(BuildContext context) {
    //Only modify these lines to change the timetable according to your needs
    //_________________________________________________________________________________________________________________________________
    //Do not try to implement them as separate elements, as the space between subjects will not be compact if done in that manner
    //_________________________________________________________________________________________________________________________________
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
          title: Text('Timetable'),
          leading: new IconButton(
              icon: new Icon(Icons.info,color:Color(0xFFB6B2B8),),
              color: Color(0xFF1f1f1f),
              onPressed: () => _scaffoldKey.currentState!.openDrawer()),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Center(
                child: Container(
                  width: 290,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0,0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child : ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Text('Monday',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: day_color('Monday'),fontSize: 21)),
                          Container(
                            child: ListView.builder(
                              itemCount: mon.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true ,
                              itemBuilder: (context, index) => ListTile(
                                title: Text('${mon[index]}',textAlign: TextAlign.center,style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 290,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0,0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child : ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Text('Tuesday',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: day_color('Tuesday'),fontSize: 21)),
                          Container(
                            child: ListView.builder(
                              itemCount: tue.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true ,
                              itemBuilder: (context, index) => ListTile(
                                title: Text('${tue[index]}',textAlign: TextAlign.center,style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 290,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0,0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child : ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Text('Wednesday',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: day_color('Wednesday'),fontSize: 21)),
                          Container(
                            child: ListView.builder(
                              itemCount: wed.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true ,
                              itemBuilder: (context, index) => ListTile(
                                title: Text('${wed[index]}',textAlign: TextAlign.center,style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 290,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0,0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child : ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Text('Thursday',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: day_color('Thursday'),fontSize: 21)),
                          Container(
                            child: ListView.builder(
                              itemCount: thu.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true ,
                              itemBuilder: (context, index) => ListTile(
                                title: Text('${thu[index]}',textAlign: TextAlign.center,style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 290,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0,0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child : ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Text('Friday',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: day_color('Friday'),fontSize: 21)),
                          Container(
                            child: ListView.builder(
                              itemCount: fri.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true ,
                              itemBuilder: (context, index) => ListTile(
                                title: Text('${fri[index]}',textAlign: TextAlign.center,style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],

          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => CTT(userName:widget.userName,classId: widget.classId),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          child: Icon(Icons.north_west,color:Color(0xFF000000),),
          backgroundColor: Color(0xFF809fff),
        ),
        drawer: DrawerSide()

      ),
    );
  }
}