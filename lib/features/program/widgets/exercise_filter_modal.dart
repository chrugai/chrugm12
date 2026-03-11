import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/display/bubble_selector.dart';

class ExerciseFilterResult {
  const ExerciseFilterResult({this.movementType, this.muscleGroups = const [], this.equipment = const []});
  final String? movementType;
  final List<String> muscleGroups;
  final List<String> equipment;
  bool get isEmpty => movementType == null && muscleGroups.isEmpty && equipment.isEmpty;
}

class ExerciseFilterModal extends StatefulWidget {
  const ExerciseFilterModal({super.key, required this.initialFilter});
  final ExerciseFilterResult initialFilter;

  static Future<ExerciseFilterResult?> show(BuildContext context, {ExerciseFilterResult initialFilter = const ExerciseFilterResult()}) {
    return showModalBottomSheet<ExerciseFilterResult>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => ExerciseFilterModal(initialFilter: initialFilter));
  }

  @override
  State<ExerciseFilterModal> createState() => _ExerciseFilterModalState();
}

class _ExerciseFilterModalState extends State<ExerciseFilterModal> {
  static const _movementTypes = ['Compound', 'Isolation'];
  static const _muscleGroups = ['Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Legs', 'Quads', 'Hamstring', 'Glutes', 'Core', 'Calves', 'Forearms'];
  static const _equipmentList = ['Barbell', 'Dumbbell', 'Machine', 'Cable', 'Bodyweight', 'Kettlebell', 'Resistance Band'];

  late String? _movementType;
  late List<String> _selectedMuscleGroups;
  late List<String> _selectedEquipment;

  @override
  void initState() {
    super.initState();
    _movementType = widget.initialFilter.movementType;
    _selectedMuscleGroups = List.from(widget.initialFilter.muscleGroups);
    _selectedEquipment = List.from(widget.initialFilter.equipment);
  }

  void _clear() => setState(() { _movementType = null; _selectedMuscleGroups = []; _selectedEquipment = []; });

  void _apply() => Navigator.pop(context, ExerciseFilterResult(movementType: _movementType, muscleGroups: _selectedMuscleGroups, equipment: _selectedEquipment));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.modalRadius))),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7, minChildSize: 0.4, maxChildSize: 0.9, expand: false,
        builder: (context, scrollController) {
          return Column(children: [
            Padding(padding: const EdgeInsets.only(top: AppSpacing.md), child: Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.inputBorder, borderRadius: BorderRadius.circular(2))))),
            const SizedBox(height: AppSpacing.lg),
            Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Filters', style: AppTypography.headingMedium), GestureDetector(onTap: _clear, child: Text('Clear', style: AppTypography.bodyMedium.copyWith(color: AppColors.accentBlue)))])),
            const SizedBox(height: AppSpacing.xl),
            Expanded(child: SingleChildScrollView(controller: scrollController, padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Movement Type', style: AppTypography.labelLarge), const SizedBox(height: AppSpacing.sm),
              BubbleSelector(options: _movementTypes, selectedOptions: _movementType != null ? [_movementType!] : [], scrollable: false, onSelected: (s) => setState(() { if (s.isNotEmpty && s.first != _movementType) { _movementType = s.first; } else { _movementType = null; } })),
              const SizedBox(height: AppSpacing.xxl),
              Text('Muscle Groups', style: AppTypography.labelLarge), const SizedBox(height: AppSpacing.sm),
              BubbleSelector(options: _muscleGroups, selectedOptions: _selectedMuscleGroups, multiSelect: true, scrollable: false, onSelected: (s) => setState(() => _selectedMuscleGroups = s)),
              const SizedBox(height: AppSpacing.xxl),
              Text('Equipment', style: AppTypography.labelLarge), const SizedBox(height: AppSpacing.sm),
              BubbleSelector(options: _equipmentList, selectedOptions: _selectedEquipment, multiSelect: true, scrollable: false, onSelected: (s) => setState(() => _selectedEquipment = s)),
              const SizedBox(height: AppSpacing.xxxl),
            ]))),
            Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.screenPaddingH, AppSpacing.sm, AppSpacing.screenPaddingH, AppSpacing.xxxl), child: AppButton(label: 'Apply', onPressed: _apply)),
          ]);
        },
      ),
    );
  }
}
