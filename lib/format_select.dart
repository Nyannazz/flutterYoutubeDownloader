import 'package:flutter/material.dart';

class FormatSelect extends StatefulWidget {
  final List formatList;
  FormatSelect(this.formatList);
  @override
  _FormatSelectState createState() => _FormatSelectState();
}

List createRows(List inputList, int selected) {
  List<DataRow> outputList=[];
  for (int i = 0; i < inputList.length; i++) {
    outputList.add(DataRow(
      /* onSelectChanged: (bool value) {
        print(value);
      }, */
      selected: i==selected,
      cells: <DataCell>[
        DataCell(Text(inputList[i]["type"])),
        DataCell(Text(inputList[i]["quality"])),
        DataCell(Text(inputList[i]["videoOnly"].toString())),
      ],
    ));
  }
  return outputList;
}

class _FormatSelectState extends State<FormatSelect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          /* columnSpacing: 50.0, */
          columns: <DataColumn>[
            DataColumn(label: Text("type"), numeric: false),
            DataColumn(label: Text("quality"), numeric: false),
            DataColumn(
              label: Text("only video"),
              numeric: false,
            ),
          ],
          rows: createRows(widget.formatList, 3)),
    );
  }
}
