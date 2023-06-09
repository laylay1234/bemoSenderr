class AvailableCountry {
  String? name;
  bool? is_active;
  String? iso_code;
  String? currency_code;
  String? currency_sign;
  AvailableCountry({this.name, this.is_active, this.iso_code, this.currency_code, this.currency_sign});

  Map<String, dynamic> toJson() =>
      {'name': name, 'currency_sign': currency_sign, 'is_active': is_active, 'iso_code': iso_code, 'currency_code': currency_code};

  factory AvailableCountry.fromJson(Map<String, dynamic> json) => AvailableCountry(
      currency_sign: json['currency_sign'],
      currency_code: json['currency_code'],
      name: json['name'],
      is_active: json['is_active'],
      iso_code: json['iso_code']);

  bool isValid() {
    return ((name != null) || (iso_code != null) || (is_active != null));
  }

  bool isEqualeTo(AvailableCountry obj) {
    return ((name == obj.name) && (is_active == obj.is_active) && (iso_code == obj.iso_code));
  }
}