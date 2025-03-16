import 'package:sky_cast/services/networking.dart';

const timeApiUrl = 'https://timeapi.io/api/timezone/zone';

class TimeModel {
  Future<dynamic> getCityTime(String timeZone) async {
    NetworkHelper networkHelper =
        NetworkHelper('$timeApiUrl?timeZone=$timeZone');

    var timeData = await networkHelper.getData();
    return timeData;
  }
}
