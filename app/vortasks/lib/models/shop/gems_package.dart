class GemsPackage {
  final int id;
  final String name;
  final String icon;
  final int gems;
  final double money;
  final double discountPercentage;
  final double totalPrice;

  GemsPackage({
    required this.id,
    required this.name,
    required this.icon,
    required this.gems,
    required this.money,
    required this.discountPercentage,
    required this.totalPrice,
  });

  factory GemsPackage.fromJson(Map<String, dynamic> json) {
    return GemsPackage(
      id: json['id'],
      name: json['nameOfPackage'],
      icon: json['icon'],
      gems: json['gems'],
      money: json['money'],
      discountPercentage: json['discountPercentage'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOfPackage': name,
      'icon': icon,
      'gems': gems,
      'money': money,
      'discountPercentage': discountPercentage,
      'totalPrice': totalPrice,
    };
  }
}
