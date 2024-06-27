import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/point_model.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/student_score.dart';
import 'package:project_sem4_flutter_app_mobile/service/point_service.dart';

StudentController studentController = Get.find();
final _id = studentController.studentRecord.value.students?.id;

class ReportCardScreen extends StatefulWidget {
  const ReportCardScreen({super.key});

  @override
  _ReportCardScreenState createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  PointModel? _pointModel;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      PointModel data = await PointService.getPoint(_id!);
      setState(() {
        _pointModel = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bảng điểm'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text('Error: $_errorMessage'))
          : _pointModel == null
          ? Center(child: Text('No data available'))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            controller: _tabController,
            tabs: [
              Tab(text: 'Học kỳ I'),
              Tab(text: 'Học kỳ II'),
              Tab(text: 'Tổng kết'),
            ],
            onTap: (index) {
              setState(() {});
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReportCard('Học kỳ I', _pointModel?.semester1 ?? []),
                _buildReportCard('Học kỳ II', _pointModel?.semester2 ?? []),
                _buildReportCard('Tổng kết', _pointModel?.summary ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, List<StudentScoreSubject> scores) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Main header row
          Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(10),
                color:Colors.black12 ),
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.2),
              1: FractionColumnWidth(0.1),
              2: FractionColumnWidth(0.1),
              3: FractionColumnWidth(0.1),
              4: FractionColumnWidth(0.1),
              5: FractionColumnWidth(0.1),
              6: FractionColumnWidth(0.1),
              7: FractionColumnWidth(0.2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(

                children: [
                  _buildTableCellHeader('Môn học', isHeader: true),
                  _buildTableCellHeader('ĐĐGTX1', isHeader: true),
                  _buildTableCellHeader('ĐĐGTX2', isHeader: true),
                  _buildTableCellHeader('ĐĐGTX3', isHeader: true),
                  _buildTableCellHeader('ĐĐGTX4', isHeader: true),
                  _buildTableCellHeader('ĐĐGGK', isHeader: true),
                  _buildTableCellHeader('ĐĐGCK', isHeader: true),
                  _buildTableCellHeader('TB', isHeader: true),
                ],
              ),
              ...scores.map((subject) => TableRow(
                children: [
                  _buildTableCell(subject.schoolYearSubject.name),
                  _buildTableCell(subject.studentScores.KTTX.isNotEmpty ? subject.studentScores.KTTX[0].score : ""),
                  _buildTableCell(subject.studentScores.KTTX.length > 1 ? subject.studentScores.KTTX[1].score : ""),
                  _buildTableCell(subject.studentScores.KTTX.length > 2 ? subject.studentScores.KTTX[2].score : ""),
                  _buildTableCell(subject.studentScores.KTTX.length > 3 ? subject.studentScores.KTTX[3].score : ""),
                  _buildTableCell(subject.studentScores.KT_GIUA_KY.map((e) => e.score).join(", ")),
                  _buildTableCell(subject.studentScores.KT_CUOI_KY.map((e) => e.score).join(", ")),
                  _buildTableCell(subject.studentScores.DTB.map((e) => e.score).join(", ")),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTableCellHeader(String text, {bool isHeader = false}) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
    );
  }
}
