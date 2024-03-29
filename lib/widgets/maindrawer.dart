import 'package:flutter/material.dart';
import 'custom_page_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cop_todo/widgets/logout.dart';
import '../pages/homepage.dart';

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
                  child : HomePage(),
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
          showAboutDialog(context: context,
          applicationLegalese: 'This is a task management app that helps you write, organize, and prioritize your tasks more efficiently and manage your day-to-day todo tasks.',
          applicationName: 'Cop Todo'
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

        const SizedBox(height: 25),

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
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}