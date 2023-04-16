import 'package:device_calendar/device_calendar.dart';

/// 在系统日历中添加一个事件
void addEventToCalendar({
  required String title,
  String? description,
  required DateTime start,
  DateTime? end,
  int? reminder = 0,
}) async {
  TZDateTime startTZ = TZDateTime.utc(
    start.year,
    start.month,
    start.day,
    start.hour,
    start.minute,
    start.second,
  ).add(const Duration(hours: -8));
  TZDateTime endTZ;
  if (end == null) {
    endTZ = startTZ.add(const Duration(hours: 1));
  } else {
    endTZ = TZDateTime.utc(
      end.year,
      end.month,
      end.day,
      end.hour,
      end.minute,
      end.second,
    ).add(const Duration(hours: -8));
  }
  Event event = Event(
    '1',
    title: title,
    description: description,
    start: startTZ,
    end: endTZ,
    reminders: [Reminder(minutes: reminder)],
  );
  await DeviceCalendarPlugin().createOrUpdateEvent(event);
}

/// 在系统日历中添加一个全天事件
void addAllDayEventToCalendar({
  required String title,
  String? description,
  required DateTime date,
  int? reminder = 9,
}) async {
  TZDateTime tz = TZDateTime.utc(date.year, date.month, date.day)
      .add(const Duration(hours: -8));
  Event event = Event(
    '1',
    title: title,
    description: description,
    allDay: true,
    start: tz,
    end: tz,
    reminders: [Reminder(minutes: reminder)],
  );
  await DeviceCalendarPlugin().createOrUpdateEvent(event);
}
