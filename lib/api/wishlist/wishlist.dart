class WishList {
  int id;
  String name;
  String color;
  String image;
  int price;
  int salesPrice;
  int productid;
  int accountid;

  WishList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        image = json['image'],
        price = json['price'],
        salesPrice = json['sales_price'],
        productid = json['product_id'],
        accountid = json['account_id'];
}
