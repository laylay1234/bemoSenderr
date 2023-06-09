class UserBankVerifyResponse {
  String? firstName;
  String? lastName;
  String? address_1;
  String? city;
  String? state;
  String? zipCode;
  String? email;

  UserBankVerifyResponse({this.address_1, this.city, this.email, this.firstName, this.lastName, this.state, this.zipCode});

  factory UserBankVerifyResponse.fromJson(Map<String, dynamic> json) => UserBankVerifyResponse(
      firstName: json['user_data']['first_name'] ?? '',
      lastName: json['user_data']['last_name'] ?? '',
      address_1: json['user_data']['address_1'] ?? '',
      city: json['user_data']['city'] ?? '',
      state: json['user_data']['state'] ?? '',
      zipCode: json['user_data']['zip_code'] ?? '',
      email: json['user_data']['email'] ?? '');
}
