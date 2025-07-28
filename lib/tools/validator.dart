class Validator {
  Validator._();

  static String? nameValidator(String? name) {
    name = name?.trim() ?? ''; // Null ise sağdakini kullan.
    //Eğer name null değilse, trim() fonksiyonunu çağırır.
    //Eğer name null ise, trim() çağrılmaz ve null döner.
    return name.isEmpty ? 'Full name is required' : null;
  }

  static const String _emailPattern =
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

  static String? emailValidator(String? email) {
    email = email?.trim() ?? '';
    return email.isEmpty
        ? 'Email is required'
        : !RegExp(_emailPattern).hasMatch(email)
        ? 'Invalid email format'
        : null;
  }

  static String? passwordValidator(String? password) {
    password = password?.trim() ?? '';

    String errorMessage = '';
    if (password.isEmpty) {
      errorMessage = 'Password is required';
    } else {
      if (password.length < 6) {
        errorMessage = 'Password must be at least 6 characters';
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        errorMessage = '$errorMessage\nMust contain at least one uppercase letter';
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        errorMessage = '$errorMessage\nMust contain at least one lowercase letter';
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        errorMessage = '$errorMessage\nMust contain at least one number';
      }
    }

    return errorMessage.isNotEmpty ? errorMessage.trim() : null;
  }
}

// static, bir sınıfa ait olan alanları (field), metodları (function), ya da değişkenleri tanımlar.
// Yani nesne (object) oluşturmadan da erişilebilir.
// Eğer bir sınıfta static kullanmazsan, o öğeye erişmek için sınıftan bir nesne (instance) oluşturman gerekir.
// Regular Expression / Düzenli İfade), metinlerde arama, eşleşme, filtreleme
// veya doğrulama yapmak için kullanılan çok güçlü bir araçtır. E-posta geçerli mi? Sadece rakam mı? Şifre en az 8 karakter mi?