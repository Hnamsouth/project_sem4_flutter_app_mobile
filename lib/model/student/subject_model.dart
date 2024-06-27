class Subject {
  int? id;
  String? code;
  String? type;
  String? subjectPointType;
  String? description;
  String? name;
  bool? numberType;

  Subject(
      {this.id,
        this.code,
        this.type,
        this.subjectPointType,
        this.description,
        this.name,
        this.numberType});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    subjectPointType = json['subjectPointType'];
    description = json['description'];
    name = json['name'];
    numberType = json['numberType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['subjectPointType'] = this.subjectPointType;
    data['description'] = this.description;
    data['name'] = this.name;
    data['numberType'] = this.numberType;
    return data;
  }
}
