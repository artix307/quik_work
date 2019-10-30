import 'package:quik_work/model/employer.dart';

class User {
  String user_id;
  String user_name;
  String user_email;
  String user_phone;
  String user_gender;
  String user_dob;
  String user_edu;
  List user_bkm;

  User(this.user_id, this.user_name, this.user_email, this.user_phone,
      this.user_gender, this.user_dob, this.user_edu, this.user_bkm);

  User.map(dynamic obj) {
    this.user_id = obj['id'];
    this.user_name = obj['name'];
    this.user_email = obj['email'];
    this.user_phone = obj['phone'];
    this.user_gender = obj['gender'];
    this.user_dob = obj['dob'];
    this.user_edu = obj['edu'];
    this.user_edu = obj['bkm'];
  }

  String get id => user_id;

  String get name => user_name;

  String get email => user_email;

  String get phone => user_phone;

  String get gender => user_gender;

  String get dob => user_dob;

  String get edu => user_edu;

  List get bkm => user_bkm;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (user_id != null) {
      map['id'] = user_id;
    }
    map['name'] = user_name;
    map['email'] = user_email;
    map['phone'] = user_phone;
    map['gender'] = user_gender;
    map['dob'] = user_dob;
    map['edu'] = user_edu;
    map['bkm'] = user_bkm;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.user_id = map['id'];
    this.user_name = map['name'];
    this.user_email = map['email'];
    this.user_phone = map['phone'];
    this.user_gender = map['gender'];
    this.user_dob = map['dob'];
    this.user_edu = map['edu'];
    this.user_bkm = map['bkm'];
  }
}
