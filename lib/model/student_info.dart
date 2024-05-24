
class StudentStatus {
  int id;
  String description;
  DateTime createdAt;
  DateTime? endAt;
  Status status;

  StudentStatus({
    required this.id,
    required this.description,
    required this.createdAt,
    this.endAt,
    required this.status,
  });

  factory StudentStatus.fromJson(Map<String, dynamic> json) => StudentStatus(
    id: json['id'],
    description: json['description'],
    createdAt: DateTime.parse(json['createdAt']),
    endAt: json['endAt'] != null ? DateTime.parse(json['endAt']) : null,
    status: Status.fromJson(json['status']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'endAt': endAt?.toIso8601String(),
    'status': status.toJson(),
  };
}

class Status {
  int id;
  String name;
  String code;
  String? color;

  Status({
    required this.id,
    required this.name,
    required this.code,
    this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json['id'],
    name: json['name'],
    code: json['code'],
    color: json['color'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'color': color,
  };
}

class StudentInfo {
  int id;
  bool gender;
  String firstName;
  String lastName;
  DateTime birthday;
  String address;
  String studentCode;
  DateTime? createdAt;
  List<StudentStatus> studentStatuses;

  StudentInfo({
    required this.id,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.address,
    required this.studentCode,
    this.createdAt,
    required this.studentStatuses,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
    id: json['id'],
    gender: json['gender'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    birthday: DateTime.parse(json['birthday']),
    address: json['address'],
    studentCode: json['studentCode'],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    studentStatuses: List<StudentStatus>.from(
        json['studentStatuses'].map((x) => StudentStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'gender': gender,
    'firstName': firstName,
    'lastName': lastName,
    'birthday': birthday.toIso8601String(),
    'address': address,
    'studentCode': studentCode,
    'createdAt': createdAt?.toIso8601String(),
    'studentStatuses': List<dynamic>.from(studentStatuses.map((x) => x.toJson())),
  };

  getFullName(){
    return '$firstName $lastName';
  }
}

class UserDetail {
  int id;
  String firstname;
  String lastname;
  String address;
  String phone;
  String email;
  bool gender;
  DateTime birthday;
  String citizenId;
  String? nation;
  String avatar;

  UserDetail({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phone,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.citizenId,
    this.nation,
    required this.avatar,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json['id'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    address: json['address'],
    phone: json['phone'],
    email: json['email'],
    gender: json['gender'],
    birthday: DateTime.parse(json['birthday']),
    citizenId: json['citizen_id'],
    nation: json['nation'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'address': address,
    'phone': phone,
    'email': email,
    'gender': gender,
    'birthday': birthday.toIso8601String(),
    'citizen_id': citizenId,
    'nation': nation,
    'avatar': avatar,
  };
}

class User {
  int id;
  String username;
  String password;
  String realPassword;
  String? token;
  DateTime createdAt;
  List<UserDetail> userDetail;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.realPassword,
    this.token,
    required this.createdAt,
    required this.userDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    password: json['password'],
    realPassword: json['realPassword'],
    token: json['token'],
    createdAt: DateTime.parse(json['createdAt']),
    userDetail: List<UserDetail>.from(json['userDetail'].map((x) => UserDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
    'realPassword': realPassword,
    'token': token,
    'createdAt': createdAt.toIso8601String(),
    'userDetail': List<dynamic>.from(userDetail.map((x) => x.toJson())),
  };
}

class Teacher {
  int id;
  String officerNumber;
  String sortName;
  DateTime joiningDate;
  bool active;
  int? positionId;
  List<dynamic> departments;
  User user;

  Teacher({
    required this.id,
    required this.officerNumber,
    required this.sortName,
    required this.joiningDate,
    required this.active,
    this.positionId,
    required this.departments,
    required this.user,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json['id'],
    officerNumber: json['officerNumber'],
    sortName: json['sortName'],
    joiningDate: DateTime.parse(json['joiningDate']),
    active: json['active'],
    positionId: json['positionId'],
    departments: List<dynamic>.from(json['departments'].map((x) => x)),
    user: User.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'officerNumber': officerNumber,
    'sortName': sortName,
    'joiningDate': joiningDate.toIso8601String(),
    'active': active,
    'positionId': positionId,
    'departments': List<dynamic>.from(departments.map((x) => x)),
    'user': user.toJson(),
  };
}

class Grade {
  int id;
  String name;

  Grade({
    required this.id,
    required this.name,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Room {
  int id;
  String name;

  Room({
    required this.id,
    required this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class SchoolYear {
  int id;
  DateTime startSem1;
  DateTime startSem2;
  DateTime end;

  SchoolYear({
    required this.id,
    required this.startSem1,
    required this.startSem2,
    required this.end,
  });

  factory SchoolYear.fromJson(Map<String, dynamic> json) => SchoolYear(
    id: json['id'],
    startSem1: DateTime.parse(json['startSem1']),
    startSem2: DateTime.parse(json['startSem2']),
    end: DateTime.parse(json['end']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'startSem1': startSem1.toIso8601String(),
    'startSem2': startSem2.toIso8601String(),
    'end': end.toIso8601String(),
  };
}

class TeacherSchoolYear {
  int id;
  Teacher teacher;
  SchoolYear schoolYear;

  TeacherSchoolYear({
    required this.id,
    required this.teacher,
    required this.schoolYear,
  });

  factory TeacherSchoolYear.fromJson(Map<String, dynamic> json) => TeacherSchoolYear(
    id: json['id'],
    teacher: Teacher.fromJson(json['teacher']),
    schoolYear: SchoolYear.fromJson(json['schoolYear']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'teacher': teacher.toJson(),
    'schoolYear': schoolYear.toJson(),
  };
}

class SchoolYearClass {
  int id;
  String className;
  String classCode;
  Grade grade;
  Room room;
  TeacherSchoolYear teacherSchoolYear;
  SchoolYear schoolYear;

  SchoolYearClass({
    required this.id,
    required this.className,
    required this.classCode,
    required this.grade,
    required this.room,
    required this.teacherSchoolYear,
    required this.schoolYear,
  });

  factory SchoolYearClass.fromJson(Map<String, dynamic> json) => SchoolYearClass(
    id: json['id'],
    className: json['className'],
    classCode: json['classCode'],
    grade: Grade.fromJson(json['grade']),
    room: Room.fromJson(json['room']),
    teacherSchoolYear: TeacherSchoolYear.fromJson(json['teacherSchoolYear']),
    schoolYear: SchoolYear.fromJson(json['schoolYear']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'className': className,
    'classCode': classCode,
    'grade': grade.toJson(),
    'room': room.toJson(),
    'teacherSchoolYear': teacherSchoolYear.toJson(),
    'schoolYear': schoolYear.toJson(),
  };
}

class StudentRecord {
  int? id;
  DateTime? createdAt;
  StudentInfo? students;
  SchoolYearClass? schoolYearClass;

  StudentRecord({
     this.id,
    this.createdAt,
     this.students,
     this.schoolYearClass,
  });

  factory StudentRecord.fromJson(Map<String, dynamic> json) => StudentRecord(
    id: json['id'],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    students: StudentInfo.fromJson(json['students']),
    schoolYearClass: SchoolYearClass.fromJson(json['schoolYearClass']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt?.toIso8601String(),
    'students': students?.toJson(),
    'schoolYearClass': schoolYearClass?.toJson(),
  };
}
