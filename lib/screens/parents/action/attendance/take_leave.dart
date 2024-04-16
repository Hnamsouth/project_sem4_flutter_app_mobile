import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/my_button.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/my_textfield.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TakeLeaveScreen extends StatefulWidget {
  const TakeLeaveScreen({super.key});

  @override
  State<TakeLeaveScreen> createState() => _TakeLeaveScreenState();
}

class _TakeLeaveScreenState extends State<TakeLeaveScreen> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        // _startDate = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
        // _endDate = '${DateFormat('dd/MM/yyyy').format(args.value.endDate)}';
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} ->'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime?) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>?) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  String _selectedDate = '';
  String _range = '';
  String _rangeCount = '';
  String _dateCount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn xin nghỉ'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 20),

                    child: Text('Nghỉ Từ : $_range',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),)),
                // Text('Start: $_startDate'),
                // Text('End: $_endDate'),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 450,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            MyTextField(
              hintText: "Lý do",
              obscureText: false,
            ),
            SizedBox(
              height: 25,
            ),
            MyButton(onPressed: (){}, buttonText: "Nộp đơn xin nghỉ")
          ],
        )));
  }
}
