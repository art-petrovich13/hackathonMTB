import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _completedImprovementsKey = 'completed_improvements_v1';
  static const _bonusPointsKey = 'bonus_points_v1';

  static Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  /// Returns set of completed improvement IDs (stored as JSON list)
  static Future<Set<String>> loadCompletedImprovements() async {
    final p = await _prefs();
    final jsonStr = p.getString(_completedImprovementsKey);
    if (jsonStr == null) return {};
    final List<dynamic> list = json.decode(jsonStr);
    return list.map((e) => e.toString()).toSet();
  }

  static Future<void> saveCompletedImprovements(Set<String> ids) async {
    final p = await _prefs();
    await p.setString(_completedImprovementsKey, json.encode(ids.toList()));
  }

  static Future<int> loadBonusPoints() async {
    final p = await _prefs();
    return p.getInt(_bonusPointsKey) ?? 0;
  }

  static Future<void> addBonusPoints(int points) async {
    final p = await _prefs();
    final current = p.getInt(_bonusPointsKey) ?? 0;
    await p.setInt(_bonusPointsKey, current + points);
  }
}
