import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_avatar.dart';
import '../../../data/models/user.dart' as models;
import '../../../router/route_constants.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_menu_item.dart';

class ProfileSidebar extends ConsumerStatefulWidget {
  const ProfileSidebar({super.key});

  @override
  ConsumerState<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends ConsumerState<ProfileSidebar> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profileProvider.notifier).loadUser());
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  bool _isProfileComplete(models.User user) {
    return user.name != null &&
        user.name!.isNotEmpty &&
        user.heightCm != null &&
        user.weightKg != null &&
        user.gender != null &&
        user.birthDate != null;
  }

  void _confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // close drawer
              ref.read(authProvider.notifier).logout();
              context.go(Routes.splash);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(profileProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.only(
              top: topPadding + AppSpacing.lg,
              left: AppSpacing.screenPaddingH,
              right: AppSpacing.screenPaddingH,
              bottom: AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.inputBorder, width: 0.5),
              ),
            ),
            child: userAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text('Error loading profile'),
              data: (user) {
                if (user == null) {
                  return const Text('No user');
                }
                return Row(
                  children: [
                    AppAvatar(
                      imageUrl: user.profilePicturePath,
                      initials: _getInitials(user.name),
                      size: 48,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ?? 'User',
                            style: AppTypography.headingSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            user.email,
                            style: AppTypography.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  badge: userAsync.whenOrNull(
                    data: (user) =>
                        user != null && !_isProfileComplete(user)
                            ? 'Complete Profile'
                            : null,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.profile);
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  label: 'Help / Support',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.help);
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.feedback_outlined,
                  label: 'Feedback',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.feedback);
                  },
                ),
              ],
            ),
          ),

          // Logout at bottom
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            isDestructive: true,
            onTap: _confirmLogout,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.sm),
        ],
      ),
    );
  }
}
