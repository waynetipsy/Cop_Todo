import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './login.dart';
import '../custom_page_route.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);


  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>  {
  int currentPage = 0;
 final PageController _pageController =  PageController(
   initialPage: 0,
   keepPage: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
          height: MediaQuery.of(context).size.height*0.6,
          child: PageView(
            controller: _pageController,
            children: [
           onBoardPage('todonowpreview','What are your daily todos?'),
           onBoardPage('listdo', 'Here is a todo app'),
           onBoardPage('animation', 'your todo reminder')
                ],
        onPageChanged: (value) => (setCurrentPage(value)),
               ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => getIndicator(index)),
          )
            ],
          ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
       margin: const EdgeInsets.only(top: 20),
       height: 200,
       width: MediaQuery.of(context).size.width,
       decoration: const BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/stock.jpg'),
           fit: BoxFit.fill,
              ),
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: openLoginPage,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.green,
              boxShadow: [BoxShadow(
               color: Colors.black.withOpacity(0.2),
               offset: const Offset(0,9,),
               blurRadius: 20,
               spreadRadius: 3
                ),
              ],
            ),
           child:  Text('Get Started', 
           style: GoogleFonts.lato(
             fontSize: 16,
             fontWeight: FontWeight.bold,
             color: Colors.white,
           ) ,),   
          ),
          ),
       const SizedBox(height: 10,
       ),
       Text('Add your experience', 
      style: GoogleFonts.lato(
         color:  Colors.white,
         fontSize: 18,
         fontWeight: FontWeight.bold,
                 ),
               ),
              ],
             ),
           ),
          ),
        ],
       ),
     );
  }
  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: (currentPage == pageNo) ? Colors.black : Colors.green,
       ),

      );
  }

  Column onBoardPage(String img, String title) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
     const SizedBox(
        height: 20,
      ),
      Container(
        height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$img.png')
          ),
        ),
      ),
     const SizedBox(height: 50,),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
      child:  Text(
        title, 
        style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500
        ),
       ),
      ),
    Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
      child:  Text('2022 Goals on heck!!!',
       style: GoogleFonts.lato(fontSize: 16, 
       color:  Colors.black,
       fontStyle: FontStyle.italic,
       ), textAlign: TextAlign.center,
       ),
      ),
     ],
    );
  }
  setCurrentPage(int value) {
    currentPage = value;
    setState(() {
      
    });
  }
    openLoginPage () {
   Navigator.push(context, CustomPageRoute( child: const LoginPage(),
    ),
   );   
  }
}