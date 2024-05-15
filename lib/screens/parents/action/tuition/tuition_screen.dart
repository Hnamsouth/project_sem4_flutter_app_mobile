import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';


import 'package:project_sem4_flutter_app_mobile/screens/widgets/my_button.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class TuitionScreen extends StatefulWidget {
  const TuitionScreen({super.key});

  @override
  State<TuitionScreen> createState() => _TuitionScreenState();
}

class _TuitionScreenState extends State<TuitionScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> test = <int>[600000, 700000, 800000];







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Học phí,Khoản thu"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Số còn phải nộp",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${test.sum}đ",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
                padding: EdgeInsets.all(15),
                height: 250,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.separated(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Entry ${entries[index]}'),
                            Text('${test[index].toString()}'),
                          ]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.separated(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Entry ${entries[index]}'),
                          Text('${test[index].toString()}'),
                        ]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            TextButton(
              onPressed: () async {
              },
              child: const Text('Thanh Toán  '),
            ),
            // MyButton(onPressed: () {
            //
            // }, buttonText: "Thanh Toán")
          ],
        ),
      ),
    );
  }
}





