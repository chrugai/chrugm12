import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/bubble_selector.dart';
import '../../../core/widgets/input/app_search_bar.dart';
import '../../../data/database/app_database.dart' hide Exercise;
import '../../../data/models/exercise.dart';
import '../providers/program_provider.dart';
import '../widgets/exercise_filter_modal.dart';
import '../widgets/exercise_list_tile.dart';
import '../widgets/exercise_preview_modal.dart';

class SelectExerciseScreen extends ConsumerStatefulWidget {
  const SelectExerciseScreen({super.key, required this.dayId, this.programName});
  final String dayId;
  final String? programName;

  @override
  ConsumerState<SelectExerciseScreen> createState() => _SelectExerciseScreenState();
}

class _SelectExerciseScreenState extends ConsumerState<SelectExerciseScreen> {
  static const _muscleGroupBubbles = ['Chest', 'Back', 'Leg', 'Tricep', 'Bicep', 'Shoulder', 'Core'];
  static const _bubbleToMuscleMap = {'Chest': 'chest', 'Back': 'back', 'Leg': 'legs', 'Tricep': 'triceps', 'Bicep': 'biceps', 'Shoulder': 'shoulders', 'Core': 'core'};

  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _selectedBubbles = [];
  ExerciseFilterResult _modalFilter = const ExerciseFilterResult();
  final Set<String> _selectedExerciseIds = {};
  List<Exercise> _allExercises = [];
  bool _isLoading = true;

  @override
  void initState() { super.initState(); _loadExercises(); }

  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  Future<void> _loadExercises() async {
    final db = ref.read(databaseProvider);
    final rows = await db.exerciseDao.getAllExercises();
    if (!mounted) return;
    setState(() {
      _allExercises = rows.map((row) {
        final muscleGroups = (row.muscleGroups?.isNotEmpty ?? false)
            ? row.muscleGroups!.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '').split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList()
            : <String>[];
        return Exercise(exerciseId: row.exerciseId, name: row.name, category: row.category, equipment: row.equipment, movementType: row.movementType, muscleGroups: muscleGroups, isCompound: row.isCompound, imageUrl: row.imageUrl, description: row.description, isUserCustom: row.isUserCustom, createdAt: DateTime.parse(row.createdAt));
      }).toList();
      _isLoading = false;
    });
  }

  List<Exercise> get _filteredExercises {
    var list = _allExercises;
    if (_searchQuery.isNotEmpty) { final q = _searchQuery.toLowerCase(); list = list.where((Exercise e) => e.name.toLowerCase().contains(q)).toList(); }
    if (_selectedBubbles.isNotEmpty) { final dbValues = _selectedBubbles.map((String b) => _bubbleToMuscleMap[b]).whereType<String>().toList(); list = list.where((Exercise e) => dbValues.any((String v) => e.muscleGroups.any((String mg) => mg.toLowerCase().contains(v)))).toList(); }
    if (_modalFilter.movementType != null) { final mt = _modalFilter.movementType!.toLowerCase(); list = list.where((Exercise e) { if (mt == 'compound') return e.isCompound; return !e.isCompound; }).toList(); }
    if (_modalFilter.muscleGroups.isNotEmpty) { list = list.where((Exercise e) => _modalFilter.muscleGroups.any((String mg) => e.muscleGroups.any((String emg) => emg.toLowerCase().contains(mg.toLowerCase())))).toList(); }
    if (_modalFilter.equipment.isNotEmpty) { list = list.where((Exercise e) { if (e.equipment == null) return false; return _modalFilter.equipment.any((String eq) => e.equipment!.toLowerCase().contains(eq.toLowerCase())); }).toList(); }
    return list;
  }

  Future<void> _openFilterModal() async {
    final result = await ExerciseFilterModal.show(context, initialFilter: _modalFilter);
    if (result != null && mounted) setState(() => _modalFilter = result);
  }

  Future<void> _onNext() async {
    if (_selectedExerciseIds.isEmpty) return;
    await ref.read(programProvider.notifier).addExercisesToDay(widget.dayId, _selectedExerciseIds.toList());
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredExercises;
    final hasSelection = _selectedExerciseIds.isNotEmpty;
    final hasActiveFilters = !_modalFilter.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildHeader(hasSelection),
          const SizedBox(height: AppSpacing.lg),
          Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH), child: Text('Select Exercise', style: AppTypography.headingLarge)),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            child: Row(children: [
              Expanded(child: AppSearchBar(controller: _searchController, hint: 'Search or Create your own', onChanged: (v) => setState(() => _searchQuery = v))),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: _openFilterModal,
                child: Container(
                  width: AppSpacing.inputHeight, height: AppSpacing.inputHeight,
                  decoration: BoxDecoration(color: hasActiveFilters ? AppColors.primary : AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: hasActiveFilters ? null : Border.all(color: AppColors.inputBorder)),
                  child: Icon(Icons.tune, color: hasActiveFilters ? Colors.white : AppColors.textSecondary),
                ),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH), child: BubbleSelector(options: _muscleGroupBubbles, selectedOptions: _selectedBubbles, multiSelect: true, onSelected: (s) => setState(() => _selectedBubbles = s))),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: _isLoading ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty ? Center(child: Text('No exercises found', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)))
                : _buildExerciseList(filtered),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader(bool hasSelection) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
      child: Padding(padding: const EdgeInsets.only(top: AppSpacing.lg), child: Row(children: [
        GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 26)),
        const Spacer(),
        if (widget.programName != null) Text(widget.programName!, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
        const Spacer(),
        GestureDetector(onTap: hasSelection ? _onNext : null, child: Text('Next', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600, color: hasSelection ? AppColors.textPrimary : AppColors.textHint))),
      ])),
    );
  }

  Widget _buildExerciseList(List<Exercise> exercises) {
    return ListView.builder(
      itemCount: exercises.length, itemExtent: 56,
      itemBuilder: (context, index) {
        final Exercise exercise = exercises[index];
        final isSelected = _selectedExerciseIds.contains(exercise.exerciseId);
        return ExerciseListTile(
          exercise: exercise, isSelected: isSelected,
          onToggle: () { setState(() { if (isSelected) { _selectedExerciseIds.remove(exercise.exerciseId); } else { _selectedExerciseIds.add(exercise.exerciseId); } }); },
          onMore: () => ExercisePreviewModal.show(context, exercise),
        );
      },
    );
  }
}
