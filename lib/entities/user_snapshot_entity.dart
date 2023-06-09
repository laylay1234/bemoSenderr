import 'package:mobileapp/models/ModelProvider.dart';

class UserSnapshotEntity {
  User? user;
  String? origin_iso_code;
  UserSnapshotEntity({this.user, this.origin_iso_code});

  Map<String, dynamic> toJson() => {
        "user_snapshot": {
          "uuid": user!.id,
          "first_name": user!.profile!.first_name,
          "last_name": user!.profile!.last_name,
          "gender": user!.profile!.gender.name,
          "phone_number": user!.phone_number,
          "zip_code": user!.profile!.address!.postal_code,
          "city": user!.profile!.address!.city,
          "state": user!.profile!.address!.state ?? '',
          "address_1": user!.profile!.address!.address_line_1 ?? '',
          "email": user!.email,
          "country": origin_iso_code,
          "state_code": "12345",
          "birth_date": user!.profile!.birth_date!.date_of_birth.getDateTimeInUtc().toString(),
        }
      };
}
