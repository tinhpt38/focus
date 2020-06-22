class User {
  final String userName;
  final String fullName;
  final String email;
  final String password;
  final String address;
  final String phone;
  final String website;
  final String id;
  final List<String> rooms;
  final dynamic role;

  User(
      {this.userName,
      this.fullName,
      this.email,
      this.password,
      this.address,
      this.phone,
      this.website,
      this.id,
      this.rooms,
      this.role});

  User.formJson(Map<String, dynamic> json)
      : this.userName = json['username'],
        this.fullName = json['fullName'],
        this.email = json['email'],
        this.password = json['password'],
        this.address = json['address'],
        this.phone = json['phone'],
        this.id = json['_id'],
        this.website = json['website'],
        this.rooms = json['rooms'],
        this.role = json['role'];

  Map<String, dynamic> toJson() => {
        'username': this.userName,
        'fullName': this.fullName,
        'email': this.email,
        'password': this.password,
        'address': this.address,
        'phone': this.phone,
        'rooms': this.rooms,
        'website':this.website,
        '_id': this.id,
        'role':this.role
      };
}
