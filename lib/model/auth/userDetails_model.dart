class UserDetail {
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
    this.user,
  });
  late final int id;
  late final String firstname;
  late final String lastname;
  late final String address;
  late final String phone;
  late final String email;
  late final bool gender;
  late final String birthday;
  late final String citizenId;
  late final Null nation;
  late final String avatar;
  late final Null user;

  UserDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    birthday = json['birthday'];
    citizenId = json['citizen_id'];
    nation = null;
    avatar = json['avatar'];
    user = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['birthday'] = birthday;
    _data['citizen_id'] = citizenId;
    _data['nation'] = nation;
    _data['avatar'] = avatar;
    _data['user'] = user;
    return _data;
  }
   fullName(){
    return '$firstname $lastname';
  }
}