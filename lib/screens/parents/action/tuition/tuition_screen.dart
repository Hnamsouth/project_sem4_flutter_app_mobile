import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tuition/payment_details.dart';


final StudentController studentController = Get.find();
class PaymentInfo {
  final String period;
  final String totalAmount;
  final String dueDate;
  final String status;

  PaymentInfo({
    required this.period,
    required this.totalAmount,
    required this.dueDate,
    required this.status,
  });
}

class StudentPaymentScreen extends StatefulWidget {
  const StudentPaymentScreen({super.key});

  @override
  _StudentPaymentScreenState createState() => _StudentPaymentScreenState();
}

class _StudentPaymentScreenState extends State<StudentPaymentScreen> {
  final String? studentName = studentController.studentRecord.value.students?.getFullName();
  final String? className = studentController.studentRecord.value.schoolYearClass?.className;
  final String? studentCode = studentController.studentRecord.value.students?.studentCode ;

  final List<PaymentInfo> unpaidPayments = [
    PaymentInfo(
      period: 'Đợt thu tháng 9/2023',
      totalAmount: '135.000 đ',
      dueDate: 'Hạn thanh toán: 29/09/2023',
      status: 'Chưa thanh toán',
    ),
    PaymentInfo(
      period: 'Đợt thu tháng 10/2023',
      totalAmount: '80.000 đ',
      dueDate: 'Hạn thanh toán: 31/10/2023',
      status: 'Chưa thanh toán',
    ),
  ];

  final List<PaymentInfo> paidPayments = [
    PaymentInfo(
      period: 'Đợt thu tháng 8/2023',
      totalAmount: '580.000 đ',
      dueDate: 'Ngày thanh toán: 10:18, 04/09/2023',
      status: 'Đã thanh toán',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán học phí, khoản thu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildStudentInfo(),
            SizedBox(height: 16),
            _buildSectionTitle('Chưa thanh toán'),
            _buildPaymentList(unpaidPayments),
            SizedBox(height: 16),
            _buildSectionTitle('Đã thanh toán'),
            _buildPaymentList(paidPayments),
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
            _buildInfoRow('Tên học sinh', studentName!),
            _buildInfoRow('Lớp học', className!),
            _buildInfoRow('Mã học sinh', studentCode!),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPaymentList(List<PaymentInfo> payments) {
    return Column(
      children: payments.map((payment) => _buildPaymentCard(payment)).toList(),
    );
  }

  Widget _buildPaymentCard(PaymentInfo payment) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
          title: Text(payment.period),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text('Tổng số tiền: ${payment.totalAmount}'),
              Text(payment.dueDate),
            ],
          ),
          trailing:
          TextButton(
            onPressed: () {
              payment.status == 'Chưa thanh toán' ?

              Get.to(
                PaymentDetailScreen(
                  period: 'Đợt thu tháng 9/2023',
                  studentName: studentName!,
                  className: className!,
                  studentCode: studentCode!,
                  paymentDetails: [
                    PaymentDetail(
                        description: 'Tiền nước uống', amount: '20.000 đ'),
                    PaymentDetail(description: 'Học phí', amount: '50.000 đ'),
                    PaymentDetail(description: 'Nước uống', amount: '30.000 đ'),
                    PaymentDetail(
                        description:
                            'Tiền sử dụng máy lạnh của lớp học có máy lạnh',
                        amount: '35.000 đ'),
                  ],
                  totalAmount: '135.000 đ',
                  paidAmount: '0 đ',
                  unpaidAmount: '135.000 đ',
                  status: 'Chưa thanh toán',
                ),
              ) : "" ;
            },
            child: Text(
              payment.status,
              style: TextStyle(
                color: payment.status == 'Chưa thanh toán'
                    ? Colors.red
                    : Colors.green,
              ),
            ),
          )
      ) ,
    );
  }
}
