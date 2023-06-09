class AvailableOriginCountry {
  String? iso_code;
  String? name;
  AvailableOriginCountry({this.iso_code, this.name});

  factory AvailableOriginCountry.fromJson(Map<String, dynamic> json) => AvailableOriginCountry(iso_code: json['iso_code'], name: json['name']);

  Map<String, String> toJson() => {'iso_code': this.iso_code!, 'name': this.name!};
}
