/// Валидаторы форм (ТЗ §5.1.1). Возвращают текст ошибки или `null`, если поле
/// валидно — совместимо с `TextFormField.validator`.
class Validators {
  const Validators._();

  static final RegExp _emailRegExp =
      RegExp(r'^[\w.\-+]+@([\w\-]+\.)+[\w\-]{2,}$');

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Введите email';
    if (!_emailRegExp.hasMatch(v)) return 'Некорректный email';
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Введите пароль';
    if (v.length < 6) return 'Минимум 6 символов';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if ((value ?? '').isEmpty) return 'Повторите пароль';
    if (value != original) return 'Пароли не совпадают';
    return null;
  }

  static String? required(String? value, {String message = 'Обязательное поле'}) {
    if ((value ?? '').trim().isEmpty) return message;
    return null;
  }
}
