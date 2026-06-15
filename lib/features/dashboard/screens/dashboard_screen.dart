import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.kDarkText,
              ),
        ),
        actions: [
          _buildOnlineToggle(),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnalyticsGrid(context),
            const SizedBox(height: 32),
            Responsive.isDesktop(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildRecentOrdersCard()),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildQuickActionsCard()),
                    ],
                  )
                : Column(
                    children: [
                      _buildQuickActionsCard(),
                      const SizedBox(height: 24),
                      _buildRecentOrdersCard(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(color: AppColors.kPrimary, shape: BoxShape.circle), // Updated
          ),
          const SizedBox(width: 8),
          const Text("Accepting Orders", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Switch(
            value: true,
            onChanged: (val) {},
            activeColor: AppColors.kPrimary, // Updated
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: Responsive.isMobile(context) ? 1.2 : 1.5,
      children: const [
        // Sabhi main AppColors.kPrimary lagaya, aur pending me default orange
        AnalyticsCard(title: "Today's Revenue", value: "₹4,250", icon: LucideIcons.indianRupee, color: AppColors.kPrimary),
        AnalyticsCard(title: "Total Orders", value: "32", icon: LucideIcons.shoppingBag, color: AppColors.kPrimary),
        AnalyticsCard(title: "Active Products", value: "156", icon: LucideIcons.box, color: AppColors.kPrimary),
        AnalyticsCard(title: "Pending Orders", value: "4", icon: LucideIcons.clock, color: Colors.orange),
      ],
    );
  }

  Widget _buildRecentOrdersCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Recent Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.kBackground,
                    child: Text("#${1042 + index}", style: const TextStyle(fontSize: 12, color: AppColors.kDarkText)),
                  ),
                  title: const Text("Customer Name"),
                  subtitle: const Text("3 Items • ₹450"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Preparing", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _ActionTile(icon: LucideIcons.plusCircle, title: "Add New Product", onTap: () {}),
            _ActionTile(icon: LucideIcons.tags, title: "Create Offer", onTap: () {}),
            _ActionTile(icon: LucideIcons.store, title: "Store Settings", onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const AnalyticsCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                const Icon(LucideIcons.arrowUpRight, color: Colors.green, size: 16),
              ],
            ),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.kDarkText)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.kLightText)),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.kBackground, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 20, color: AppColors.kDarkText),
            ),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.kLightText),
          ],
        ),
      ),
    );
  }
}