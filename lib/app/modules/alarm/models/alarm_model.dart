class AlarmModel {
  final String id;
  final int hour;
  final int minute;
  final bool isEnabled;
  final List<int> repeatDays; // 1-7 (周一到周日)
  final String label;
  final String ringtone;
  final bool vibrate;
  final int snoozeMinutes;

  AlarmModel({
    required this.id,
    required this.hour,
    required this.minute,
    this.isEnabled = true,
    this.repeatDays = const [],
    this.label = '',
    this.ringtone = 'default',
    this.vibrate = true,
    this.snoozeMinutes = 5,
  });

  String get timeString {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String get repeatText {
    if (repeatDays.isEmpty) {
      return '仅一次';
    }
    if (repeatDays.length == 7) {
      return '每天';
    }
    if (repeatDays.length == 5 && 
        repeatDays.contains(1) && 
        repeatDays.contains(2) && 
        repeatDays.contains(3) && 
        repeatDays.contains(4) && 
        repeatDays.contains(5)) {
      return '工作日';
    }
    if (repeatDays.length == 2 && 
        repeatDays.contains(6) && 
        repeatDays.contains(7)) {
      return '周末';
    }
    
    const weekDays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return repeatDays.map((day) => weekDays[day - 1]).join('、');
  }

  AlarmModel copyWith({
    String? id,
    int? hour,
    int? minute,
    bool? isEnabled,
    List<int>? repeatDays,
    String? label,
    String? ringtone,
    bool? vibrate,
    int? snoozeMinutes,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      isEnabled: isEnabled ?? this.isEnabled,
      repeatDays: repeatDays ?? this.repeatDays,
      label: label ?? this.label,
      ringtone: ringtone ?? this.ringtone,
      vibrate: vibrate ?? this.vibrate,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': hour,
      'minute': minute,
      'isEnabled': isEnabled,
      'repeatDays': repeatDays,
      'label': label,
      'ringtone': ringtone,
      'vibrate': vibrate,
      'snoozeMinutes': snoozeMinutes,
    };
  }

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      isEnabled: json['isEnabled'] as bool? ?? true,
      repeatDays: (json['repeatDays'] as List<dynamic>?)?.cast<int>() ?? [],
      label: json['label'] as String? ?? '',
      ringtone: json['ringtone'] as String? ?? 'default',
      vibrate: json['vibrate'] as bool? ?? true,
      snoozeMinutes: json['snoozeMinutes'] as int? ?? 5,
    );
  }
}
