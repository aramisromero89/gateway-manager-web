String? emptyValidator(String? text) {
  if (text == null || text.isEmpty) {
    return "Can't be empty";
  }
  return null;
}

String? passwordValidator(String? text) {
  if (text == null || text.length < 8) {
    return "Must have at leat 8 characters";
  }
  return null;
}
