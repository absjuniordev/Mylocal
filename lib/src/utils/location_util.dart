const googleApiKey = 'AIzaSyCh6rdAjecEoJ_taHVO7DWV-gJBgpE6MuU';

class LocationUtil {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x500&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey";
  }
}
