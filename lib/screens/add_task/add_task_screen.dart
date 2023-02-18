import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notification/config/themes.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const String routeName = '/add_task';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: AddTaskScreen.routeName),
        builder: (_) => AddTaskScreen());
  }

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = '9:30 PM';

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2024),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    String _formatedTime = pickerTime.format(context);
    if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            // start time --> 09:15 AM
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(' ')[0])));
  }

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('All field are required!'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  _addTaskToDb() async {
    int value = await taskController.addTask(
        task: Task(
           title: _titleController.text,
            note: _noteController.text,
           isCompleted: 0,
            date: DateFormat.yMd().format(_selectedDate),
            startDate: _startTime,
            endDate: _endTime,
             color: _selectedColor,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
           
            ));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        backgroundColor: Colors.transparent,
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.ex-cdn.com/mgn.vn/files/content/2022/08/25/one-piece-zoro-4-1606.jpg'),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildTilteTextFormField(
                title: 'Title',
                hintText: 'Enter title here',
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTilteTextFormField(
                title: 'Note',
                hintText: 'Enter note here',
                controller: _noteController,
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTilteTextFormField(
                title: 'Date',
                hintText: DateFormat.yMMMMd().format(_selectedDate),
                widget: GestureDetector(
                    onTap: () {
                      _getDateFromUser();
                    },
                    child: Icon(Icons.calendar_today_outlined)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildTilteTextFormField(
                    title: 'Start Time',
                    hintText: _startTime,
                    widget: GestureDetector(
                        onTap: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        child: Icon(Icons.alarm)),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: _buildTilteTextFormField(
                    title: 'End Time',
                    hintText: _endTime,
                    widget: GestureDetector(
                        onTap: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        child: Icon(Icons.alarm)),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTilteTextFormField(
                title: 'Remind',
                hintText: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: remindList.map((remind) {
                    return DropdownMenuItem(
                        value: remind.toString(),
                        child: Text(remind.toString()));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTilteTextFormField(
                title: 'Repeat',
                hintText: '$_selectedRepeat',
                widget: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                  icon:const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: repeatList.map((repeatList) {
                    return DropdownMenuItem(
                        value: repeatList.toString(),
                        child: Text(repeatList.toString()));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Color',
                        style: GoogleFonts.lato(
                            textStyle:const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? primaryClr
                                  : index == 1
                                      ? pinkClr
                                      : yellowClr,
                              child: _selectedColor == index
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      }))
                    ],
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: primaryClr),
                      onPressed: () {
                        _validateDate();
                      },
                      child: Text('Create Task'))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildTilteTextFormField extends StatelessWidget {
  const _buildTilteTextFormField(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.widget});
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.black : Colors.white,
              border: Border.all(
                  width: 1,
                  color: Get.isDarkMode ? Colors.white : Colors.black)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                      fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                      filled: true,
                      hintText: hintText,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0))),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        )
      ],
    );
  }
}
