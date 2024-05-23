import 'dart:async';

class WorkingHoursCounter {
  static final StreamController<int> _controller =
      StreamController<int>.broadcast();
  static StreamSubscription<int>? subscription;
  static Stream<int> get stream => _controller.stream;

  // static int _hours = 0;
  // static int _minutes = 0;
  static int _seconds = 0;

  static int get seconds => _seconds;

  static String hoursAndMinutesAndSeconds(int seconds) =>
      '${seconds ~/ 3600}:${(seconds % 3600) ~/ 60}:${seconds % 60}';

  static Timer? timer;

  static void setInitialSeconds(int initialSeconds) {
    _seconds = initialSeconds;
    _controller.sink.add(_seconds);
  }

  // static void listen() {
  //   subscription = _controller.stream.listen((event) {
  // if (event is StartWorkSuccess) {
  //     autoIncrement();
  //   }
  // },
  //       );
  // }

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
