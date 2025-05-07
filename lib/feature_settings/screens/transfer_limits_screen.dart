import 'package:flutter/material.dart';
import '../../constants/route_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class TransferLimitsScreen extends StatefulWidget {
  const TransferLimitsScreen({super.key});

  @override
  State<TransferLimitsScreen> createState() => _TransferLimitsScreenState();
}

class _TransferLimitsScreenState extends State<TransferLimitsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String? _profilePhotoPath;
  bool _isUploading = false;
  String? _errorMessage;

  final Map<String, Map<String, dynamic>> _limits = {
    'Daily Limit': {
      'amount': 'MK 500,000',
      'description': 'Maximum amount you can send per day',
      'icon': Icons.today,
    },
    'Monthly Limit': {
      'amount': 'MK 5,000,000',
      'description': 'Maximum amount you can send per month',
      'icon': Icons.calendar_month,
    },
    'Single Transaction': {
      'amount': 'MK 200,000',
      'description': 'Maximum amount per transaction',
      'icon': Icons.payments,
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() {
        _isUploading = true;
        _errorMessage = null;
      });

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Photo',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Photo',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
              rotateButtonsHidden: true,
              doneButtonTitle: 'Done',
              cancelButtonTitle: 'Cancel',
            ),
          ],
        );

        if (croppedFile != null) {
          final file = File(croppedFile.path);
          final size = await file.length();

          // Validate file size (max 5MB)
          if (size > 5 * 1024 * 1024) {
            setState(() {
              _errorMessage = 'Image size should be less than 5MB';
            });
            return;
          }

          setState(() {
            _profilePhotoPath = croppedFile.path;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to process image. Please try again.';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Limits'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildInfoCard(),
              ),
            ),
            const SizedBox(height: 24),
            ..._limits.entries.toList().asMap().entries.map((entry) {
              final index = entry.key;
              final limit = entry.value;
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                            0,
                            20 *
                                (1 - _animationController.value) *
                                (index + 1)),
                        child: child,
                      );
                    },
                    child: _buildLimitCard(
                      limit.key,
                      limit.value['amount'] as String,
                      limit.value['description'] as String,
                      limit.value['icon'] as IconData,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildVerificationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'About Transfer Limits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Transfer limits are set to protect your account and comply with financial regulations. You can increase your limits by completing the full KYC verification process.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitCard(
      String title, String limit, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    limit,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Increase Your Limits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Complete the full KYC verification process to increase your transfer limits and access additional features.',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstants.kyc);
                },
                icon: const Icon(Icons.verified_user),
                label: const Text('Start Verification'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
