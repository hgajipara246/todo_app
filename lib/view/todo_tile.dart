import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String? title;
  final String? time;
  final String? description;
  final String? count;
  final void Function()? onEdit;
  final void Function()? onDelet;

  const ToDoTile({
    Key? key,
    this.title,
    this.time,
    this.description,
    this.count,
    this.onEdit,
    this.onDelet,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 50,
        vertical: MediaQuery.of(context).size.height / 600,
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          Container(
            height: MediaQuery.of(context).size.height / 15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xB000000),
                style: BorderStyle.solid,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 7,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        count ?? "",
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 80),
                        Container(
                          height: MediaQuery.of(context).size.height / 50,
                          width: MediaQuery.of(context).size.width / 400,
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 80),
                        Text(
                          time ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 200),
                    Text(
                      description ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDelet,
                  icon: const Icon(Icons.delete_outline_outlined),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 25),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
