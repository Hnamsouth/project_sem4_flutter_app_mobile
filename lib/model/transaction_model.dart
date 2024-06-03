class TransactionModel {
  final int id;
  final String? transactionCode;
  final int total;
  final int paid;
  final String? status;
  final FeePeriod feePeriod;
  final List<TransactionDetail> transactionDetails;

  TransactionModel({
    required this.id,
    required this.transactionCode,
    required this.total,
    required this.paid,
    required this.status,

    required this.feePeriod,
    required this.transactionDetails,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionCode: json['transactionCode'],
      total: (json['total'] as num).toInt(), // Ensure the value is an integer
      paid: (json['paid'] as num).toInt(), // Ensure the value is an integer
      status: json['status'],
      feePeriod: FeePeriod.fromJson(json['feePeriod']),
      transactionDetails: (json['transactionDetails'] as List<dynamic>)
          .map((e) => TransactionDetail.fromJson(e))
          .toList(),
    );
  }
}

class FeePeriod {
  final int id;
  final String? title;
  final String? content;
  final bool status;
  final DateTime endDate;

  final String statusCode;
  final DateTime createdAt;

  FeePeriod({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.endDate,

    required this.statusCode,
    required this.createdAt,
  });

  factory FeePeriod.fromJson(Map<String, dynamic> json) {
    return FeePeriod(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
      statusCode: json['statusCode'],
      endDate: DateTime.parse(json['endDate']),

      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class TransactionDetail {
  final int id;
  final String? title;
  final String? description;
  final int amount;
  final int price;

  TransactionDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.price,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      id: json['id'],
      title: json['title'],
      description: json['description'],

      amount: (json['amount'] as num).toInt(), // Ensure the value is an integer
      price: (json['price'] as num).toInt(), // Ensure the value is an integer
    );
  }
}