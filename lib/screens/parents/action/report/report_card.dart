import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ReportCardScreen extends StatefulWidget {
  const ReportCardScreen({Key? key}) : super(key: key);

  @override
  _ReportCardScreenState createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điểm'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
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
                _buildReportCard('Học kỳ I', _semester1Rows()),
                _buildReportCard('Học kỳ II', _semester2Rows()),
                _buildReportCard('Tổng kết', _summaryRows()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, List<TableRow> rows) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.14),
              2: FractionColumnWidth(0.14),
              3: FractionColumnWidth(0.14),
              4: FractionColumnWidth(0.14),
              5: FractionColumnWidth(0.14),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rows,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'TỔNG KẾT HỌC KỲ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          _buildSummaryRow('Học lực', 'G'),
          _buildSummaryRow('Hạnh kiểm', 'T'),
          _buildSummaryRow('Danh hiệu', 'GIOI'),
          _buildSummaryRow('Xếp hạng', '32'),
          _buildSummaryRow('Số ngày nghỉ', '0'),
          _buildSummaryRow('TBMHK', '8.5'),
          const SizedBox(height: 8.0),
          const Text(
            'Chú thích:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text('- ĐĐGTx: Điểm đánh giá thường xuyên'),
          const Text('- ĐĐGGK: Điểm đánh giá giữa  Kỳ'),
        ],
      ),
    );
  }

  List<TableRow> _semester1Rows() {
    return [
      _buildTableHeader(),
      _buildTableRow('Toán', '8', '9', '10', '8.9'),
      _buildTableRow('Vật lí', '10', '9', '8', '8.9'),
      _buildTableRow('Sinh học', '9', '10', '8',  '8.8'),
      _buildTableRow('Ngữ văn', '8', '8', '8',  '7.8'),
      _buildTableRow('Lịch sử', '8', '9', '10',  '8.6'),
      _buildTableRow('Địa lí', '9', '9', '8', '7.8'),
      _buildTableRow('Ngoại ngữ 1', '7', '8', '9', '8.1'),
      _buildTableRow('GDCD', '9', '10', '10',  '8.9'),
      _buildTableRow('Công nghệ', '9', '10', '8.5',  '9.0'),
    ];
  }

  List<TableRow> _semester2Rows() {
    return [
      _buildTableHeader(),
      _buildTableRow('Toán', '8', '8', '9', '8.6'),
      _buildTableRow('Vật lí', '9', '8.5', '8',  '8.4'),
      _buildTableRow('Sinh học', '8', '9', '7',  '8.0'),
      _buildTableRow('Ngữ văn', '8', '8', '7',  '7.6'),
      _buildTableRow('Lịch sử', '9', '9', '9',  '9.0'),
      _buildTableRow('Địa lí', '8', '8', '7',  '7.8'),
      _buildTableRow('Ngoại ngữ 1', '7', '7', '8',  '7.5'),
      _buildTableRow('GDCD', '10', '9', '9',  '9.2'),
      _buildTableRow('Công nghệ', '9', '9', '9',  '9.0'),
    ];
  }

  List<TableRow> _summaryRows() {
    return [
      _buildTableHeader(),
      _buildTableRow('Toán', '8', '8.5', '9.5',  '8.9'),
      _buildTableRow('Vật lí', '9.5', '8.75', '8',  '8.75'),
      _buildTableRow('Sinh học', '8.5', '9.5', '7.5',  '8.3'),
      _buildTableRow('Ngữ văn', '8', '8', '7.5', '7.5'),
      _buildTableRow('Lịch sử', '8.5', '9', '9.5',  '8.9'),
      _buildTableRow('Địa lí', '8.5', '8.5', '7.5',  '7.9'),
      _buildTableRow('Ngoại ngữ 1', '7', '7.5', '8.5', '7.8'),
      _buildTableRow('GDCD', '9.5', '9.5', '9.5',  '9.3'),
      _buildTableRow('Công nghệ', '9', '9.5', '8.75',  '9.0'),
    ];
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        _buildTableCell('Môn học', isHeader: true),
        _buildTableCell('ĐĐGTx', isHeader: true),
        _buildTableCell('ĐĐGGK', isHeader: true),
        _buildTableCell('ĐĐGCK', isHeader: true),
        _buildTableCell('TB', isHeader: true),
      ],
    );
  }

  TableRow _buildTableRow(String subject, String ddgtx, String ddgk, String ddgck,  String avg) {
    return TableRow(
      children: [
        _buildTableCell(subject),
        _buildTableCell(ddgtx),
        _buildTableCell(ddgk),
        _buildTableCell(ddgck),
        _buildTableCell(avg),
      ],
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

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
