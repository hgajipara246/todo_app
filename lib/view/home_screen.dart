import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/to_do_model.dart';
import 'package:todo_app/res/constant/app_string.dart';
import 'package:todo_app/view/todo_enter_data.dart';
import 'package:todo_app/view/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? sharedPreferences;

  List<ToDoModel> toDoModel = [];

  setInstant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    toDoModel = [];
    if (sharedPreferences!.containsKey('ToDoData')) {
      var data = sharedPreferences!.getStringList("ToDoData");

      for (var mapData in data!) {
        toDoModel.add(toDoModelFromJson(mapData));
      }
      debugPrint(data.toString());
      debugPrint(jsonEncode(toDoModel));
      setState(() {});
    } else {
      debugPrint("No Data Foud----------->>");
    }
  }

  setData() {
    List<String> listData = [];
    for (var mapData in toDoModel) {
      listData.add(jsonEncode(mapData));
    }

    sharedPreferences!.setStringList("ToDoData", listData);
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
        title: AppString.homePageTitle,
      ),
      body: toDoModel.isEmpty
          ? Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: toDoModel.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  title: toDoModel[index].title,
                  time: toDoModel[index].time,
                  description: toDoModel[index].discription,
                  count: (index + 1).toString(),
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoEnterData(
                          toDoModel: toDoModel[index],
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      getData();
                    });
                  },
                  onDelet: () {
                    toDoModel.removeAt(index);
                    setState(() {});
                    setData();
                  },
                );
              },
              // separatorBuilder: (context, index) => SizedBox(
              //   height: MediaQuery.of(context).size.height / 150,
              // ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoEnterData(),
            ),
          ).then((value) {
            getData();
          });
        },
        child: Icon(Icons.navigate_next_rounded),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(),
    );
  }
}
