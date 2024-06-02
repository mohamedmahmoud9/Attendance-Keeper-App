import 'dart:async';

class WorkingHoursCounter {
  static final StreamController<int> _controller =
      StreamController<int>.broadcast();
  static StreamSubscription<int>? subscription;
  static Stream<int> get stream => _controller.stream;

  static int _seconds = 0;

  static int get seconds => _seconds;

  static Time hoursAndMinutesAndSeconds(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSecondsAfterHours = seconds % 3600;
    int minutes = remainingSecondsAfterHours ~/ 60;
    int remainingSeconds = remainingSecondsAfterHours % 60;

    return Time(hours: hours, minutes: minutes, seconds: remainingSeconds);
  }

  static Timer? timer;

  static void setInitialSeconds(int initialSeconds) {
    _seconds = initialSeconds;
    _controller.sink.add(_seconds);
  }

  static void autoIncrement() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      increment();
    });
  }

  static void increment() {
    _seconds++;

    _controller.sink.add(_seconds);
  }

  static void stopTimer() {
    timer?.cancel();
  }
}

class Time {
  final int hours;
  final int minutes;
  final int seconds;

  Time({required this.hours, required this.minutes, required this.seconds});

  @override
  String toString() {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
