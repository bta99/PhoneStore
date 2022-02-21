class NotificationModel {
  int id;
  String content;
  int accountid;
  int orderid;

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        accountid = json['account_id'],
        orderid = json['order_id'];
}
