import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tt_online/Pages/conditional_tt.dart';
import 'package:tt_online/Pages/login.dart';

class DrawerSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color.fromRGBO(241, 84, 84, 0.4);
                      return null; // Defer to the widget's default.
                    }),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Login(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(25), //apply padding to all four sides
                child: new Text('Log Out   [<-',style:TextStyle( color: Color(0xFF84f6c8), fontSize: 18),textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }
}