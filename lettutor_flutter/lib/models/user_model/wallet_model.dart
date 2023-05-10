class Wallet {
  late String id;
  late String userId;
  late String amount;
  late bool isBlocked;
  late String createdAt;
  late String updatedAt;
  late int bonus;

  Wallet(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.isBlocked,
      required this.createdAt,
      required this.updatedAt,
      required this.bonus});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['amount'] = amount;
    data['isBlocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bonus'] = bonus;
    return data;
  }
}
