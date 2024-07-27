import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import '../../../../model/action/take_leave_model.dart';
import '../../../../service/api_service.dart';

StudentController studentController = Get.find();
UserController userController = Get.find();

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<DateTime> _absentDates = [];

  @override
  void initState() {
    super.initState();
    // Initialize date formatting for Vietnamese
    initializeDateFormatting('vi_VN', null).then((_) {
      setState(() {});
    });
  }

  void _updateAbsentDates() {
    setState(() {
      _absentDates = [];
      for (DateTime date = startDate;
          date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
          date = date.add(Duration(days: 1))) {
        if (date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday) {
          _absentDates.add(date);
        }
      }
    });
  }

  Future<void> submitLeaveRequest(TakeLeave takeLeave) async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    final response =
        await DioService().post("/student/take-leave", data: takeLeave);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Thông báo'),
          content: const Text(
              'Nộp đơn thành công, vui lòng chờ giáo viên xác nhận !!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/home_parent'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Failed to submit leave request: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký nghỉ học'),
      ),
      body: SingleChildScrollView(
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
                  text: "Học sinh : ",
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: [
                    _FormDatePicker(
                      date: startDate,
                      title: "Từ ngày",
                      onChanged: (value) {
                        setState(() {
                          startDate = value;
                          _updateAbsentDates();
                        });
                      },
                    ),
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Column(children: [
                    _FormDatePicker(
                      date: endDate,
                      title: "Đến ngày",
                      onChanged: (value) {
                        setState(() {
                          endDate = value;
                          _updateAbsentDates();
                        });
                      },
                    ),
                  ]),
                ],
              ),
              SizedBox(height: 16.0),
              Text("Số ngày nghỉ (${_absentDates.length})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _absentDates.length,
                itemBuilder: (context, index) {
                  return Text(intl.DateFormat('EEEE, dd/MM/yyyy', 'vi_VN')
                      .format(_absentDates[index]));
                },
              ),
              Text('Lí do :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                keyboardType: TextInputType.text,
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
                      text: userController.user.value.userDetail?.fullName(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _absentDates.isNotEmpty) {
                      TakeLeave leaveRequest = TakeLeave(
                        studentYearInfoId:
                            studentController.studentRecord.value.students!.id,
                        userId: userController.user.value.id,
                        note: _noteController.text,
                        startDate: startDate,
                        endDate: endDate,
                      );
                      submitLeaveRequest(leaveRequest);
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
            ElevatedButton.icon(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ))),
              label: Text(
                intl.DateFormat('EEEE, dd/MM/yyyy', 'vi_VN')
                    .format(widget.date),
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              onPressed: () async {
                var newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  locale: const Locale('vi', 'VN'),
                );

                // Don't change the date if the date picker returns null.
                if (newDate == null) {
                  return;
                }

                widget.onChanged(newDate);
              },
              icon: Icon(Icons.calendar_today, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
