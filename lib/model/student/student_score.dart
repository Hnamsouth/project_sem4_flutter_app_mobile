// import 'package:project_sem4_flutter_app_mobile/model/student/point_model.dart';
//
// class StudentScores {
//   StudentScores({
//     required this.DTB,
//     required this.KTGIUAKY,
//     required this.KTCUOIKY,
//     required this.KTTX,
//   });
//
//   late final List<StudentPoint> DTB;
//   late final List<StudentPoint> KTGIUAKY;
//   late final List<StudentPoint> KTCUOIKY;
//   late final List<StudentPoint> KTTX;
//
//   StudentScores.fromJson(Map<String, dynamic> json) {
//     DTB = List.from(json['DTB']).map((e) => StudentPoint.fromJson(e)).toList();
//     KTGIUAKY = List.from(json['KT_GIUA_KY'])
//         .map((e) => StudentPoint.fromJson(e))
//         .toList();
//     KTCUOIKY = List.from(json['KT_CUOI_KY'])
//         .map((e) => StudentPoint.fromJson(e))
//         .toList();
//     KTTX =
//         List.from(json['KTTX']).map((e) => StudentPoint.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['DTB'] = DTB.map((e) => e.toJson()).toList();
//     _data['KT_GIUA_KY'] = KTGIUAKY.map((e) => e.toJson()).toList();
//     _data['KT_CUOI_KY'] = KTCUOIKY.map((e) => e.toJson()).toList();
//     _data['KTTX'] = KTTX.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }
