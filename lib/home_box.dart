import 'package:flutter/material.dart';
import './glob.dart' as glob;

List<Widget> incomeBox() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '\$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> expenseBox() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> reportBoxClosed() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> reportBoxOpen() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 10));

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 10));

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

Widget homeBox(title, color, content) {
  return Column(
    children: [
      Text(
        title,
        style: glob.subHeadStyle('dark'),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFF425464),
          ),
          height: 3,
        ),
      ),
      Container(height: 20),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: content,
        ),
      ),
    ],
  );
}
