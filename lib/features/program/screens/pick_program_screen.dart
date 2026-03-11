import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/input/app_search_bar.dart';
import '../providers/program_provider.dart';
import '../widgets/program_template_card.dart';

class PickAProgramScreen extends ConsumerStatefulWidget {
  const PickAProgramScreen({super.key});

  @override
  ConsumerState<PickAProgramScreen> createState() => _PickAProgramScreenState();
}

class _PickAProgramScreenState extends ConsumerState<PickAProgramScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(programProvider.notifier).loadPrograms();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(programProvider);
    final filteredPrograms = state.programs.where((p) {
      if (_searchQuery.isEmpty) return true;
      return p.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('Select Program', style: AppTypography.headingLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Consistency beats perfection — pick a plan and start today.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppSearchBar(
                controller: _searchController,
                hint: 'Search programs',
                onChanged: (value) => setState(() => _searchQuery = value),
                suffixIcon: const Icon(Icons.tune, color: AppColors.textHint),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredPrograms.isEmpty
                        ? Center(
                            child: Text(
                              'No programs found',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredPrograms.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, index) {
                              final program = filteredPrograms[index];
                              return ProgramTemplateCard(
                                program: program,
                                onTap: () => context.push(
                                  '/program-details/${program.programId}',
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
