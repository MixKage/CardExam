/*bool validEnglish(String value) {
  RegExp regex = RegExp(r'/^[A-Za-z0-9]*$');
  print(value);
  print(!regex.hasMatch(value));
  return (!regex.hasMatch(value)) ? false : true;
}*/

String? validEmail(String value) {
  if (value.isEmpty) {
    return 'Пустое поле';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Введите Email';
  }
  return null;
}
