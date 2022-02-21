class OrderDetail {
  String image;
  String color;
  int price;
  int salesprice;
  int quantity;
  String name;

  OrderDetail.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        color = json['color'],
        price = json['price'],
        salesprice = json['sales_price'],
        name = json['name'],
        quantity = json['quantity'];
}
