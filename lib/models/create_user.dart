class User {
  String mail;
  String username;
  String password;
  String universe;
  int course;

  User(this.mail, this.username, this.password, this.universe, this.course);

  Map<String, dynamic> toJson() => {
        'Email': mail,
        'Username': username,
        'Password': password,
        'University': universe,
        'Course': course,
        'Role': 'admin'
  };
}
