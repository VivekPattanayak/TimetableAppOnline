import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_online/Pages/time_table.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tt_online/Pages/conditional_tt.dart';
import 'package:tt_online/Pages/login.dart';

class hol_unit{
  String? name;
  DateTime? dt;
  hol_unit(String a,DateTime b) {
    this.name = a;
    this.dt = b;
  }
}

class Register extends StatefulWidget {
  static final DateTime now = DateTime.now();
  static final DateFormat f1 = DateFormat('EEEE');
  static final DateFormat f2 = DateFormat('d MMM y');
  static final DateFormat f3 = DateFormat('MMM');
  static final DateFormat hol_format = DateFormat('d MMM');

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Only modify these lines to change the timetable according to your needs
  final List<String> mon= ['9:00AM-11:50AM ➔ Mobile Int Lab','12:00PM-12:50PM ➔ Biz Comm','❖','1:30PM-2:20PM ➔ Graph Theory'];

  final List<String> tue= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ Biz Comm','11:00AM-11:50AM ➔ Constitution','12:00PM-12:50PM ➔ ML','❖','1:30PM-2:20PM ➔ Comp Grp','2:30PM-3:20PM ➔ Compiler Dsgn'];

  final List<String> wed= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ ML','11:00AM-11:50AM ➔ Comp Grp','12:00PM-12:50PM ➔ Constitution','❖','1:30PM-4:20PM ➔ Comp Des Lab'];

  final List<String> thu= ['9:00AM-11:50AM ➔ Graphics Lab','12:00PM-12:50PM ➔ Comp Grp','❖','1:30PM-2:20PM ➔ Graph Theory','2:30PM-3:20PM ➔ Compiler Dsgn'];

  final List<String> fri= ['9:00AM-9:50AM ➔ OE-2','10:00AM-10:50AM ➔ Graph Theory','11:00AM-11:50AM ➔ ML','12:00PM-12:50PM ➔ Compiler Dsgn','❖','1:30PM-4:20PM ➔ ML Lab'];

  //final List<String> sat= [''];
  final List<hol_unit> hol=[
  ];

  final String curr_day = Register.f1.format(Register.now);

  final String mon_dt = Register.f2.format(Register.now);

  final String Mon_name  = Register.f3.format(Register.now);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  //
  void scrollbymon(){
    final position = _scrollController.position.minScrollExtent;
    int a=0;
    //currently scrolling to nearest hol by month
    for ( var it in hol){
      if(it.dt!.isAfter(Register.now)){
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

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeItems();
    print("State Initializsed successfully!");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    //super.dispose();
  }

  String userFeedback='';

  void updateUserFeedback(msg){
    print(msg);
    setState(() {
      userFeedback = msg;
    });
  }

  String classId = 'Select class ID';

  var items = ['Select class ID'];

  void initializeItems(){
    FirebaseFirestore.instance.collection("class").get().then((res) {
      var tempItems = ['Select class ID'];
      for(var it in res.docs){
        tempItems.add(it.id);
      }
      print(tempItems);
      setState(() {
        items=tempItems;
      });
    });
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
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 160,
              ),
              Text('Register',style:TextStyle(color: Colors.white, fontSize: 28 ),textAlign: TextAlign.center),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 30, left: 30),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    icon: new Icon(Icons.person,color:Colors.blue),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ) ,

              Container(
                margin: const EdgeInsets.only(right: 30, left: 30),
                child: new TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    icon: new Icon(Icons.password,color:Colors.white54),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ) ,

              Container(
                margin: const EdgeInsets.only(right: 38, left: 70),
                  child: DropdownButton(
                    // Initial Value
                    value: classId,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        classId = newValue!;
                      });
                    },
                  )
              ),

              Padding(
                padding: EdgeInsets.all(25), //apply padding to all four sides
                child: new Text(userFeedback,style:TextStyle(color: Colors.white),textAlign: TextAlign.center),
              ),

              Container(
              margin: const EdgeInsets.only(right: 80, left: 80),
              child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.blueGrey;
                          return null; // Defer to the widget's default.
                        }),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance.collection("users").where("username",isEqualTo: userNameController.text).get().then((res) {
                      print('Class id is : $classId');
                      if(res.size>0){
                        updateUserFeedback('User already exists! Please try a different username');
                      }
                      else{
                        if(userNameController.text.length==0){
                          updateUserFeedback('Blank username or password!');
                        }
                        else if(passwordController.text.length<5){
                          updateUserFeedback('Password must have minimum 5 characters!');
                        }
                        else{
                          FirebaseFirestore.instance.collection("users").add(
                              {
                                'username' : userNameController.text,
                                'password' : passwordController.text,
                                'classId' : classId
                              }
                          ).then((res)=> {
                            updateUserFeedback('New user added! Go to login page and enter credentials!')
                          }
                          );
                        }
                      }
                    });
                  },
                  child: Text('Register'),
                )
              ),

              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => Login(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          )
                },
                child: Text('Back to Login'),
              )

            ],

          ),
        ),
        drawer:
        Container(
          width: 250,
          child:Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: Image.asset('assets/images/psychedelic_triangle.gif',width: 180, height: 180),
                ),
                Container(
                  color: Color(0x58809fff),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                  height: 80, //wraps child's height
                  child: Text('About' , style:TextStyle(color: Colors.white, fontSize: 28 ) ,textAlign: TextAlign.center),
                ),
                ListTile(
                  title: Text('\nApp Developed by\n🤖',style: TextStyle(fontSize: 15),textAlign: TextAlign.center),
                  subtitle: Text('Vivek Pattanayak\nCSE K19',style: TextStyle(fontSize: 15),textAlign: TextAlign.center),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    //Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () => launch('https://github.com/VivekPattanayak'),
                  child:Image.asset(
                    'assets/images/Github_logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () => launch('https://www.linkedin.com/in/vivek-pattanayak-8225021a0'),
                  child:Image.asset(
                    'assets/images/Linkedin_logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}