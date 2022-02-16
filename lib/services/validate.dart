

class Validate {


    String? validateEmail(String? email){
      if (email == null || email.isEmpty){
        return 'Please Enter a Email';
      }
      String pattern = r'\w+@\w+\.\w+';
      RegExp regex =RegExp(pattern);

      if (!regex.hasMatch((email))) {
        return 'Invalid Email Address';
      }
      return null;
    }



    String? validatePassWord(String? password){
      if (password == null || password.isEmpty){
        return 'Please Enter a Password';
      }
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(password)) {
        return '''
           Password must be at least 8 characters,
           include an uppercase letter, number and symbol.
            ''';
      }
      return null;
    }




}