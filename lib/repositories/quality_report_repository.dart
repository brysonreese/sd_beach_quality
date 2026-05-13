import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sd_beach_quality/models/quality_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QualityReportRepository with ChangeNotifier {
  final String _url = 'https://www.sdbeachinfo.com/Home/GetTargetByID';
  final List<QualityReport> _list = [];
  Status _status = Status.uninitialized;

  static const _favoritesKey = 'favorite_beach_ids';
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadData();
  }

  Future<void> loadData() async {
    try {
      _status = Status.initializing;
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var decoded in data) {
          QualityReport report = QualityReport.fromJson(decoded);
          //skip bucket icons
          if (report.indicatorId == 4) {
            continue;
          }
          if (favoriteIds.contains(report.dehId)) {
            report.favorite = true;
          }
          _list.add(report);
        }
      }
      _status = Status.initialized;
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
      _status = Status.error;
    }
  }

  Future<bool> toggleFavorite(QualityReport q) async {
    q.favorite = !q.favorite;
    List<String> updated = [];
    if (q.favorite) {
      updated = {...favoriteIds, q.dehId}.toList();
    } else {
      updated = favoriteIds.where((element) => element != q.dehId).toList();
    }
    notifyListeners();
    return _prefs.setStringList(_favoritesKey, updated);
  }

  QualityReport getBySiteId(int siteId) {
    return list.firstWhere((element) => element.siteId == siteId);
  }

  List<QualityReport> get list => _list;
  Status get status => _status;
  List<String> get favoriteIds => _prefs.getStringList(_favoritesKey) ?? [];
}

enum Status { uninitialized, initializing, initialized, error, refreshing }
