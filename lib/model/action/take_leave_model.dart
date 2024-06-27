
class TakeLeave {
  int? id;
  int? studentYearInfoId;
  int? userId;
  String? note;
  final DateTime? startDate;
  final DateTime? endDate;
  DateTime? createdAt;
  String? status;
  String? statusName;

  TakeLeave({
    this.id,
    this.studentYearInfoId,
    this.userId,
    this.note,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.status,
    this.statusName,
  });


  factory TakeLeave.fromJson(Map<String, dynamic> json) {
    return TakeLeave(
      id: json['id'],
      note: json['note'],
      userId : json['userId'],

      studentYearInfoId : json['studentYearInfoId'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      status: json['status'],
      statusName: json['statusName'],

    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['studentYearInfoId'] = studentYearInfoId;
    data['userId'] = userId;
    data['startDate'] = startDate?.toIso8601String();
    data['endDate'] = endDate?.toIso8601String();
    data['createdAt'] = createdAt?.toIso8601String();
    data['status'] = status;
    data['statusName'] = statusName;
    return data;
  }
}
