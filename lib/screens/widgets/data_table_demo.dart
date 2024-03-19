import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/extensions/datatable_ext.dart';
import 'package:project_sem4_flutter_app_mobile/extensions/string_extension.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/scrollable_table.dart';

import '../../data/demo_data.dart';
import '../../model/user_model.dart';

class DemoDataTable extends StatefulWidget {
  const DemoDataTable({super.key});

  @override
  State<DemoDataTable> createState() => _DemoDataTableState();
}

class _DemoDataTableState extends State<DemoDataTable> {
  int? _sortColumnIndex;
  bool _sortAscending = false;

  late List<User> list_user = users;
  // selected user
  List<bool> selected = List<bool>.generate(users.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ScrollableTableWidget(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            DataTable(
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onSecondary),
              dataRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              sortAscending: _sortAscending,
              sortColumnIndex: _sortColumnIndex,
              columns: _getColumns(list_user.first.toJson().keys.toList()),
              rows: _getRows(list_user),
            ).withBorder,
          ])),
    );
  }

  List<DataColumn> _getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
          onSort: (columnIndex, ascending) => onSort(columnIndex, ascending),
          label: Text(column.capitalize)))
      .toList();

  List<DataRow> _getRows(List<User> users) => users
      .asMap()
      .map((index, user) {
        final cells = [
          user.id,
          user.username,
          user.password,
          user.token,
          user.created_at,
          user.status.toString(),
        ];
        return MapEntry(
            index,
            DataRow(
              selected: selected[index],
              onSelectChanged: (value) {
                setState(() {
                  selected[index] = value!;
                });
              },
              cells: _getCells(cells),
            ));
      })
      .values
      .toList();

  List<DataCell> _getCells(List<dynamic> cells) => cells
      .asMap()
      .map((index, cell) => MapEntry(
          index,
          DataCell(
              showEditIcon: index != 0 ? true : false,
              // show dialog edit data
              onTap: () => index != 0 ? editData(cell, cells) : null,
              Text(index == 4
                  ? cell.toString().substring(0, 10)
                  : cell.toString()))))
      .values
      .toList();

  void onSort(int columnIndex, bool asc) {
    if (columnIndex == 0) {
      // id
      list_user
          .sort((a, b) => asc ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    } else if (columnIndex == 1) {
      // username
      list_user.sort((a, b) => asc
          ? a.username.compareTo(b.username)
          : b.username.compareTo(a.username));
    } else if (columnIndex == 2) {
      // password
      list_user.sort((a, b) => asc
          ? a.password.compareTo(b.password)
          : b.password.compareTo(a.password));
    } else if (columnIndex == 5) {
      // status
      list_user.sort((a, b) => asc
          ? a.status.toString().compareTo(b.status.toString())
          : b.status.toString().compareTo(a.status.toString()));
    } else if (columnIndex == 4) {
      // created_at
      list_user.sort((a, b) => asc
          ? a.created_at.compareTo(b.created_at)
          : b.created_at.compareTo(a.created_at));
    }
    // more columns to sort...
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = asc;
    });
  }

  Future editData(dynamic cell, List<dynamic> cells) async {
    String columns =
        list_user.first.toJson().keys.toList()[cells.indexOf(cell)];
    TextEditingController controller =
        TextEditingController(text: cell.toString());
    // final DateTime? picked = ;
    // if (picked != null) {
    //   controller.text = picked.toString();
    // }
    // edit data return result
    final result = cells.indexOf(cell) != 4
        ? await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text('Edit $columns'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 10,
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(controller.text);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 17),
                      )),
                ],
                content: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: controller,
                )),
          )
        : await showDatePicker(
            context: context,
            initialDate: DateTime.parse(cell.toString()),
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101),
          );
    // update data
    if (!cell.toString().contains(result.toString()) && result != null) {
      setState(() => list_user = list_user.map((User user) {
            if (user.id == cells[0]) {
              if (cell == cells[1]) {
                return user.copy(username: result);
              } else if (cell == cells[2]) {
                return user.copy(password: result);
              } else if (cell == cells[3]) {
                return user.copy(token: result);
              } else if (cell == cells[4]) {
                return user.copy(created_at: DateTime.parse(result.toString()));
              } else if (cell == cells[5]) {
                return user.copy(status: result == 'true' ? true : false);
              }
            }
            return user;
          }).toList());
    }
  }
}
