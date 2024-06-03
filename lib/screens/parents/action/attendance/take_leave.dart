import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/attendance_creen.dart';

StudentController studentController = Get.find();

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _parentNameController =
      TextEditingController(text: 'Nguyễn Thị Ngân');
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<DateTime> _absentDates = [];

  void _updateAbsentDates() {
    setState(() {
      _absentDates = [];
      for (DateTime date = startDate;
          date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
          date = date.add(Duration(days: 1))) {
        _absentDates.add(date);
      }
    });
  }

  UserController userctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký nghỉ học'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: "Kính gửi : ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Thầy/Cô giáo chủ nhiệm',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  text: "Tên học sinh : ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: studentController.studentRecord.value.students
                          ?.getFullName(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  text: "Lớp : ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: studentController
                          .studentRecord.value.schoolYearClass?.className,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text('Gia đình xin phép cho con được nghỉ học ngày:'),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: _FormDatePicker(
                      date: startDate,
                      title: "Từ ngày",
                      onChanged: (value) {
                        setState(() {
                          startDate = value;
                          _updateAbsentDates();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _FormDatePicker(
                      date: endDate,
                      title: "Đến ngày",
                      onChanged: (value) {
                        setState(() {
                          endDate = value;
                          _updateAbsentDates();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text("Danh sách ngày nghỉ(${_absentDates.length}) ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _absentDates.length,
                itemBuilder: (context, index) {
                  return Text(
                      intl.DateFormat.yMd().format(_absentDates[index]));
                },
              ),
              Text('Lí do',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              Text(
                  'Gia đình cam kết giúp cháu tự ôn tập, làm đầy đủ bài tập được giao trong thời gian nghỉ học. Trân trọng cảm ơn!'),
              SizedBox(height: 16.0),




              RichText(
                text: TextSpan(
                  text: "Họ tên phụ huynh: ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: userctrl.user.value.userDetail?.fullName(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.0),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    }
                  },
                  child: Text('Gửi đơn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final String title;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.title,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text(
            'Sửa',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
