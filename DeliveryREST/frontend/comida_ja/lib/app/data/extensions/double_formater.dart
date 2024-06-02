import 'package:intl/intl.dart';

extension AppDouble on double {
  String toFormat_1() {
    return NumberFormat("#,##0.#", "pt_BR").format(this);
  }

  String toFormat_2() {
    return NumberFormat("#,##0.##", "pt_BR").format(this);
  }
}
