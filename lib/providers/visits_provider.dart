import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/visit_model.dart';

class VisitsProvider extends ChangeNotifier {
  final List<Visit> _allVisits = _generateDummyVisits();
  List<Visit> _filteredVisits = [];
  VisitType? _selectedTypeFilter;
  VisitStatus? _selectedStatusFilter;
  String _searchQuery = '';
  final List<String> _recentSearches = [
    "TCOL00010010",
    "TCOL00010010",
    "Rejitha",
    "Murugan Pushparaj",
    "TCOL00010010",
  ];

  VisitsProvider() {
    _applyFiltersInternal();
  }

  List<Visit> get filteredVisits => _filteredVisits;

  int get visitCount => _filteredVisits.length;

  VisitType? get selectedTypeFilter => _selectedTypeFilter;

  VisitStatus? get selectedStatusFilter => _selectedStatusFilter;

  List<String> get recentSearches => List.unmodifiable(_recentSearches);

  String get searchQuery => _searchQuery;

  void applyFilters(VisitType? type, VisitStatus? status) {
    _selectedTypeFilter = type;
    _selectedStatusFilter = status;
    _applyFiltersInternal();
    notifyListeners();
  }

  void searchVisits(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applyFiltersInternal();
    if (query.trim().isNotEmpty) {
      _addRecentSearch(query.trim());
    }
    notifyListeners();
  }

  void clearSearch() {
    if (_searchQuery.isNotEmpty) {
      _searchQuery = '';
      _applyFiltersInternal();
      notifyListeners();
    }
  }

  void _applyFiltersInternal() {
    _filteredVisits = _allVisits.where((visit) {
      final typeMatch =
          _selectedTypeFilter == null || visit.type == _selectedTypeFilter;
      final statusMatch = _selectedStatusFilter == null ||
          visit.status == _selectedStatusFilter;
      final searchMatch = _searchQuery.isEmpty ||
          visit.id.toLowerCase().contains(_searchQuery) ||
          visit.customerName.toLowerCase().contains(_searchQuery);
      return typeMatch && statusMatch && searchMatch;
    }).toList();
  }

  void _addRecentSearch(String query) {
    if (query.isEmpty) return;
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }
  }

  static List<Visit> _generateDummyVisits() {
    return [
      Visit(
          id: 'TCV00010010',
          dateTime: DateTime(2025, 1, 12, 15, 0),
          status: VisitStatus.inProgress,
          customerName: 'Shantham krishnan',
          type: VisitType.loan),
      Visit(
          id: 'OMDCV00023',
          dateTime: DateTime(2025, 1, 12, 15, 0),
          status: VisitStatus.inProgress,
          customerName: 'Shantham krishnan',
          type: VisitType.dc),
      Visit(
          id: 'TCV00010011',
          dateTime: DateTime(2025, 1, 12, 15, 0),
          status: VisitStatus.notStarted,
          customerName: 'Shantham krishnan',
          type: VisitType.goldStorage),
      Visit(
          id: 'TCV00010012',
          dateTime: DateTime(2025, 1, 13, 10, 30),
          status: VisitStatus.notStarted,
          customerName: 'Another Customer',
          type: VisitType.release),
      Visit(
          id: 'TCV00010013',
          dateTime: DateTime(2025, 1, 14, 9, 0),
          status: VisitStatus.notStarted,
          customerName: 'Rejitha Mohan',
          type: VisitType.loan),
      Visit(
          id: 'TCV00010014',
          dateTime: DateTime(2025, 1, 15, 11, 0),
          status: VisitStatus.inProgress,
          customerName: 'Murugan Pushparaj',
          type: VisitType.dc),
    ];
  }
}
