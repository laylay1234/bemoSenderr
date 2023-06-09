import 'package:mobileapp/models/ModelProvider.dart';

class BankVerificationEntity {
  User user;
  String loginId;
  String accountId;
  String ip;
  BankVerificationEntity({required this.user, required this.ip, required this.loginId, required this.accountId});
  Map<String, dynamic> toJson() => {
        "partner_parameters": {"login_id": loginId, "account_id": accountId},
        "user_snapshot": {},
      };
}
