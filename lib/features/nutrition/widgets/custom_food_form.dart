import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';

class CustomFoodForm extends StatefulWidget {
  const CustomFoodForm({
    super.key,
    required this.onSave,
  });

  final void Function({
    required String name,
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
  }) onSave;

  @override
  State<CustomFoodForm> createState() => _CustomFoodFormState();
}

class _CustomFoodFormState extends State<CustomFoodForm> {
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
      _caloriesController.text.isNotEmpty &&
      _proteinController.text.isNotEmpty &&
      _carbsController.text.isNotEmpty &&
      _fatController.text.isNotEmpty;

  void _save() {
    widget.onSave(
      name: _nameController.text,
      caloriesPer100g: double.tryParse(_caloriesController.text) ?? 0,
      proteinGPer100g: double.tryParse(_proteinController.text) ?? 0,
      carbsGPer100g: double.tryParse(_carbsController.text) ?? 0,
      fatGPer100g: double.tryParse(_fatController.text) ?? 0,
    );
    _nameController.clear();
    _caloriesController.clear();
    _proteinController.clear();
    _carbsController.clear();
    _fatController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create a Food', style: AppTypography.headingSmall),
          const SizedBox(height: AppSpacing.md),
          _buildField('Food name', _nameController),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  'Calories',
                  _caloriesController,
                  isNumber: true,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildField(
                  'Protein (g)',
                  _proteinController,
                  isNumber: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  'Carbs (g)',
                  _carbsController,
                  isNumber: true,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildField(
                  'Fat (g)',
                  _fatController,
                  isNumber: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Save',
            onPressed: _isValid ? _save : null,
            isDisabled: !_isValid,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTypography.bodySmall,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
