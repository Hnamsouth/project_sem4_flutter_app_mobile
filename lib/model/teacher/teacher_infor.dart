class TeacherInfo {
  int? id;
  String? fullName;
  String? sortName;
  bool? gender;
  String? officerNumber;
  String? phone;
  String? birthday;
  String? email;

  TeacherInfo(
      {this.id,
        this.fullName,
        this.sortName,
        this.gender,
        this.officerNumber,
        this.phone,
        this.birthday,
        this.email});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    sortName = json['sortName'];
    gender = json['gender'];
    officerNumber = json['officerNumber'];
    phone = json['phone'];
    birthday = json['birthday'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['sortName'] = this.sortName;
    data['gender'] = this.gender;
    data['officerNumber'] = this.officerNumber;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    return data;
  }
}
