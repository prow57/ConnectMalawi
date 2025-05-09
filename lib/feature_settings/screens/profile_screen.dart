import 'package:flutter/material.dart';
import '../../../constants/route_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data - replace with actual user data from your backend
  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+265 888 123 456',
    'isVerified': false,
    'kycStatus': 'pending', // pending, verified, rejected
    'joinDate': '2024-01-15',
    'profileImage': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: _userData['profileImage'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  _userData['profileImage'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userData['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Verification Status Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _userData['isVerified']
                                    ? Icons.verified
                                    : Icons.verified_user_outlined,
                                color: _userData['isVerified']
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _userData['isVerified']
                                    ? 'Verified Account'
                                    : 'Unverified Account',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _userData['isVerified']
                                ? 'Your account is fully verified and you can access all features.'
                                : 'Complete KYC verification to access all features and increase your transaction limits.',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (!_userData['isVerified'])
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteConstants.kyc,
                                  );
                                },
                                icon: const Icon(Icons.verified_user),
                                label: const Text('Complete KYC Verification'),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Personal Information
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    title: 'Email',
                    value: _userData['email'],
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    title: 'Phone',
                    value: _userData['phone'],
                    icon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    title: 'Member Since',
                    value: _userData['joinDate'],
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: 24),
                  // Account Actions
                  const Text(
                    'Account Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    title: 'Edit Profile',
                    icon: Icons.edit_outlined,
                    onTap: () {
                      // TODO: Implement edit profile
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    title: 'Change Password',
                    icon: Icons.lock_outline,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteConstants.changePassword);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    title: 'Security Settings',
                    icon: Icons.security_outlined,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteConstants.securitySettings);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
