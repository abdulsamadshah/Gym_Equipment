class Validator {
  static String? validateEmail(String? value) {
    String patttern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(patttern);
    value = value?.trim();
    if (value == null) {
      return 'Email address cannot be empty';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validateMobile(String? value) {
    String patttern = r'(^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Please enter a valid phone number";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }




  static String? validateAadhar(String? value) {
    // String patttern = r'(^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$)';
    // RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Please enter a valid Aadhar number";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null) {
      return 'Password is required';
    } else if (value.contains(' ')) {
      return 'Password should not contain space';
    } else if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be minimum 6 character';
    } else {
      return null;
    }
  }

  static String? validatePancard(String? value) {
    if (value == null) {
      return "Please enter a valid Pancard";
    } else if (value.isEmpty) {
      return "Please enter a valid Pancard";
    } else {
      return null;
    }
  }

  static String? validateIfsc(String? value) {
    if (value == null) {
      return "Please enter a valid Ifsc code";
    } else if (value.isEmpty) {
      return "Please enter a valid Ifsc code";
    } else {
      return null;
    }
  }

  static String? validateAccountNumber(String? value) {
    if (value == null) {
      return "Please enter a valid Account Number";
    } else if (value.isEmpty) {
      return "Please enter a valid Account Number";
    } else {
      return null;
    }
  }

  static String? validateBankName(String? value) {
    if (value == null) {
      return "Please enter a valid Bank Name";
    } else if (value.isEmpty) {
      return "Please enter a valid Bank Name";
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    String pattern = r'(^[A-Za-z]+([\ A-Za-z]+)*$)';
    RegExp regExp = RegExp(pattern);
    if (value == null || !regExp.hasMatch(value)) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

   static String? validateNumber(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter a valid  number";
    }

  }


  static String? validate(String? value) {

    if (value == null || value.isEmpty) {
      return "Field is required";
    }



  }


  static String? validateaddress(String? value) {

    if (value == null || value.isEmpty) {
      return "Address is required";
    }
    }


}
