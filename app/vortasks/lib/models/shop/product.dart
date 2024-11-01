class Product {
  final int id;
  final String name;
  final String description;
  final String icon;
  final int coins;
  final int gems;
  final int totalSales;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.coins,
    required this.gems,
    required this.totalSales,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      coins: json['coins'],
      gems: json['gems'],
      totalSales: json['totalSales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'coins': coins,
      'gems': gems,
      'totalSales': totalSales,
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    int? coins,
    int? gems,
    int? totalSales,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      coins: coins ?? this.coins,
      gems: gems ?? this.gems,
      totalSales: totalSales ?? this.totalSales,
    );
  }
}
