class Request {
  String req_id;
  String req_status;
  String req_initial;
  String emp_id;
  String user_id;
  String job_id;

  Request(this.req_id, this.req_status, this.req_initial, this.emp_id,
      this.user_id, this.job_id);

  Request.map(dynamic obj) {
    this.req_id = obj['id'];
    this.req_status = obj['status'];
    this.req_initial = obj['initial'];
    this.emp_id = obj['empId'];
    this.user_id = obj['userId'];
    this.job_id = obj['jobId'];
  }

  String get id => req_id;

  String get status => req_status;

  String get initial => req_initial;

  String get empId => emp_id;

  String get userId => user_id;

  String get jobId => job_id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (req_id != null) {
      map['id'] = req_id;
    }
    map['status'] = req_status;
    map['initial'] = req_initial;
    map['empId'] = emp_id;
    map['userId'] = user_id;
    map['jobId'] = job_id;

    return map;
  }

  Request.fromMap(Map<String, dynamic> map) {
    this.req_id = map['id'];
    this.req_status = map['status'];
    this.req_initial = map['initial'];
    this.emp_id = map['empId'];
    this.user_id = map['userId'];
    this.job_id = map['jobId'];
  }
}
