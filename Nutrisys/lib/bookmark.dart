import 'package:flutter/material.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);
  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {

  List<String> bookmark = ["새우깡", "김치찌개", "짜파구리", "호박", "고구마", "호박고구마"];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookmark.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 150,
            child: Text("Item ${bookmark[index]}"),
          );
        },
      ),
    );
  }
}
