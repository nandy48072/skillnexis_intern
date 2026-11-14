import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_colors.dart';
import '../utils/auth_helper.dart';
import '../utils/theme_notifier.dart'; // Import theme manager
import 'profile_screen.dart';
import 'order_history_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    // Check current theme mode from notifier
    bool isDarkMode = ThemeManager.themeNotifier.value == ThemeMode.dark;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;
        final isLoggedIn = user != null;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text(
              'Settings',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.cardBackground,
            elevation: 0.5,
            iconTheme: const IconThemeData(color: AppColors.textPrimary),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // --- ACCOUNT SECTION ---
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline, color: AppColors.textPrimary),
                      title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: Text(
                        isLoggedIn ? (user.email ?? 'Manage your info') : 'Sign in to manage profile',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                      onTap: () {
                        if (isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        } else {
                          AuthHelper.showLoginPrompt(context);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.receipt_long_outlined, color: AppColors.textPrimary),
                      title: const Text('Order History', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Track and view past orders', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                      onTap: () {
                        if (isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
                          );
                        } else {
                          AuthHelper.showLoginPrompt(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- PREFERENCES & NOTIFICATIONS ---
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Preferences & Notifications',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      activeColor: AppColors.primary,
                      secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.textPrimary),
                      title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Receive updates on order status & offers', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      value: _pushNotifications,
                      onChanged: (val) {
                        setState(() => _pushNotifications = val);
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      activeColor: AppColors.primary,
                      secondary: const Icon(Icons.mark_email_unread_outlined, color: AppColors.textPrimary),
                      title: const Text('Email Updates', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Get receipts and promotional deals via email', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      value: _emailNotifications,
                      onChanged: (val) {
                        setState(() => _emailNotifications = val);
                      },
                    ),
                    const Divider(height: 1),
                    // --- Dark Mode Switch Connected Globally ---
                    SwitchListTile(
                      activeColor: AppColors.primary,
                      secondary: const Icon(Icons.dark_mode_outlined, color: AppColors.textPrimary),
                      title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Toggle app dark background theme', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      value: isDarkMode,
                      onChanged: (val) {
                        // Update global theme instantly across all screens
                        ThemeManager.themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}