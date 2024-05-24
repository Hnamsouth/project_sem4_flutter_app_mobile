import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:project_sem4_flutter_app_mobile/service/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final DioService _dio = DioService();
  bool _isLoading = false;
final data=
  {"amount": 111212, "orderInfo": "hahahaha"};

  Future<void> initiatePayment(dynamic data) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.post(
        '/vn-pay/submitOrder',
        data:data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Ensure responseData is a Map

          final paymentUrl = responseData;
          // Ensure the paymentUrl is a String
            if (await canLaunch(paymentUrl)) {
              await launch(paymentUrl);
            } else {
              throw Exception('Could not launch $paymentUrl');
            }


      } else {
        print('Failed to create payment: ${response.statusMessage}');
        throw Exception('Failed to create payment: ${response.statusMessage}');
      }
    } catch (e) {
      print(e);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VNPay Payment'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  initiatePayment(data);
                },
                child: Text('Pay with VNPay'),
              ),
      ),
    );
  }
}
