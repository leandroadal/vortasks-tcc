import 'package:vortasks/models/enums/payment_status.dart';

class GemsTransaction {
  final String id;
  final PaymentStatus status;
  final double price;
  final DateTime purchaseDate;
  final String? errorMessage;

  GemsTransaction({
    required this.id,
    required this.status,
    required this.price,
    required this.purchaseDate,
    this.errorMessage,
  });

  factory GemsTransaction.fromJson(Map<String, dynamic> json) {
    return GemsTransaction(
      id: json['id'],
      status: PaymentStatus.values
          .byName(json['status']), // Converte a string para enum
      price: json['price'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.name, // Converte o enum para string
      'price': price,
      'purchaseDate': purchaseDate.toIso8601String(),
      'errorMessage': errorMessage,
    };
  }
}
