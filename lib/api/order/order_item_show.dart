class OrderItem {
  int id;
  String address;
  String phone;
  int total;
  String status;
  String fullname;
  int accountid;
  String datecreate;

  OrderItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        phone = json['phone'],
        total = json['total'],
        status = json['status'],
        fullname = json['fullname'],
        accountid = json['account_id'],
        datecreate = json['date_create'];
}
