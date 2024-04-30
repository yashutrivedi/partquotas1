class UserData {
  final String dob;
  final String gender;
  final String mobileNo;
  final String name;
  final String type;

  UserData({
    required this.dob,
    required this.gender,
    required this.mobileNo,
    required this.name,
    required this.type,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dob': dob,
      'gender': gender,
      'mobileNo': mobileNo,
      'name': name,
      'type': type,
    };
  }
}
