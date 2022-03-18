class UserContact {
  late String? id;
  late String userName;
  late String relationship;
  late String phoneNumber;



  UserContact({
    this.id,
    required  this.userName,
    required  this.phoneNumber,
    required this.relationship,

  });

  UserContact.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        userName = json['userName'],
        phoneNumber = json['phoneNumber'],
        relationship = json["relationship"];



  Map<String, dynamic> toJson() => {
    "id": id,
    'userName': userName,
    'phoneNumber': phoneNumber,
    'relationship': relationship,
  };


}