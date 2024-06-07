class TakeLeave {
  int? studentYearInfoId;
  int? userId;
  String? note;
  String? startDate;
  String? endDate;

  TakeLeave(
      {this.studentYearInfoId,
        this.userId,
        this.note,
        this.startDate,
        this.endDate});

  TakeLeave.fromJson(Map<String, dynamic> json) {
    studentYearInfoId = json['studentYearInfoId'];
    userId = json['userId'];
    note = json['note'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentYearInfoId'] = this.studentYearInfoId;
    data['userId'] = this.userId;
    data['note'] = this.note;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
