import 'package:flutter/material.dart';
import '../models/timezone_model.dart';
import '../../../widgets/neumorphic_card.dart';

class WorldClockItem extends StatelessWidget {
  final TimezoneModel city;
  final DateTime currentTime;

  const WorldClockItem({
    super.key,
    required this.city,
    required this.currentTime,
  });

  @override
  Widget build(BuildContext context) {
    final timeString = '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
    final dateString = '${currentTime.month}月${currentTime.day}日';
    
    return NeumorphicCard(
      height: 120,
      child: Row(
        children: [
          // 城市信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city.cityName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  city.countryName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      city.offsetString,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      city.timeDifferenceString,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 时间显示
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateString,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
