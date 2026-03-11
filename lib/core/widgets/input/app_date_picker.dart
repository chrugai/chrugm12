import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

Future<void> showAppDatePicker(
  BuildContext context, {
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  required ValueChanged<DateTime> onDateSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSpacing.modalRadius),
      ),
    ),
    builder: (context) => _AppDatePickerContent(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
    ),
  );
}

class _AppDatePickerContent extends StatefulWidget {
  const _AppDatePickerContent({
    required this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
  });

  final DateTime initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<_AppDatePickerContent> createState() => _AppDatePickerContentState();
}

class _AppDatePickerContentState extends State<_AppDatePickerContent> {
  late DateTime _displayedMonth;
  late DateTime _selectedDate;

  static const _weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSelected(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final year = _displayedMonth.year;
    final month = _displayedMonth.month;
    final daysCount = _daysInMonth(year, month);
    final firstWeekday = DateTime(year, month, 1).weekday % 7;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.inputBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '${_monthNames[month - 1]} $year',
                  style: AppTypography.headingSmall,
                ),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _weekDays
                  .map((d) => SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(d, style: AppTypography.labelSmall),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.sm),
            ..._buildWeeks(daysCount, firstWeekday, year, month),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWeeks(
      int daysCount, int firstWeekday, int year, int month) {
    final weeks = <Widget>[];
    var dayIndex = 1;

    for (var week = 0; week < 6 && dayIndex <= daysCount; week++) {
      final cells = <Widget>[];
      for (var col = 0; col < 7; col++) {
        if ((week == 0 && col < firstWeekday) || dayIndex > daysCount) {
          cells.add(const SizedBox(width: 40, height: 40));
        } else {
          final date = DateTime(year, month, dayIndex);
          final today = _isToday(date);
          final selected = _isSelected(date);
          final day = dayIndex;
          cells.add(
            GestureDetector(
              onTap: () {
                widget.onDateSelected(date);
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary
                      : today
                          ? AppColors.accentBlue
                          : null,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: AppTypography.bodyMedium.copyWith(
                    color: (selected || today)
                        ? Colors.white
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
          dayIndex++;
        }
      }
      weeks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: cells,
          ),
        ),
      );
    }
    return weeks;
  }
}
