class ShoesModel {
  int id;
  String image;
  String name;
  String description;
  double price;
  String color;
  bool isSelected = false;

  ShoesModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.price,
      required this.color});

  factory ShoesModel.fromJson(Map<String, dynamic> json){
    return ShoesModel(
        id: (json['id']!=null) ? json['id']:0,
        name:(json['name']!=null) ? json['name']:'' ,
        image: (json['image']!=null) ? json['image']:'',
        description: (json['description']!=null) ? json['description']:'',
        price: (json['price']!=null) ?json['price']:0.0,
        color: (json['color']!=null) ? json['color']:''
    );
  }
}
