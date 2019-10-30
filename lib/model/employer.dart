class Employer {
  String emp_id;
  String emp_name;
  String emp_phone;
  String emp_email;
  String emp_address;
  String emp_about;
  String emp_like;

  String emp_img;

  Employer(this.emp_id, this.emp_name, this.emp_phone, this.emp_email,
      this.emp_address, this.emp_about, this.emp_like, this.emp_img);

  Employer.map(dynamic obj) {
    this.emp_id = obj['id'];
    this.emp_name = obj['name'];
    this.emp_phone = obj['phone'];
    this.emp_email = obj['email'];
    this.emp_address = obj['address'];
    this.emp_about = obj['about'];
    this.emp_like = obj['like'];
    this.emp_img = obj['img'];
  }

  String get id => emp_id;

  String get name => emp_name;

  String get phone => emp_phone;

  String get email => emp_email;

  String get address => emp_address;

  String get about => emp_about;

  String get like => emp_like;

  String get img => emp_img;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (emp_id != null) {
      map['id'] = emp_id;
    }
    map['name'] = emp_name;
    map['phone'] = emp_phone;
    map['email'] = emp_email;
    map['address'] = emp_address;
    map['about'] = emp_about;
    map['like'] = emp_like;
    map['img'] = emp_img;

    return map;
  }

  Employer.fromMap(Map<String, dynamic> map) {
    this.emp_id = map['id'];
    this.emp_name = map['name'];
    this.emp_phone = map['phone'];
    this.emp_email = map['email'];
    this.emp_address = map['address'];
    this.emp_like = map['like'];
    this.emp_img = map['img'];
  }
}
