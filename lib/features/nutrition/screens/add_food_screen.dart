import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../core/widgets/input/app_search_bar.dart';
import '../../../data/models/food.dart';
import '../providers/nutrition_provider.dart';
import '../widgets/custom_food_form.dart';
import '../widgets/food_list_tile.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';
  List<Food> _allFoods = [];
  List<Food> _recentFoods = [];
  List<Food> _customFoods = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(_loadFoods);
  }

  Future<void> _loadFoods() async {
    final notifier = ref.read(nutritionProvider.notifier);
    final all = await notifier.searchFoods('');
    final recent = await notifier.getRecentFoods();
    setState(() {
      _allFoods = all;
      _recentFoods = recent;
      _customFoods = all.where((f) => f.isUserCustom).toList();
      _loading = false;
    });
  }

  List<Food> get _filteredAll {
    if (_query.isEmpty) return _allFoods;
    final q = _query.toLowerCase();
    return _allFoods.where((f) => f.name.toLowerCase().contains(q)).toList();
  }

  List<Food> get _filteredCustom {
    if (_query.isEmpty) return _customFoods;
    final q = _query.toLowerCase();
    return _customFoods.where((f) => f.name.toLowerCase().contains(q)).toList();
  }

  Set<String> get _recentIds => _recentFoods.map((f) => f.foodId).toSet();

  void _addFood(Food food) {
    ref.read(nutritionProvider.notifier).addFood(food);
    AppToast.showSuccess(context, 'Food is added');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Food', style: AppTypography.headingSmall),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
            AppSpacing.inputHeight + AppSpacing.lg + 48,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPaddingH,
                ),
                child: AppSearchBar(
                  controller: _searchController,
                  hint: 'Search foods...',
                  onChanged: (q) => setState(() => _query = q),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'My Foods'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildAllTab(),
                _buildMyFoodsTab(),
              ],
            ),
    );
  }

  Widget _buildAllTab() {
    final filteredRecent = _query.isEmpty
        ? _recentFoods
        : _recentFoods
            .where(
                (f) => f.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();
    final filtered = _filteredAll;

    if (filtered.isEmpty && filteredRecent.isEmpty) {
      return Center(
        child: Text(
          'No foods found',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView(
      children: [
        if (filteredRecent.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPaddingH,
              AppSpacing.lg,
              AppSpacing.screenPaddingH,
              AppSpacing.sm,
            ),
            child: Text('Recent', style: AppTypography.labelLarge),
          ),
          ...filteredRecent.map((f) => FoodListTile(
                food: f,
                isRecent: true,
                onAdd: () => _addFood(f),
              )),
          const Divider(height: AppSpacing.xxl),
        ],
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPaddingH,
            AppSpacing.sm,
            AppSpacing.screenPaddingH,
            AppSpacing.sm,
          ),
          child: Text('All Foods', style: AppTypography.labelLarge),
        ),
        ...filtered.map((f) => FoodListTile(
              food: f,
              isRecent: _recentIds.contains(f.foodId),
              onAdd: () => _addFood(f),
            )),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildMyFoodsTab() {
    final filtered = _filteredCustom;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      children: [
        const SizedBox(height: AppSpacing.lg),
        CustomFoodForm(
          onSave: ({
            required String name,
            required double caloriesPer100g,
            required double proteinGPer100g,
            required double carbsGPer100g,
            required double fatGPer100g,
          }) async {
            final food = await ref
                .read(nutritionProvider.notifier)
                .createCustomFood(
                  name: name,
                  caloriesPer100g: caloriesPer100g,
                  proteinGPer100g: proteinGPer100g,
                  carbsGPer100g: carbsGPer100g,
                  fatGPer100g: fatGPer100g,
                );
            setState(() {
              _customFoods.add(food);
              _allFoods.add(food);
            });
            if (mounted) {
              AppToast.showSuccess(context, 'Custom food saved');
            }
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('My Foods', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
            child: Center(
              child: Text(
                'No custom foods yet.\nCreate one above!',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          )
        else
          ...filtered.map((f) => FoodListTile(
                food: f,
                onAdd: () => _addFood(f),
              )),
        const SizedBox(height: 80),
      ],
    );
  }
}
