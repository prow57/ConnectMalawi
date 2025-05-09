import 'package:flutter/material.dart';
import '../models/transfer_model.dart';
import '../services/transfer_service.dart';

class TransferProvider extends ChangeNotifier {
  final TransferService _transferService;
  TransferModel? _lastTransfer;
  List<TransferModel> _transferHistory = [];
  bool _isLoading = false;
  String? _error;
  double _currentBalance = 0.0;

  TransferProvider(this._transferService);

  TransferModel? get lastTransfer => _lastTransfer;
  List<TransferModel> get transferHistory => _transferHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get currentBalance => _currentBalance;

  Future<void> transfer({
    required String recipientPhone,
    required double amount,
    required String description,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = TransferRequestModel(
        recipientPhone: recipientPhone,
        amount: amount,
        description: description,
      );

      final response = await _transferService.transfer(request);
      _lastTransfer = response.transfer;
      _currentBalance = response.newBalance;

      // Add to history
      _transferHistory.insert(0, response.transfer);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTransferHistory() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final transfers = await _transferService.getTransferHistory();
      _transferHistory = transfers;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTransferDetails(String transferId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final transfer = await _transferService.getTransferDetails(transferId);
      _lastTransfer = transfer;

      // Update in history if exists
      final index = _transferHistory.indexWhere((t) => t.id == transferId);
      if (index != -1) {
        _transferHistory[index] = transfer;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelTransfer(String transferId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _transferService.cancelTransfer(transferId);

      // Update in history
      final index = _transferHistory.indexWhere((t) => t.id == transferId);
      if (index != -1) {
        _transferHistory[index] = _transferHistory[index].copyWith(
          status: 'cancelled',
        );
      }

      if (_lastTransfer?.id == transferId) {
        _lastTransfer = _lastTransfer?.copyWith(status: 'cancelled');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCurrentBalance(double balance) {
    _currentBalance = balance;
    notifyListeners();
  }
}
