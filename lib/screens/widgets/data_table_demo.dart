import 'package:flutter/material.dart';

class DemoDataTable extends StatefulWidget {
  const DemoDataTable({super.key});

  @override
  State<DemoDataTable> createState() => _DemoDataTableState();
}

class _DemoDataTableState extends State<DemoDataTable> {
  var listData = [
    {'Name': 'Sarah', 'Age': '19', 'Address': 'New York'},
    {'Name': 'Janine', 'Age': '43', 'Address': 'Paris'},
    {'Name': 'William', 'Age': '27', 'Address': 'London'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
              numeric: false,
              onSort: (columnIndex, ascending) {
                setState(() {
                  if (!ascending) {
                    listData.sort((a, b) =>
                        a['Name'].toString().compareTo(b['Name'].toString()));
                    print(columnIndex);
                  } else {
                    listData.sort((a, b) =>
                        b['Name'].toString().compareTo(a['Name'].toString()));
                  }
                });
              },
              label: Text('Name')),
          DataColumn(
            label: Text('Age'),
          ),
          DataColumn(
            label: Text('Address'),
          ),
        ],
        rows: listData
            .map(
              (data) => DataRow(
                cells: <DataCell>[
                  DataCell(
                    showEditIcon: true,
                    Text(data['Name']!),
                  ),
                  DataCell(
                    Text(data['Age']!),
                  ),
                  DataCell(
                    Text(data['Address']!),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
