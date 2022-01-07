class Comment {
  int id;
  String content;
  int rating;
  int accountid;
  int productid;
  String image;
  String fullname;

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        rating = json['rating'],
        accountid = json['account_id'],
        productid = json['product_id'],
        image = json['image'],
        fullname = json['fullname'];
}
