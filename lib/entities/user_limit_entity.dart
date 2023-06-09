class UserLimitEntity {
  String? tx_max;
  String? monthly_max;
  String? quarterly_max;
  String? yearly_max;
  UserLimitEntity({this.monthly_max, this.quarterly_max, this.tx_max, this.yearly_max});

  factory UserLimitEntity.fromJson(Map<String, String> json) =>
      UserLimitEntity(tx_max: json['tx_max'], monthly_max: json['monthly_max'], quarterly_max: json['quarterly_max'], yearly_max: json['yearly_max']);

  bool isValid() {
    return ((tx_max != null && tx_max!.isNotEmpty) &&
        (monthly_max != null && monthly_max!.isNotEmpty) &&
        (quarterly_max != null && quarterly_max!.isNotEmpty) &&
        (yearly_max != null && yearly_max!.isNotEmpty));
  }
}
