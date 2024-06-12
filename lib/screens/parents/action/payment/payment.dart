import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/payment/payment_details.dart';
import 'package:project_sem4_flutter_app_mobile/service/transaction_service.dart';
import '../../../../model/transaction_model.dart';

final StudentController studentController = Get.find();

class StudentPaymentScreen extends StatefulWidget {
  const StudentPaymentScreen({super.key});

  @override
  _StudentPaymentScreenState createState() => _StudentPaymentScreenState();
}

class _StudentPaymentScreenState extends State<StudentPaymentScreen> {
  final String? studentName =
      studentController.studentRecord.value.students?.getFullName();
  final String? className =
      studentController.studentRecord.value.schoolYearClass?.className;
  final String? studentCode =
      studentController.studentRecord.value.students?.studentCode;
  Future<List<TransactionModel>>? futureTransactions;

  Future<List<TransactionModel>> getTransactions() async {
    final data = await TransactionService.getTransactions(
        studentController.studentRecord.value.students!.id);
    return data
        .map<TransactionModel>((json) => TransactionModel.fromJson(json))
        .toList();
  }

  String formatCurrency(int amount) {
    final NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return currencyFormatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    futureTransactions = getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán học phí, khoản thu'),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: futureTransactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final transactions = snapshot.data!;
            final groupedTransactions =
                _groupTransactionsByStatus(transactions);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildStudentInfo(),
                  ...groupedTransactions.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(entry.key),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: entry.value.length,
                          itemBuilder: (context, index) {
                            final transaction = entry.value[index];
                            return _buildPaymentCard(transaction);
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Map<String, List<TransactionModel>> _groupTransactionsByStatus(
      List<TransactionModel> transactions) {
    final Map<String, List<TransactionModel>> groupedTransactions = {};
    for (var transaction in transactions) {
      final status = transaction.status ?? 'Không có trạng thái';
      if (groupedTransactions.containsKey(status)) {
        groupedTransactions[status]!.add(transaction);
      } else {
        groupedTransactions[status] = [transaction];
      }
    }
    return groupedTransactions;
  }

  Widget _buildStudentInfo() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Tên học sinh', studentName ?? 'Không có tên'),
            _buildInfoRow('Lớp học', className ?? 'Không có lớp'),
            _buildInfoRow('Mã học sinh', studentCode ?? 'Không có mã'),
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

  Widget _buildPaymentCard(TransactionModel transaction) {
    return Column(children: [
      ListTile(
        title: Text(transaction.feePeriod.title ?? 'Không có tiêu đề'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Tổng số tiền: ${formatCurrency(transaction.total)}'),
            Text(
              'Hạn nộp : ${transaction.feePeriod.endDate!= null ? DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(transaction.feePeriod.endDate!) : 'N/A'}',

              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () {
            Get.to(
              PaymentDetailScreen(
                transactionId: transaction.id,
                period: transaction.feePeriod.title ?? 'Không có tiêu đề',
                studentName: studentName ?? 'Không có tên',
                className: className ?? 'Không có lớp',
                studentCode: studentCode ?? 'Không có mã',
                paymentDetails: transaction.transactionDetails.map((detail) {
                  return PaymentDetail(
                    title: detail.title ?? 'Không có mô tả',
                    price: (detail.price),
                    amount: detail.amount,
                  );
                }).toList(),
                totalAmount: transaction.total,
                paidAmount: transaction.paid,
                unpaidAmount: transaction.total - transaction.paid,
                status: transaction.status ?? 'Không có trạng thái',
              ),
            );
          },
          child: Text(
            transaction.status ?? 'Không có trạng thái',
            style: TextStyle(
              color: transaction.status == 'Chưa thanh toán'
                  ? Colors.red
                  : Colors.green,
            ),
          ),
        ),
      ),
      SizedBox(height: 1,child: Container(
        color: Colors.black,
      ),)
    ]);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
