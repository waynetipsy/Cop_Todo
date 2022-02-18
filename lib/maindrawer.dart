import 'package:flutter/material.dart';
import './custom_page_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_todo/calendar.dart';
import 'package:login_todo/logout.dart';
import './pages/homepage.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
       const DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/stock.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child:  Text('.',
          style: TextStyle(color: Colors.grey) ,
          ),
              ),
            
        const SizedBox(
          height: 30.0,
        ),
        ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(CustomPageRoute(
                  child : const HomePage(),
                  ),
              );
            },
            leading: const Icon(
              FontAwesomeIcons.home,
              size: 25,
              color: Colors.green,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        const  SizedBox(height: 25),
       ListTile(
            onTap: () {
               Navigator.of(context).pop();
              Navigator.of(context).push(
                CustomPageRoute(
                  child : const Calendar(),
                  ),
              );
            },
            leading: const Icon(
              FontAwesomeIcons.calendar,
              size: 25,
              color: Colors.green,
            ),
            title: const Text(
              'Calender',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
         const SizedBox(height: 40),
           ListTile(
            onTap: () {
           showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LogOut(),
          ).then((value) {
            setState(() {});
          });

            },
            leading: const Icon(
              FontAwesomeIcons.signOutAlt,
              size: 25,
              color: Colors.green,
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
       const  SizedBox(height: 30.0),
        ListTile(
          onTap: () {
          showAboutDialog(context: context,
          applicationIcon: const FlutterLogo(),
          applicationLegalese: 'This is a task management app to help you stay organized and manage your day-to-day todo task.',
          applicationName: 'Todo Note App'
           );
          },
          leading: const Icon(
            Icons.info,
            size: 25,
            color: Colors.green,
          ),
          title: const Text(
            'About App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}