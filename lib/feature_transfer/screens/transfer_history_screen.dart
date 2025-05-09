import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transfer_provider.dart';
import '../widgets/transfer_item.dart';
import '../../constants/theme_constants.dart';

class TransferHistoryScreen extends StatefulWidget {
  const TransferHistoryScreen({super.key});

  @override
  State<TransferHistoryScreen> createState() => _TransferHistoryScreenState();
}

class _TransferHistoryScreenState extends State<TransferHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Load transfer history when screen is opened
    Future.microtask(() {
      context.read<TransferProvider>().getTransferHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer History'),
      ),
      body: Consumer<TransferProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${provider.error}',
                    style: ThemeConstants.body1.copyWith(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: ThemeConstants.spacingM),
                  ElevatedButton(
                    onPressed: () {
                      provider.getTransferHistory();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.transferHistory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: ThemeConstants.textSecondaryColor,
                  ),
                  const SizedBox(height: ThemeConstants.spacingM),
                  Text(
                    'No transfer history yet',
                    style: ThemeConstants.body1.copyWith(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.getTransferHistory(),
            child: ListView.builder(
              padding: const EdgeInsets.all(ThemeConstants.spacingM),
              itemCount: provider.transferHistory.length,
              itemBuilder: (context, index) {
                final transfer = provider.transferHistory[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: ThemeConstants.spacingM),
                  child: TransferItem(
                    transfer: transfer,
                    onTap: () {
                      // Navigate to transfer details
                      provider.getTransferDetails(transfer.id);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
