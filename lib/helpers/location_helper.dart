import 'dart:convert';

import 'package:http/http.dart' as http;

//const GOOGLE_API_KEY = 'AIzaSyCO_KB8DRH5BJ-7s1a4YUUbGBhXqsu5gOY';
const GOOGLE_API_KEY = 'XAIzaSyDNSvi7w9NyC-gWS_pc8oElitoeS3P_pns0';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';

    final response = await http.get(url);
    print(response.body);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
