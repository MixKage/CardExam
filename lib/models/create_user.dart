class User {
  String mail;
  String username;
  String password;
  String universe;
  int course;

  User(this.mail, this.username, this.password, this.universe, this.course);

  Map<String, dynamic> toJson() => {
        'mail': mail,
        'login': username,
        'password': password,
        'university': universe,
        'course': course,
      };
}
