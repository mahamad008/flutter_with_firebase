import 'package:flutter/material.dart';

class PlayList extends StatelessWidget {
  final String title;
  final bool isdone;
  final VoidCallback? ontap;

  const PlayList({Key? key, required this.title, required this.isdone, this.ontap}) 
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: isdone ? Colors.blue : Colors.red,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isdone ? Icons.done : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
