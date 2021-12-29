class Cartitem {
  int id;
  int quantity;
  int productid;
  int accountid;
  String color;
  String image;
  int price;
  int salesprice;
  int stock;

  Cartitem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'],
        productid = json['product_id'],
        accountid = json['account_id'],
        color = json['color'],
        image = json['image'],
        price = json['price'],
        salesprice = json['sales_price'],
        stock = json['stock'];
}
