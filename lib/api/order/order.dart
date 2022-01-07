class Order {
  int id;
  String address;
  String phone;
  int total;
  String status;
  int accountid;

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        phone = json['phone'],
        total = json['total'],
        status = json['status'],
        accountid = json['account_id'];
}
