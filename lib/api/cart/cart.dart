class Cart {
  int id;
  int quantity;
  int productid;
  int accountid;
  int status;

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'],
        productid = json['product_id'],
        accountid = json['account_id'],
        status = json['status'];
}
