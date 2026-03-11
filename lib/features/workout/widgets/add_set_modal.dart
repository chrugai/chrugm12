import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/display/bubble_selector.dart';
import '../../../core/widgets/input/app_number_input.dart';
import '../../../data/models/enums/rir.dart';
import '../../../data/models/enums/tempo_variation.dart';

class AddSetModal extends StatefulWidget {
  const AddSetModal({
    super.key,
    required this.onRecord,
    this.prefillReps,
    this.prefillWeight,
  });

  final void Function({
    required int reps,
    required double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
  }) onRecord;
  final int? prefillReps;
  final double? prefillWeight;

  @override
  State<AddSetModal> createState() => _AddSetModalState();
}

class _AddSetModalState extends State<AddSetModal> {
  late int _reps;
  late double _weight;
  RIR? _rir;
  TempoVariation? _tempo;
  bool _showNotes = false;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reps = widget.prefillReps ?? 0;
    _weight = widget.prefillWeight ?? 0;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool get _canRecord => _reps > 0 && _weight > 0;

  void _record() {
    widget.onRecord(
      reps: _reps,
      weightKg: _weight,
      repsInReserve: _rir?.value,
      tempoVariation: _tempo?.name,
      notes: _showNotes && _notesController.text.isNotEmpty
          ? _notesController.text
          : null,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.screenPaddingH,
        right: AppSpacing.screenPaddingH,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Record Set', style: AppTypography.headingSmall),
            const SizedBox(height: AppSpacing.xxl),
            AppNumberInput(
              label: 'Reps',
              value: _reps,
              min: 0,
              max: 100,
              step: 1,
              onChanged: (v) => setState(() => _reps = v.toInt()),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppNumberInput(
              label: 'Weight',
              value: _weight,
              min: 0,
              max: 500,
              step: 2.5,
              unit: 'kg',
              onChanged: (v) => setState(() => _weight = v.toDouble()),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('RIR (Reps in Reserve)', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            BubbleSelector(
              options: RIR.values.map((r) => r.displayName).toList(),
              selectedOptions: _rir != null ? [_rir!.displayName] : [],
              onSelected: (selected) {
                setState(() {
                  if (selected.isEmpty) {
                    _rir = null;
                  } else {
                    _rir = RIR.values.firstWhere(
                      (r) => r.displayName == selected.first,
                    );
                  }
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Tempo', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            BubbleSelector(
              options: TempoVariation.values.map((t) => t.displayName).toList(),
              selectedOptions: _tempo != null ? [_tempo!.displayName] : [],
              onSelected: (selected) {
                setState(() {
                  if (selected.isEmpty) {
                    _tempo = null;
                  } else {
                    _tempo = TempoVariation.values.firstWhere(
                      (t) => t.displayName == selected.first,
                    );
                  }
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            GestureDetector(
              onTap: () => setState(() => _showNotes = !_showNotes),
              child: Row(
                children: [
                  Icon(
                    _showNotes ? Icons.note : Icons.note_add_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _showNotes ? 'Hide notes' : 'Add notes',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
            if (_showNotes) ...[
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _notesController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g. felt easy, grip slipping...',
                  hintStyle: AppTypography.bodySmall,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: 'Record Set',
              onPressed: _canRecord ? _record : null,
              isDisabled: !_canRecord,
            ),
          ],
        ),
      ),
    );
  }
}
