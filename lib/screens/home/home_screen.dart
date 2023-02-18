import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notification/config/themes.dart';
import 'package:notification/services/theme_service.dart';
import 'package:notification/widgets/widgets.dart';
import 'package:date_picker_timeline_fixed/date_picker_timeline_fixed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName='/';
  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: HomeScreen.routeName),
      builder: (_)=>HomeScreen());
  }
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(Get.isDarkMode
                    ? 'Activated Light Theme'
                    : 'Activated Dark Theme')));
          },
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.ex-cdn.com/mgn.vn/files/content/2022/08/25/one-piece-zoro-4-1606.jpg'),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text(
                        'Today',
                        style: headingStyle,
                      )
                    ],
                  ),
                ),
                CustomButton(lable: '+ Add Task',onTap: (){
                  Navigator.pushNamed(context, '/add_task');
                },)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryClr,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                dayTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                monthTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                onDateChange: (date) {
                  _selectedDate = date;
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
