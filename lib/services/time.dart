import 'package:sky_cast/resources/ui_models.dart';
import 'package:sky_cast/services/networking.dart';

const getTimeZoneApiUrl = 'https://timeapi.io/api/timezone/availabletimeZones';
const getCurrentTimeOfTimeZoneApiUrl =
    'https://timeapi.io/api/time/current/zone';

class TimeViewModel {
  Future<List<String>> fetchAvailableTimeZones() async {
    final timezones = await NetworkHelper(
            url: getTimeZoneApiUrl, errorMessage: 'Failed to load timezones')
        .getData();
    if (timezones != null && timezones is List) {
      return List<String>.from(timezones);
    }
    return [];
  }

  Future<List<String>> fetchContinents() async {
    final timeZones = await fetchAvailableTimeZones();
    final continents =
        timeZones.map((tz) => tz.split('/').first).toSet().toList()..sort();
    return continents;
  }

  Future<Time?> getTimeForTimeZone(
      {required String continent, required String city}) async {
    final timeData = await NetworkHelper(
            url: '$getCurrentTimeOfTimeZoneApiUrl?timeZone=$continent%2F$city',
            errorMessage: 'Error getting time for $city')
        .getData();

    if (timeData == null) return null;
    return Time.fromJson(timeData);
  }
}
