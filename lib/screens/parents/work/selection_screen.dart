import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/work/new_activate_screen.dart';


final UserController userController = Get.find();
final _id = userController.user.value.id;
final name = userController.user.value.userDetail?.fullName();
class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  int selectedRadio = 0;

  Map<String, bool> classSelections = {
    '10A': false,
    '10A1': true,
    '10A2': true,
    '10B': false,
    '10D': false,
    '11A': false,
    '11A1': false,
    '11B': false,
    '12A': false,
    '12B': false,
  };

  void setSelectedRadio(int value) {
    setState(() {
      selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chọn đối tượng xem'),
        actions: [
          TextButton(
            onPressed: () {
Get.to(NewActivateScreen(id: _id!, name: name,));            },
            child: Text('Xong', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Toàn trường - MN-TH-THCS-THPT-GDTX Thủ Đô'),
            trailing: Radio(
              value: 0,
              groupValue: selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
          ),
          ListTile(
            title: Text('Giáo viên'),
            trailing: Radio(
              value: 1,
              groupValue: selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
          ),
          ListTile(
            title: Text('Phụ huynh'),
            trailing: Radio(
              value: 2,
              groupValue: selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Chọn lớp'),
            trailing: Radio(
              value: 3,
              groupValue: selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
          ),
          ...classSelections.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: classSelections[key],
              onChanged: (bool? value) {
                setState(() {
                  classSelections[key] = value!;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
