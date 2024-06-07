//
// import 'dart:convert';
//
// import 'package:project_sem4_flutter_app_mobile/service/api_service.dart';
//
// import '../model/take_leave_model.dart';
//
// class TakeLeaveService{
//
//   Future<void> submitLeaveRequest(TakeLeave takeLeave) async {
//     final response = await DioService().post("/student/take-leave",data: takeLeave);
//
//     if (response.statusCode == 200) {
//       print('Leave request submitted successfully');
//     } else {
//       print('Failed to submit leave request: ${response.statusCode}');
//     }
//   }
//
//
//
//
//
// }