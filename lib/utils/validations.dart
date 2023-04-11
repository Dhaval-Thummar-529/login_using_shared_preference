class validations {
  bool nameValidator(String name) {
    var nameValidation = RegExp(r"^[a-zA-Z]*$");
    if (nameValidation.hasMatch(name)) {
      return true;
    } else {
      return false;
    }
  }

  bool emailValidator(String email) {
    var emailValidation = RegExp(r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-z]+");
    if (emailValidation.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  bool phoneValidator(String phone) {
    var phoneValidation = RegExp(r"^\d{10}$");
    if (phoneValidation.hasMatch(phone)) {
      return true;
    } else {
      return false;
    }
  }

  bool passwordValidator(String password) {
    var passwordValidation = RegExp(
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,25}$");
    if (passwordValidation.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }
}
