import 'dart:developer' as devtools show log;

mixin Logger {
  void devtoolsLog(String message) {
    devtools.log(message);
  }
}
