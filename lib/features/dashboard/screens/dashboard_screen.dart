import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardScreen extends StatelessWidget {
  final String businessType;

  const DashboardScreen({
    Key? key,
    required this.businessType,
  }) : super(key: key);

  String get itemName {
    if (businessType == "restaurant") return "Menu Items";
    if (businessType == "medical") return "Medicines";
    return "Products";
  }

  String get businessName {
    if (businessType == "restaurant") return "Restaurant";
    if (businessType == "medical") return "Medical";
    return "Store";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildRevenueHeroCard(context),
              _buildSmallStatsRow(context),
              const SizedBox(height: 24),
              Responsive.isDesktop(context)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _buildRecentOrdersCard(context)),
                          const SizedBox(width: 20),
                          Expanded(flex: 1, child: _buildQuickActionsCard(context)),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildQuickActionsCard(context),
                          const SizedBox(height: 16),
                          _buildRecentOrdersCard(context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kLightText,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$businessName Dashboard',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.kDarkText,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          _buildOnlineToggle(),
        ],
      ),
    );
  }

  Widget _buildOnlineToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.kPrimary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.kPrimary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimary.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                )
              ],
            ),
          ),
          const SizedBox(width: 7),
          Text(
            'Live',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.kPrimary,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            height: 24,
            child: Transform.scale(
              scale: 0.75,
              child: Switch(
                value: true,
                onChanged: (val) {},
                activeColor: Colors.white,
                activeTrackColor: AppColors.kPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Revenue hero card ─────────────────────────────────────────
  // The signature element: a wide immersive card with gradient that
  // leads with the most important number (revenue) prominently.
  Widget _buildRevenueHeroCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimary,
            AppColors.kPrimary.withOpacity(0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimary.withOpacity(0.30),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Today's Performance",
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const Spacer(),
              Icon(LucideIcons.trendingUp,
                  color: Colors.white.withOpacity(0.7), size: 18),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            '₹4,250',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -1.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                'Total Revenue',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(LucideIcons.arrowUp, size: 11, color: Colors.white),
                    SizedBox(width: 3),
                    Text(
                      '+12.4%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Mini divider
          Divider(color: Colors.white.withOpacity(0.15), height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              _heroStat('32', 'Orders'),
              _heroDivider(),
              _heroStat('28', 'Completed'),
              _heroDivider(),
              _heroStat('4', 'Pending'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroStat(String val, String label) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              val,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.white.withOpacity(0.65),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _heroDivider() => Container(
        width: 1,
        height: 32,
        color: Colors.white.withOpacity(0.2),
      );

  // ── Small stats row ───────────────────────────────────────────
  Widget _buildSmallStatsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: _SmallStatCard(
              icon: LucideIcons.box,
              label: 'Active $itemName',
              value: '156',
              iconColor: const Color(0xFF6366F1),
              bgColor: const Color(0xFFEEF2FF),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SmallStatCard(
              icon: LucideIcons.star,
              label: 'Avg Rating',
              value: '4.9★',
              iconColor: const Color(0xFFF59E0B),
              bgColor: const Color(0xFFFFFBEB),
            ),
          ),
        ],
      ),
    );
  }

  // ── Recent Orders ─────────────────────────────────────────────
  Widget _buildRecentOrdersCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.kDarkText,
                letterSpacing: -0.3,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(
          4,
          (i) => _OrderRow(index: i),
        ),
      ],
    );
  }

  // ── Quick Actions ─────────────────────────────────────────────
  Widget _buildQuickActionsCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.kDarkText,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        _QuickActionCard(
          icon: LucideIcons.plusCircle,
          title: 'Add $itemName',
          subtitle: 'Grow your catalogue',
          iconColor: const Color(0xFF6366F1),
          bgColor: const Color(0xFFEEF2FF),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        _QuickActionCard(
          icon: LucideIcons.tags,
          title: 'Create Offer',
          subtitle: 'Run a discount deal',
          iconColor: const Color(0xFFF59E0B),
          bgColor: const Color(0xFFFFFBEB),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        _QuickActionCard(
          icon: LucideIcons.settings2,
          title: '$businessName Settings',
          subtitle: 'Hours, address, info',
          iconColor: AppColors.kPrimary,
          bgColor: AppColors.kPrimary.withOpacity(0.08),
          onTap: () {},
        ),
      ],
    );
  }
}

// ── Small Stat Card ───────────────────────────────────────────────
class _SmallStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color bgColor;

  const _SmallStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.kBorder.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.kDarkText,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.kLightText,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Order Row ──────────────────────────────────────────────────────
class _OrderRow extends StatelessWidget {
  final int index;
  const _OrderRow({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.kBorder.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Order number badge
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.kBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '#${1042 + index}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.kPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kDarkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '3 Items  •  ₹450',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kLightText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.withOpacity(0.25)),
            ),
            child: const Text(
              'Preparing',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Action Card ──────────────────────────────────────────────
class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.kBorder.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kDarkText,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kLightText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight,
                size: 16, color: AppColors.kLightText),
          ],
        ),
      ),
    );
  }
}