class User {
  //todo: is finish
  int id;
  String firstName;
  String lastName;
  String email;
  String status;
  String image;
  String role;

  String apiToken;

  User(this.id, this.firstName, this.lastName, this.email, this.status,
      this.image, this.role, this.apiToken);

  User.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];

    this.firstName = jsonObject['first_name'];

    this.lastName = jsonObject['last_name'];

    this.email = jsonObject['email'];

    this.status = jsonObject['status'];

    this.image = jsonObject['featured_image_id'];

    this.role = jsonObject['role'];

    this.apiToken = jsonObject['api_token'];
  }
}
