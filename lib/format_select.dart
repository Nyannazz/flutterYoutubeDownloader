import 'package:flutter/material.dart';

class FormatSelect extends StatefulWidget {
  final List formatList;
  FormatSelect(this.formatList);
  @override
  _FormatSelectState createState() => _FormatSelectState();
}

class _FormatSelectState extends State<FormatSelect> {
  int selectedRow = 0;

  List createRows(List inputList, int selected) {
    List<DataRow> outputList = [];
    for (int i = 0; i < inputList.length; i++) {
      outputList.add(DataRow(
        /* onSelectChanged: (bool value) {
        print(value);
      }, */
        selected: i == selected,
        cells: <DataCell>[
          DataCell(Text(inputList[i]["type"]), onTap: () {
            setState(() {
              selectedRow = i;
            });
          }),
          DataCell(
              (i == selected
                  ? Center(
                      child: Container(
                        color: Colors.lightBlue,
                        height: 30.0,
                        child: RaisedButton(
                          child: Text("SAVE"),
                          onPressed: (){
                            
                          },
                        ),
                      ),
                    )
                  : Text(inputList[i]["quality"].toString())), onTap: () {
            setState(() {
              selectedRow = i;
            });
          }),
          DataCell(
              (i == selected
                  ? Center(
                      child: Container(
                        color: Colors.greenAccent,
                        height: 30.0,
                        child: RaisedButton(
                          child: Text("DL"),
                        ),
                      ),
                    )
                  : Text(inputList[i]["videoOnly"].toString())), onTap: () {
            setState(() {
              selectedRow = i;
            });
          }),
        ],
      ));
    }
    return outputList;
  }

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
          ], rows: createRows(widget.formatList, selectedRow)),
    );
  }
}
