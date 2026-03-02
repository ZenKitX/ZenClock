import 'package:flutter/material.dart';

class DigitalClock extends StatelessWidget {
  final DateTime time;
  final bool showSeconds;

  const DigitalClock({
    super.key,
    required this.time,
    this.showSeconds = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 时:分
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeText(
              time.hour.toString().padLeft(2, '0'),
              textColor,
              fontSize: 96,
            ),
            _buildTimeText(
              ':',
              textColor.withOpacity(0.8),
              fontSize: 96,
            ),
            _buildTimeText(
              time.minute.toString().padLeft(2, '0'),
              textColor,
              fontSize: 96,
            ),
          ],
        ),
        
        if (showSeconds) ...[
          const SizedBox(height: 8),
          // 秒
          _buildTimeText(
            time.second.toString().padLeft(2, '0'),
            textColor.withOpacity(0.6),
            fontSize: 40,
          ),
        ],
        
        const SizedBox(height: 16),
        // 日期
        _buildDateText(context),
      ],
    );
  }

  Widget _buildTimeText(String text, Color color, {required double fontSize}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        color: color,
        height: 1.0,
        letterSpacing: -2,
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    final weekday = weekdays[time.weekday - 1];
    
    return Text(
      '${time.year}年${time.month}月${time.day}日 $weekday',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textColor.withOpacity(0.7),
        letterSpacing: 1,
      ),
    );
  }
}
