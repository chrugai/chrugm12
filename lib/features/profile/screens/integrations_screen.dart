import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../data/models/integration.dart';
import '../providers/integration_provider.dart';

class IntegrationsScreen extends ConsumerStatefulWidget {
  const IntegrationsScreen({super.key});

  @override
  ConsumerState<IntegrationsScreen> createState() => _IntegrationsScreenState();
}

class _IntegrationsScreenState extends ConsumerState<IntegrationsScreen> {
  final Set<String> _syncingIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(integrationProvider.notifier).loadIntegrations();
    });
  }

  IconData _iconForIntegration(String name) {
    switch (name.toLowerCase()) {
      case 'apple health':
        return Icons.favorite;
      case 'whoop':
        return Icons.watch;
      case 'withings':
        return Icons.monitor_weight;
      case 'oura':
        return Icons.ring_volume;
      case 'garmin':
        return Icons.directions_run;
      case 'fitbit':
        return Icons.fitness_center;
      default:
        return Icons.device_hub;
    }
  }

  String _formatLastSynced(DateTime? lastSyncedAt) {
    if (lastSyncedAt == null) return '';
    final now = DateTime.now();
    final diff = now.difference(lastSyncedAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';
    return '${lastSyncedAt.day}/${lastSyncedAt.month}/${lastSyncedAt.year}';
  }

  Future<void> _handleConnect(Integration integration) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.overlayDim,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.modalRadius),
        ),
        title: Text(
          integration.integrationName,
          style: AppTypography.headingSmall,
        ),
        content: Text(
          '${integration.integrationName} would like to access your health data.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Don't Allow",
                style: AppTypography.labelLarge
                    .copyWith(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Allow',
                style: AppTypography.labelLarge
                    .copyWith(color: AppColors.secondary)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(integrationProvider.notifier)
          .connectIntegration(integration.integrationId);
      if (mounted) AppToast.showSuccess(context, 'Connected');
    } else if (confirmed == false) {
      if (mounted) AppToast.showError(context, 'Permission denied');
    }
  }

  Future<void> _handleDisconnect(Integration integration) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.overlayDim,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.modalRadius),
        ),
        title: Text(
          'Disconnect from ${integration.integrationName}?',
          style: AppTypography.headingSmall,
        ),
        content: Text(
          'You can reconnect at any time.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel',
                style: AppTypography.labelLarge
                    .copyWith(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Disconnect',
                style:
                    AppTypography.labelLarge.copyWith(color: AppColors.danger)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(integrationProvider.notifier)
          .disconnectIntegration(integration.integrationId);
      if (mounted) AppToast.showSuccess(context, 'Disconnected');
    }
  }

  Future<void> _handleSync(Integration integration) async {
    setState(() => _syncingIds.add(integration.integrationId));
    await ref
        .read(integrationProvider.notifier)
        .syncIntegration(integration.integrationId);
    if (mounted) {
      setState(() => _syncingIds.remove(integration.integrationId));
      AppToast.showSuccess(context, 'Synced successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    final integrations = ref.watch(integrationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: integrations.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text('Error: $e', style: AppTypography.bodyMedium),
                ),
                data: (list) => _buildList(list),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const SizedBox(
              width: AppSpacing.minTapTarget,
              height: AppSpacing.minTapTarget,
              child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('Integrations', style: AppTypography.headingMedium),
        ],
      ),
    );
  }

  Widget _buildList(List<Integration> integrations) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH,
      ),
      itemCount: integrations.length,
      itemBuilder: (context, index) =>
          _buildIntegrationCard(integrations[index]),
    );
  }

  Widget _buildIntegrationCard(Integration integration) {
    final isSyncing = _syncingIds.contains(integration.integrationId);

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: integration.isConnected
                  ? AppColors.secondary.withValues(alpha: 0.12)
                  : AppColors.buttonDisabledBg,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Icon(
              _iconForIntegration(integration.integrationName),
              color: integration.isConnected
                  ? AppColors.secondary
                  : AppColors.textSecondary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Name + last synced
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(integration.integrationName,
                    style: AppTypography.bodyLarge
                        .copyWith(fontWeight: FontWeight.w600)),
                if (integration.isConnected && integration.lastSyncedAt != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      'Last synced: ${_formatLastSynced(integration.lastSyncedAt)}',
                      style: AppTypography.bodySmall,
                    ),
                  ),
              ],
            ),
          ),

          // Action buttons
          if (!integration.isConnected)
            _ConnectButton(onTap: () => _handleConnect(integration))
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSyncing)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  GestureDetector(
                    onTap: () => _handleSync(integration),
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.xs),
                      child: Icon(Icons.sync, size: 22,
                          color: AppColors.textSecondary),
                    ),
                  ),
                const SizedBox(width: AppSpacing.sm),
                _ConnectedChip(
                    onTap: () => _handleDisconnect(integration)),
              ],
            ),
        ],
      ),
    );
  }
}

class _ConnectButton extends StatelessWidget {
  const _ConnectButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonDisabledBg,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Text('Connect', style: AppTypography.labelLarge),
      ),
    );
  }
}

class _ConnectedChip extends StatelessWidget {
  const _ConnectedChip({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 16, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.xs),
            Text('Connected',
                style: AppTypography.labelLarge
                    .copyWith(color: AppColors.secondary)),
          ],
        ),
      ),
    );
  }
}
