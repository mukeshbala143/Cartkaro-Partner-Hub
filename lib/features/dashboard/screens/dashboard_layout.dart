import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dashboard_screen.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({Key? key}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const Center(child: Text("Products Management")),
    const Center(child: Text("Orders Management")),
    const Center(child: Text("Earnings")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Column(
          children: [
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
        tablet: Row(
          children: [
            _buildSidebar(),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
        desktop: Row(
          children: [
            _buildSidebar(),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.kPrimary, // Updated to brand color
              unselectedItemColor: AppColors.kLightText,
              onTap: (index) => setState(() => _selectedIndex = index),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(LucideIcons.layoutDashboard), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.package), label: 'Products'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.clipboardList), label: 'Orders'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.wallet), label: 'Earnings'),
              ],
            )
          : null,
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        border: Border(right: BorderSide(color: AppColors.kBorder)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.kPrimary, // Updated
              child: Icon(LucideIcons.store, color: Colors.white),
            ),
            title: const Text("My Store", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Partner"),
          ),
          const Divider(height: 32),
          _SidebarItem(icon: LucideIcons.layoutDashboard, title: "Dashboard", isSelected: _selectedIndex == 0, onTap: () => setState(() => _selectedIndex = 0)),
          _SidebarItem(icon: LucideIcons.package, title: "Products", isSelected: _selectedIndex == 1, onTap: () => setState(() => _selectedIndex = 1)),
          _SidebarItem(icon: LucideIcons.clipboardList, title: "Orders", isSelected: _selectedIndex == 2, onTap: () => setState(() => _selectedIndex = 2)),
          _SidebarItem(icon: LucideIcons.wallet, title: "Earnings", isSelected: _selectedIndex == 3, onTap: () => setState(() => _selectedIndex = 3)),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({required this.icon, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kPrimary.withOpacity(0.1) : Colors.transparent, // Updated
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppColors.kPrimary : AppColors.kLightText), // Updated
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.kPrimary : AppColors.kDarkText, // Updated
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}