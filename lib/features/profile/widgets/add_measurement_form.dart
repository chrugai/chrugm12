import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/input/app_number_input.dart';
import '../../../data/models/measurement.dart';

class AddMeasurementForm extends StatefulWidget {
  const AddMeasurementForm({
    super.key,
    this.prefill,
    required this.onSave,
  });

  final Measurement? prefill;
  final ValueChanged<Map<String, double?>> onSave;

  @override
  State<AddMeasurementForm> createState() => _AddMeasurementFormState();
}

class _AddMeasurementFormState extends State<AddMeasurementForm> {
  late final Map<String, double> _values;

  static const _fields = [
    ('neck', 'Neck'),
    ('shoulders', 'Shoulders'),
    ('chest', 'Chest'),
    ('bicepsL', 'Biceps L'),
    ('bicepsR', 'Biceps R'),
    ('forearmL', 'Forearm L'),
    ('forearmR', 'Forearm R'),
    ('waist', 'Waist'),
    ('hips', 'Hips'),
    ('thighL', 'Thigh L'),
    ('thighR', 'Thigh R'),
    ('calvesL', 'Calves L'),
    ('calvesR', 'Calves R'),
  ];

  @override
  void initState() {
    super.initState();
    _values = {};
    if (widget.prefill != null) {
      final p = widget.prefill!;
      if (p.neckCm != null) _values['neck'] = p.neckCm!;
      if (p.shouldersCm != null) _values['shoulders'] = p.shouldersCm!;
      if (p.chestCm != null) _values['chest'] = p.chestCm!;
      if (p.bicepsLCm != null) _values['bicepsL'] = p.bicepsLCm!;
      if (p.bicepsRCm != null) _values['bicepsR'] = p.bicepsRCm!;
      if (p.forearmLCm != null) _values['forearmL'] = p.forearmLCm!;
      if (p.forearmRCm != null) _values['forearmR'] = p.forearmRCm!;
      if (p.waistCm != null) _values['waist'] = p.waistCm!;
      if (p.hipsCm != null) _values['hips'] = p.hipsCm!;
      if (p.thighLCm != null) _values['thighL'] = p.thighLCm!;
      if (p.thighRCm != null) _values['thighR'] = p.thighRCm!;
      if (p.calvesLCm != null) _values['calvesL'] = p.calvesLCm!;
      if (p.calvesRCm != null) _values['calvesR'] = p.calvesRCm!;
    }
  }

  bool get _hasAnyValue => _values.isNotEmpty;

  void _save() {
    final data = <String, double?>{};
    for (final (key, _) in _fields) {
      data[key] = _values[key];
    }
    widget.onSave(data);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.modalRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add Measurements', style: AppTypography.headingMedium),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Fields
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenPaddingH,
                AppSpacing.lg,
                AppSpacing.screenPaddingH,
                AppSpacing.lg + bottomInset,
              ),
              itemCount: _fields.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),
              itemBuilder: (context, index) {
                final (key, label) = _fields[index];
                final value = _values[key] ?? 0.0;

                return AppNumberInput(
                  label: label,
                  value: value,
                  onChanged: (v) {
                    setState(() {
                      if (v == 0.0) {
                        _values.remove(key);
                      } else {
                        _values[key] = v.toDouble();
                      }
                    });
                  },
                  min: 0,
                  max: 300,
                  step: 0.1,
                  unit: 'cm',
                );
              },
            ),
          ),
          // Save button
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenPaddingH,
              AppSpacing.sm,
              AppSpacing.screenPaddingH,
              AppSpacing.lg + bottomInset,
            ),
            child: AppButton(
              label: 'Save',
              onPressed: _hasAnyValue ? _save : null,
              isDisabled: !_hasAnyValue,
            ),
          ),
        ],
      ),
    );
  }
}
