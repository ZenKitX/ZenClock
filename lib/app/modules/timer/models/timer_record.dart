class TimerRecord {
  final int lapNumber;
  final Duration lapTime;
  final Duration totalTime;

  TimerRecord({
    required this.lapNumber,
    required this.lapTime,
    required this.totalTime,
  });

  String get lapTimeString {
    return _formatDuration(lapTime);
  }

  String get totalTimeString {
    return _formatDuration(totalTime);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final milliseconds = (duration.inMilliseconds.remainder(1000) / 10).floor();

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }
}
