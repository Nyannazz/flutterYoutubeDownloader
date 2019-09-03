import 'package:flutter/material.dart';

class FormatSelect extends StatefulWidget {
  final List formatList;
  FormatSelect(this.formatList);
  @override
  _FormatSelectState createState() => _FormatSelectState();
}

class _FormatSelectState extends State<FormatSelect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text("type"), numeric: false),
            DataColumn(label: Text("quality"), numeric: false),
            DataColumn(
              label: Text("size"),
              numeric: true,
            ),
          ],
          rows: widget.formatList
              .map((item) => DataRow(selected: true, cells: <DataCell>[
                    DataCell(Text("hello")),
                    DataCell(Text("world")),
                    DataCell(Text("mr")),
                  ]))
              .toList()),
    );
  }
}
