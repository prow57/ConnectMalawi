import 'package:flutter/material.dart';

class SecurityLogScreen extends StatefulWidget {
  const SecurityLogScreen({super.key});

  @override
  State<SecurityLogScreen> createState() => _SecurityLogScreenState();
}

class _SecurityLogScreenState extends State<SecurityLogScreen> {
  bool _isLoading = false;
  final List<SecurityLogEntry> _logs = [
    SecurityLogEntry(
      action: 'Login',
      device: 'iPhone 13',
      location: 'Lilongwe, Malawi',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      status: 'Success',
    ),
    SecurityLogEntry(
      action: 'Transfer',
      device: 'iPhone 13',
      location: 'Lilongwe, Malawi',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'Success',
      details: 'Transfer of MWK 50,000 to John Doe',
    ),
    SecurityLogEntry(
      action: 'Password Change',
      device: 'MacBook Pro',
      location: 'Blantyre, Malawi',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Success',
    ),
    SecurityLogEntry(
      action: 'Failed Login Attempt',
      device: 'Unknown',
      location: 'Lilongwe, Malawi',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Failed',
      details: 'Incorrect password',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLogs,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filter Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search logs...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: _filterLogs,
                        ),
                      ),
                      const SizedBox(width: 16),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.filter_list),
                        onSelected: _filterByStatus,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'all',
                            child: Text('All'),
                          ),
                          const PopupMenuItem(
                            value: 'success',
                            child: Text('Success'),
                          ),
                          const PopupMenuItem(
                            value: 'failed',
                            child: Text('Failed'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Log List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: _buildStatusIcon(log.status),
                          title: Text(
                            log.action,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              _buildInfoRow(Icons.device_unknown, log.device),
                              _buildInfoRow(Icons.location_on, log.location),
                              if (log.details != null)
                                _buildInfoRow(Icons.info_outline, log.details!),
                              const SizedBox(height: 8),
                              Text(
                                _formatTimestamp(log.timestamp),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => _showLogDetails(context, log),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'success':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'failed':
        icon = Icons.error;
        color = Colors.red;
        break;
      default:
        icon = Icons.info;
        color = Colors.blue;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  void _filterLogs(String query) {
    // TODO: Implement log filtering
  }

  void _filterByStatus(String status) {
    // TODO: Implement status filtering
  }

  void _refreshLogs() {
    setState(() => _isLoading = true);
    // TODO: Implement log refresh
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);
    });
  }

  void _showLogDetails(BuildContext context, SecurityLogEntry log) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                log.action,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Status', log.status),
              _buildDetailRow('Device', log.device),
              _buildDetailRow('Location', log.location),
              _buildDetailRow('Time', _formatTimestamp(log.timestamp)),
              if (log.details != null) _buildDetailRow('Details', log.details!),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class SecurityLogEntry {
  final String action;
  final String device;
  final String location;
  final DateTime timestamp;
  final String status;
  final String? details;

  SecurityLogEntry({
    required this.action,
    required this.device,
    required this.location,
    required this.timestamp,
    required this.status,
    this.details,
  });
}
