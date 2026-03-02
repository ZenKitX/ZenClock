import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/alarm_model.dart';
import '../controllers/alarm_controller.dart';
import '../../../widgets/neumorphic_card.dart';

class AlarmEditView extends StatefulWidget {
  final AlarmModel? alarm;

  const AlarmEditView({super.key, this.alarm});

  @override
  State<AlarmEditView> createState() => _AlarmEditViewState();
}

class _AlarmEditViewState extends State<AlarmEditView> {
  late int _hour;
  late int _minute;
  late List<int> _repeatDays;
  late String _label;
  late bool _vibrate;
  late int _snoozeMinutes;

  final _labelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hour = widget.alarm?.hour ?? DateTime.now().hour;
    _minute = widget.alarm?.minute ?? DateTime.now().minute;
    _repeatDays = List.from(widget.alarm?.repeatDays ?? []);
    _label = widget.alarm?.label ?? '';
    _vibrate = widget.alarm?.vibrate ?? true;
    _snoozeMinutes = widget.alarm?.snoozeMinutes ?? 5;
    _labelController.text = _label;
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? '添加闹钟' : '编辑闹钟'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveAlarm,
            child: const Text('保存'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 时间选择
          _buildTimePicker(),
          const SizedBox(height: 24),
          
          // 重复设置
          _buildRepeatSection(),
          const SizedBox(height: 24),
          
          // 标签
          _buildLabelSection(),
          const SizedBox(height: 24),
          
          // 震动
          _buildVibrateSection(),
          const SizedBox(height: 24),
          
          // 贪睡时长
          _buildSnoozeSection(),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return NeumorphicCard(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit(_hour, 23, (value) {
                setState(() => _hour = value);
              }),
              Text(
                ':',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              _buildTimeUnit(_minute, 59, (value) {
                setState(() => _minute = value);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(int value, int max, Function(int) onChanged) {
    return GestureDetector(
      onTap: () async {
        final result = await showDialog<int>(
          context: context,
          builder: (context) => _TimePickerDialog(
            initialValue: value,
            maxValue: max,
          ),
        );
        if (result != null) {
          onChanged(result);
        }
      },
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildRepeatSection() {
    const weekDays = ['一', '二', '三', '四', '五', '六', '日'];
    
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '重复',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = index + 1;
              final isSelected = _repeatDays.contains(day);
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _repeatDays.remove(day);
                    } else {
                      _repeatDays.add(day);
                    }
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    weekDays[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelSection() {
    return NeumorphicCard(
      child: TextField(
        controller: _labelController,
        decoration: const InputDecoration(
          labelText: '标签',
          border: InputBorder.none,
          hintText: '例如：起床、上班',
        ),
        onChanged: (value) => _label = value,
      ),
    );
  }

  Widget _buildVibrateSection() {
    return NeumorphicCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '震动',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Switch(
            value: _vibrate,
            onChanged: (value) {
              setState(() => _vibrate = value);
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSnoozeSection() {
    return NeumorphicCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '贪睡时长',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          DropdownButton<int>(
            value: _snoozeMinutes,
            items: [5, 10, 15, 20, 30].map((minutes) {
              return DropdownMenuItem(
                value: minutes,
                child: Text('$minutes 分钟'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _snoozeMinutes = value);
              }
            },
          ),
        ],
      ),
    );
  }

  void _saveAlarm() {
    final controller = Get.find<AlarmController>();
    final alarm = AlarmModel(
      id: widget.alarm?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      hour: _hour,
      minute: _minute,
      repeatDays: _repeatDays,
      label: _label,
      vibrate: _vibrate,
      snoozeMinutes: _snoozeMinutes,
    );

    if (widget.alarm == null) {
      controller.addAlarm(alarm);
    } else {
      controller.updateAlarm(alarm);
    }

    Get.back();
  }
}

class _TimePickerDialog extends StatefulWidget {
  final int initialValue;
  final int maxValue;

  const _TimePickerDialog({
    required this.initialValue,
    required this.maxValue,
  });

  @override
  State<_TimePickerDialog> createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<_TimePickerDialog> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择时间'),
      content: SizedBox(
        height: 200,
        width: 100,
        child: ListWheelScrollView.useDelegate(
          itemExtent: 50,
          controller: FixedExtentScrollController(initialItem: _value),
          onSelectedItemChanged: (index) {
            setState(() => _value = index);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              if (index < 0 || index > widget.maxValue) return null;
              return Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 24,
                    color: index == _value
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_value),
          child: const Text('确定'),
        ),
      ],
    );
  }
}
