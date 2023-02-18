import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notification/config/themes.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/models/task_model.dart';
import 'package:notification/services/theme_service.dart';
import 'package:notification/widgets/widgets.dart';
import 'package:date_picker_timeline_fixed/date_picker_timeline_fixed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: HomeScreen.routeName),
        builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding:const EdgeInsets.all(10),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? Colors.black : Colors.white,
      child: Column(
        children: [
          task.isCompleted == 1
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _bottomSheetButton(lable: 'TaskCompleted', clr: primaryClr,onTap: (){
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    _bottomSheetButton(lable: 'Delete Task', clr: pinkClr,onTap: (){
                      _taskController.delete(task);
                     
                      Get.back();
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    _bottomSheetButton(lable: 'Close', clr: darkGreyClr,onTap: (){
                      Get.back();
                    })
                  ],
                )
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String lable,
      Function()? onTap,
      required Color clr,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), color: clr),
        child: Text(
          lable,
          textAlign: TextAlign.center,
          style:const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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
        actions: const[
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.ex-cdn.com/mgn.vn/files/content/2022/08/25/one-piece-zoro-4-1606.jpg'),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              CustomButton(
                lable: '+ Add Task',
                onTap: () async {
                  await Navigator.pushNamed(context, '/add_task');
                  _taskController.getTasks();
                },
              )
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
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              dayTextStyle: GoogleFonts.lato(
                  textStyle:const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              monthTextStyle: GoogleFonts.lato(
                  textStyle:const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              onDateChange: (date) {
                _selectedDate = date;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: _taskController.taskList.length,
                itemBuilder: (context, index) {
                  print(_taskController.taskList.length);
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                    context, _taskController.taskList[index]);
                              },
                              child: TaskTile(_taskController.taskList[index]),
                            )
                          ],
                        )),
                      ));
                },
              );
            }),
          )
        ]),
      ),
    );
  }
}
