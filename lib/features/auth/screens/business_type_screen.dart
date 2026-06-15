import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BusinessTypeScreen extends StatelessWidget {
  const BusinessTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      // Transparent AppBar for the Back Button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.kDarkText),
          onPressed: () {
            // Agar history hai to pop karega, warna seedha login par bhej dega
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/login');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Responsive(
          mobile: _buildContent(context, 1),
          tablet: _buildContent(context, 2),
          desktop: _buildContent(context, 3),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int crossAxisCount) {
    return Padding(
      // Top padding thodi kam kar di kyunki ab AppBar aa gaya hai
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What type of business do you own?",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kDarkText,
                  fontSize: Responsive.isMobile(context) ? 24 : 32,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Select your category to customize your CartKaro experience.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.kLightText,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: Responsive.isMobile(context) ? 2.3 : 1.6,
              children: const [
                BusinessCard(
                  title: "Grocery Store",
                  subtitle: "Sell groceries and daily essentials",
                  icon: LucideIcons.shoppingCart,
                  color: AppColors.kPrimary,
                ),
                BusinessCard(
                  title: "Restaurant",
                  subtitle: "Manage food orders and menu",
                  icon: LucideIcons.utensils,
                  color: AppColors.kPrimary,
                ),
                BusinessCard(
                  title: "Medical Store",
                  subtitle: "Sell healthcare products",
                  icon: LucideIcons.pill,
                  color: AppColors.kPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const BusinessCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered ? widget.color : AppColors.kBorder,
            width: isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered 
                  ? widget.color.withOpacity(0.06) 
                  : Colors.black.withOpacity(0.02),
              blurRadius: isHovered ? 12 : 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              String type = 'grocery';
              if (widget.title == "Restaurant") type = 'restaurant';
              if (widget.title == "Medical Store") type = 'medical';
              
              context.push('/register/$type');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kDarkText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.kLightText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight, 
                    color: isHovered ? widget.color : AppColors.kLightText.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}