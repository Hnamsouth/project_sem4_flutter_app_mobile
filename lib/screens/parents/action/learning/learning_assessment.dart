import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/my_button.dart';

const List<String> list = <String>[
  'Năm học 2023 - 2024',
  'Năm học 2024 - 2025',
  'Năm học 2025 - 2026',
  'Năm học 2026 - 2027'
];

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class LeaningAssessmentScreen extends StatefulWidget {
  const LeaningAssessmentScreen({super.key});

  @override
  State<LeaningAssessmentScreen> createState() => _LeaningAssessmentState();
}

class _LeaningAssessmentState extends State<LeaningAssessmentScreen> {
  String dropdownValue = list.first;

  late int _selectedIndex;

  final List<Subject> subjects = [
    Subject('Toán', 8.5, 7.8),
    Subject('Văn', 9.3, 8.7),
    Subject('Lịch Sử', 7.8, 7.2),
    Subject('Tiếng Anh', 8.9, 8.3),
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0; // Mặc định hiển thị tab cho kỳ học 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBFECD9),
        title: Text("Phiếu đánh giá học tập"),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green)),
              height: 50,
              width: double.infinity,
              child: Center(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0; // Chọn tab cho kỳ học 1
                    });
                  },
                  buttonText: 'Kì I',
                  btnHeight: 50,
                  btnWidth: 100,
                ),
                MyButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1; // Chọn tab cho kỳ học 1
                    });
                  },
                  buttonText: 'Kì II',
                  btnHeight: 50,
                  btnWidth: 100,
                ),
                MyButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2; // Chọn tab cho kỳ học 1
                    });
                  },
                  buttonText: 'Cả năm',
                  btnHeight: 50,
                  btnWidth: 100,
                ),
              ],
            ),
            Expanded(
              child: DataTable(
                columnSpacing:150, // Khoảng cách giữa các cột
                columns: [
                  DataColumn(
                    label: Text(
                      'Môn học',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      _selectedIndex == 0 ? 'Trung bình kì 1' : (_selectedIndex == 1 ? 'Trung bình kì 2' : 'Tổng kết'),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
                rows: subjects.map((subject) {
                  String content = _selectedIndex == 0
                      ? '${subject.averageSemester1}'
                      : (_selectedIndex == 1 ? '${subject.averageSemester2}' : '${subject.summary}');
                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) => Colors.grey[200]!), // Màu nền của hàng
                    cells: [
                      DataCell(
                        Text(
                          subject.name,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                      DataCell(
                        Text(
                          content,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Subject {
  late String name;
  late double averageSemester1;
  late double averageSemester2;
  late String summary;

  Subject(this.name, this.averageSemester1, this.averageSemester2) {
    // Tính tổng kết dựa trên điểm trung bình của từng kỳ
    double totalAverage = (averageSemester1 + averageSemester2) / 2;

    // Xác định tổng kết dựa trên totalAverage
    if (totalAverage >= 8.5) {
      summary = 'Giỏi';
    } else if (totalAverage >= 7) {
      summary = 'Khá';
    } else if (totalAverage >= 5.0) {
      summary = 'Trung Bình';
    } else {
      summary = 'Yếu';
    }
  }
}