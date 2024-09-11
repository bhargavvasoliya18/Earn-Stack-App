String? validateName(String? value) {
  String pattern = r'\p{L}';
  RegExp regExp = RegExp(pattern,unicode: true);
  if (value?.isEmpty??false) {
    return "Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be A-Z";
  }
  return null;
}

String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return "Password must be longer than 5 characters";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return "Enter a valid email address";
  } else {
    return null;
  }
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return "Password does not match";
  } else if (confirmPassword?.isEmpty??false) {
    return "Confirm password is required";
  } else {
    return null;
  }
}

String? validateEmpty(String? value) {
  if (value!.isEmpty) {
    return "This field must not be empty";
  } else {
    return null;
  }
}
