import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/to_do_model.dart';
import 'package:todo_app/res/common/app_text_feild.dart';
import 'package:todo_app/res/constant/app_string.dart';

class TodoEnterData extends StatefulWidget {
  final ToDoModel? toDoModel;
  final int? index;
  const TodoEnterData({
    Key? key,
    this.toDoModel,
    this.index,
  }) : super(key: key);
  @override
  State<TodoEnterData> createState() => _TodoEnterDataState();
}

class _TodoEnterDataState extends State<TodoEnterData> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController discriptioncontroller = TextEditingController();
  String time = "";

  SharedPreferences? sharedPreferences;
  List<String> toDoList = [];

  setInstant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    if (sharedPreferences!.containsKey("ToDoData")) {
      toDoList = sharedPreferences!.getStringList("ToDoData")!;
      setState(() {});
    } else {
      debugPrint("No Data Found...");
    }
  }

  setdata() {
    Map<String, dynamic> data = {
      "title": titlecontroller.text,
      "discription": discriptioncontroller.text,
      "time": time,
    };
    if (widget.toDoModel != null) {
      toDoList[widget.index!] = (jsonEncode(data));
    } else {
      toDoList.add(jsonEncode(data));
    }

    // debugPrint(' Data is set ---> $data');
    sharedPreferences!.setStringList("ToDoData", toDoList);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();

    if (widget.toDoModel != null) {
      titlecontroller.text = widget.toDoModel!.title!;
      discriptioncontroller.text = widget.toDoModel!.discription!;
      time = widget.toDoModel!.time!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 80,
            horizontal: MediaQuery.of(context).size.height / 70,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(15),
            children: [
              AppTextField(
                hintText: 'Enter Title',
                controller: titlecontroller,
                minAndMaxLine: null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              AppTextField(
                hintText: 'Description',
                minAndMaxLine: 10,
                controller: discriptioncontroller,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      time.isNotEmpty ? time : AppString.selectedTime,
                      style: TextStyle(
                        color: time.isNotEmpty ? Colors.black : Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () async {
                    TimeOfDay? selectTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectTime != null) {
                      debugPrint(selectTime.format(context));
                      time = selectTime.format(context);
                      setState(() {});
                    }
                  }),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    setdata();
                  },
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
