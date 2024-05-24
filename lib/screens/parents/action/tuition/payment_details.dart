import 'package:flutter/material.dart';

class PaymentDetail {
  final String description;
  final String amount;

  PaymentDetail({required this.description, required this.amount});
}

class PaymentDetailScreen extends StatefulWidget {
  final String period;
  final String studentName;
  final String className;
  final String studentCode;
  final List<PaymentDetail> paymentDetails;
  final String totalAmount;
  final String paidAmount;
  final String unpaidAmount;
  final String status;

  const PaymentDetailScreen({
    Key? key,
    required this.period,
    required this.studentName,
    required this.className,
    required this.studentCode,
    required this.paymentDetails,
    required this.totalAmount,
    required this.paidAmount,
    required this.unpaidAmount,
    required this.status,
  }) : super(key: key);

  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  String selectedPaymentMethod = 'Thẻ tín dụng';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết khoản thu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeader(),
            SizedBox(height: 16),
            _buildStudentInfo(),
            SizedBox(height: 16),
            _buildPaymentDetails(),
            SizedBox(height: 16),
            _buildTotalAmount(),
            SizedBox(height: 16),
            _buildPaymentMethods(),
            SizedBox(height: 16),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.period,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.status,
              style: TextStyle(
                fontSize: 16,
                color: widget.status == 'Chưa thanh toán' ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Tên học sinh', widget.studentName),
            _buildInfoRow('Lớp học', widget.className),
            _buildInfoRow('Mã học sinh', widget.studentCode),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Các khoản thu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: widget.paymentDetails.map((detail) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(detail.description),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(detail.amount, textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Tổng số tiền', widget.totalAmount),
            _buildInfoRow('Đã thanh toán', widget.paidAmount),
            _buildInfoRow('Chưa thanh toán', widget.unpaidAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phương thức thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RadioListTile<String>(
              title: Text('Thẻ tín dụng'),
              value: 'Thẻ tín dụng',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Thẻ ghi nợ'),
              value: 'Thẻ ghi nợ',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Ví điện tử'),
              value: 'Ví điện tử',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tổng số tiền',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.totalAmount,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle payment action
                _handlePayment();
              },
              child: Text('Thanh toán'),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayment() {
    // Implement payment handling logic here
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Thanh toán thành công bằng $selectedPaymentMethod.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


