import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lik_app_2/core/constants/api_constants.dart';
import 'package:lik_app_2/core/providers/auth_repository_provider.dart';
import 'package:lik_app_2/core/theme/app_colors.dart';
import 'package:lik_app_2/core/theme/app_styles.dart';
import 'package:lik_app_2/presentation/pages/petty%20cash/petty_cash_tab_navigator.dart';
import 'package:lik_app_2/presentation/pages/timbang/timbang_tab_navigator.dart';
import 'package:lik_app_2/presentation/widgets/menu_button.dart';

final pettyCashAccessProvider = FutureProvider<bool>((ref) async {
  try {
    final dio = ref.read(dioClientProvider);
    final response = await dio.get(ApiConstants.pettyCashEmployees);
    return response.data.isNotEmpty;
  } catch (e) {
    return false;
  }
});

class MainMenuPage extends ConsumerWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessState = ref.watch(pettyCashAccessProvider);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Utama', style: AppStyles.appBarTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context, ref),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: accessState.when(
          loading: () => _buildLoadingWidget(),
          error: (_, __) => _buildErrorWidget(ref),
          data: (hasAccess) => _buildMenuGrid(hasAccess, context, isPortrait),
        ),
      ),
    );
  }

  Widget _buildMenuGrid(
    bool hasPettyCashAccess,
    BuildContext context,
    bool isPortrait,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;
    final childAspectRatio = isPortrait ? 1.0 : 0.8;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? 32 : 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              'Pilih menu yang tersedia',
              style: AppStyles.headlineSmall.copyWith(
                color: AppColors.gray600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                MenuButton(
                  title: "TIKET TIMBANG",
                  subtitle: "Kelola tiket timbang",
                  icon: Icons.scale,
                  color: AppColors.primary,
                  borderColor: AppColors.primaryLight,
                  onPressed:
                      () => _navigateTo(context, const TimbangTabNavigator()),
                ),
                MenuButton(
                  title: "PETTY CASH",
                  subtitle: "Kelola petty cash",
                  icon: Icons.account_balance_wallet,
                  color: AppColors.secondary,
                  borderColor: AppColors.secondaryLight,
                  onPressed:
                      () => _navigateTo(context, const PettyCashTabNavigator()),
                ),
                if (screenWidth > 600)
                  MenuButton(
                    title: "TAMBAH FITUR",
                    subtitle: "Fitur tambahan",
                    icon: Icons.add,
                    color: AppColors.tertiary,
                    borderColor: AppColors.tertiaryLight,
                    onPressed: () {},
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Memuat menu...',
            style: AppStyles.bodyMedium.copyWith(color: AppColors.gray600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.danger),
            const SizedBox(height: 16),
            Text(
              'Gagal memuat data',
              style: AppStyles.headlineSmall.copyWith(color: AppColors.danger),
            ),
            const SizedBox(height: 8),
            Text(
              'Pastikan koneksi internet Anda stabil',
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: AppColors.gray600),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.invalidate(pettyCashAccessProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content: const Text('Anda yakin ingin keluar dari aplikasi?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Keluar',
                  style: TextStyle(color: AppColors.danger),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await ref.read(authRepositoryProvider).logout();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }
}
