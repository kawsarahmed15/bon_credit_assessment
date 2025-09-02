import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/credit_card/presentation/screens/home_screen.dart';
import '../../features/marketplace/presentation/screens/marketplace_home_screen.dart';
import '../../features/chatbot/presentation/screens/enhanced_chatbot_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    MarketplaceHomeScreen(),
    EnhancedChatbotScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // No action if tapping the current tab
    if (index == 2) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => EnhancedChatbotScreen()));
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset:
            false, // Prevent navigation bar from moving when keyboard opens
        body: Stack(
          children: [
            // Main content
            Positioned.fill(
              bottom: 83.h, // Space for navigation bar
              child: _screens[_selectedIndex],
            ),
            // Bottom navigation bar - fixed position
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 75.h, // Custom height for bottom navigation
                margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[900]!,
                      Colors.grey[850]!.withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[700]!, width: 1.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 15.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 6.h),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10.r,
                      spreadRadius: 0.5.r,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(CupertinoIcons.home, 'Home', 0),
                    _buildNavItem(CupertinoIcons.creditcard, 'Cards', 1),
                    _buildNavItem(CupertinoIcons.chat_bubble_2, 'Chat', 2),
                    _buildNavItem(CupertinoIcons.person_circle, 'Profile', 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey[400],
              size: 20.sp,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey[400],
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
