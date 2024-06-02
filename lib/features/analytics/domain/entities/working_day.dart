import '../../../home/data/datasources/working_details_remote_data_source.dart';

class WorkingDay {
  List<Slot> daySlots;
  DateTime dateTime;

  WorkingDay({required this.daySlots, required this.dateTime});
  int get totalWorkingHours {
    int total = 0;
    for (final slot in daySlots) {
      if (slot.end != null) {
        total += slot.end!.toDate().difference(slot.start.toDate()).inSeconds;
      } else {
        total += DateTime.now().difference(slot.start.toDate()).inSeconds;
      }
    }
    return total;
  }

  List<String> getAllTasks() => daySlots
      .where((slot) => slot.tasks != null)
      .map((slot) => slot.tasks!)
      .toList();
}
