import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/display/bubble_selector.dart';
import '../../../core/widgets/input/app_text_input.dart';
import '../providers/program_provider.dart';

const _suggestions = [
  'Focus',
  'Push/Pull/Leg',
  'Full Body Focus',
  '8 week build',
  'Leg',
  '4 week workout',
  'Fat Burn Basics',
];

class CreateProgramModal extends ConsumerStatefulWidget {
  const CreateProgramModal({super.key});

  @override
  ConsumerState<CreateProgramModal> createState() => _CreateProgramModalState();
}

class _CreateProgramModalState extends ConsumerState<CreateProgramModal> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onCreate() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    await ref.read(programProvider.notifier).createProgram(name);

    if (!mounted) return;

    final state = ref.read(programProvider);
    final programId = state.selectedProgramId;

    Navigator.of(context).pop(programId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.screenPaddingH,
        right: AppSpacing.screenPaddingH,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
      ),
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
            children: [
              const Spacer(),
              Text(
                'Enter Program Name',
                style: AppTypography.headingSmall,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, size: 24),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextInput(
            controller: _controller,
            hint: 'ie. Push/Pull/Leg or Full Body Program',
            autofocus: true,
          ),
          const SizedBox(height: AppSpacing.lg),
          BubbleSelector(
            options: _suggestions.sublist(0, 4),
            selectedOptions: const [],
            onSelected: (selected) {
              if (selected.isNotEmpty) {
                _controller.text = selected.first;
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: selected.first.length),
                );
              }
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          BubbleSelector(
            options: _suggestions.sublist(4),
            selectedOptions: const [],
            onSelected: (selected) {
              if (selected.isNotEmpty) {
                _controller.text = selected.first;
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: selected.first.length),
                );
              }
            },
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: 'Create',
            onPressed: _hasText ? _onCreate : null,
            isDisabled: !_hasText,
          ),
        ],
      ),
    );
  }
}

Future<String?> showCreateProgramModal(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSpacing.modalRadius),
      ),
    ),
    builder: (context) => const CreateProgramModal(),
  );
}
