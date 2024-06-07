import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/payment/payment.dart';
import 'package:project_sem4_flutter_app_mobile/screens/test/test_payment.dart';
import 'package:quickly/quickly.dart';

import '../../../../service/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home_parent.dart';

enum SingingCharacter { one, two }

SingingCharacter? _character = SingingCharacter.one;

class PaymentDetail {
  final String title;
  final int amount;
  final int price;

  PaymentDetail(
      {required this.title, required this.amount, required this.price});
}

class PaymentDetailScreen extends StatefulWidget {
  final int transactionId;
  final String period;
  final String studentName;
  final String className;
  final String studentCode;
  final List<PaymentDetail> paymentDetails;
  final int totalAmount;
  final int paidAmount;
  final int unpaidAmount;
  final String status;

  const PaymentDetailScreen({
    Key? key,
    required this.transactionId,
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
  final DioService _dio = DioService();
  bool _isLoading = false;

  // Future<void> paymentReturn(dynamic dataReturn) async{
  //   try{
  //     final rs = await _dio.get('')
  //   }
  // }

  Future<void> initiatePayment(dynamic data) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.post(
        '/vn-pay/submitOrder',
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Ensure responseData is a Map

        final paymentUrl = responseData;
        // Ensure the paymentUrl is a String
        if (await canLaunch(paymentUrl)) {
          await launch(paymentUrl);
          Get.to(StudentPaymentScreen());
        } else {
          throw Exception('Could not launch $paymentUrl');
        }
      } else {
        print('Failed to create payment: ${response.statusMessage}');
        throw Exception('Failed to create payment: ${response.statusMessage}');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create payment. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String formatCurrency(int amount) {
    final NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return currencyFormatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết khoản thu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            _buildTotalAmount(),
            SizedBox(height: 10),
            widget.status == 'Chưa thanh toán'
                ? _buildPaymentMethods()
                : SizedBox(
                    height: 1,
                  ),
            widget.status == 'Chưa thanh toán'
                ? SizedBox(height: 10)
                : SizedBox(
                    height: 1,
                  ),
            widget.status == 'Chưa thanh toán'
                ? _buildPayButton()
                : SizedBox(
                    height: 1,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 1,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
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
                  color: widget.status == 'Chưa thanh toán'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
        _buildStudentInfo(),
      ]),
    );
  }

  Widget _buildStudentInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Học sinh', widget.studentName),
          _buildInfoRow('Lớp học', widget.className),
          _buildInfoRow('Mã học sinh', widget.studentCode),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Padding(
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
                      flex: 6,
                      child: Text(detail.title),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(formatCurrency(detail.amount * detail.price),
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Card(
      elevation: 1,
      child: Column(children: [
        _buildPaymentDetails(),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Tổng số tiền', formatCurrency(widget.totalAmount)),
              _buildInfoRow('Đã thanh toán', formatCurrency(widget.paidAmount)),
              _buildInfoRow(
                  'Chưa thanh toán', formatCurrency(widget.unpaidAmount)),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      elevation: 1,
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Image.network(
                  'https://vnpay.vn/s1/statics.vnpay.vn/2023/6/0oxhzjmxbksr1686814746087.png',
                  // Thay bằng URL thực tế của ảnh logo ZaloPay
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'VNPay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('Miễn phí giao dịch'),
                trailing: Radio<SingingCharacter>(
                  value: SingingCharacter.two,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    final data = {
      "total": widget.totalAmount,
      "orderInfo": widget.transactionId
    };
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng số tiền',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatCurrency(widget.totalAmount),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                initiatePayment(data);
                // _handlePayment();
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue // text color
                  ),
              child: Text('Thanh toán'),
            ),
          ],
        ),
      ),
    );
  }
}
