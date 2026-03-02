class TimezoneModel {
  final String id;
  final String cityName;
  final String countryName;
  final String timezone;
  final int offsetHours;
  final int offsetMinutes;

  TimezoneModel({
    required this.id,
    required this.cityName,
    required this.countryName,
    required this.timezone,
    required this.offsetHours,
    this.offsetMinutes = 0,
  });

  String get displayName => '$cityName, $countryName';

  String get offsetString {
    final sign = offsetHours >= 0 ? '+' : '';
    if (offsetMinutes == 0) {
      return 'UTC$sign$offsetHours';
    }
    return 'UTC$sign$offsetHours:${offsetMinutes.abs().toString().padLeft(2, '0')}';
  }

  DateTime getLocalTime(DateTime utcTime) {
    return utcTime.add(Duration(
      hours: offsetHours,
      minutes: offsetMinutes,
    ));
  }

  int get timeDifferenceFromLocal {
    final localOffset = DateTime.now().timeZoneOffset.inHours;
    return offsetHours - localOffset;
  }

  String get timeDifferenceString {
    final diff = timeDifferenceFromLocal;
    if (diff == 0) return '本地时间';
    final sign = diff > 0 ? '+' : '';
    return '$sign$diff 小时';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'countryName': countryName,
      'timezone': timezone,
      'offsetHours': offsetHours,
      'offsetMinutes': offsetMinutes,
    };
  }

  factory TimezoneModel.fromJson(Map<String, dynamic> json) {
    return TimezoneModel(
      id: json['id'] as String,
      cityName: json['cityName'] as String,
      countryName: json['countryName'] as String,
      timezone: json['timezone'] as String,
      offsetHours: json['offsetHours'] as int,
      offsetMinutes: json['offsetMinutes'] as int? ?? 0,
    );
  }

  // 常用城市列表
  static List<TimezoneModel> get popularCities => [
        TimezoneModel(
          id: 'beijing',
          cityName: '北京',
          countryName: '中国',
          timezone: 'Asia/Shanghai',
          offsetHours: 8,
        ),
        TimezoneModel(
          id: 'tokyo',
          cityName: '东京',
          countryName: '日本',
          timezone: 'Asia/Tokyo',
          offsetHours: 9,
        ),
        TimezoneModel(
          id: 'london',
          cityName: '伦敦',
          countryName: '英国',
          timezone: 'Europe/London',
          offsetHours: 0,
        ),
        TimezoneModel(
          id: 'paris',
          cityName: '巴黎',
          countryName: '法国',
          timezone: 'Europe/Paris',
          offsetHours: 1,
        ),
        TimezoneModel(
          id: 'new_york',
          cityName: '纽约',
          countryName: '美国',
          timezone: 'America/New_York',
          offsetHours: -5,
        ),
        TimezoneModel(
          id: 'los_angeles',
          cityName: '洛杉矶',
          countryName: '美国',
          timezone: 'America/Los_Angeles',
          offsetHours: -8,
        ),
        TimezoneModel(
          id: 'sydney',
          cityName: '悉尼',
          countryName: '澳大利亚',
          timezone: 'Australia/Sydney',
          offsetHours: 11,
        ),
        TimezoneModel(
          id: 'dubai',
          cityName: '迪拜',
          countryName: '阿联酋',
          timezone: 'Asia/Dubai',
          offsetHours: 4,
        ),
        TimezoneModel(
          id: 'singapore',
          cityName: '新加坡',
          countryName: '新加坡',
          timezone: 'Asia/Singapore',
          offsetHours: 8,
        ),
        TimezoneModel(
          id: 'hong_kong',
          cityName: '香港',
          countryName: '中国',
          timezone: 'Asia/Hong_Kong',
          offsetHours: 8,
        ),
      ];
}
