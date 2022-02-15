import 'package:app_grupohdi/core/Checks.dart';

class ClockIn {
  DateTime data;
  Checks today, yesterday;

  ClockIn(this.data, this.today, this.yesterday);
}
