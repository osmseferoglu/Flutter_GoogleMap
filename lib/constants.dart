class Constants {
  String apikey = 'AIzaSyD1tXUuJTZC5eyV_69FtNM1jhqNIBJ4JhY';
  String baseUrl = 'https://places.googleapis.com/v1';
  String searchUrl = '/places:searchText';
  String searchNearbyUrl = '/places:searchNearby';
  String photoParameters = 'max_height_px=90&max_width_px=60';
  String p = 'places';

  String getApiKey() {
    return apikey;
  }
  String getSearchUrl() {
    return '$baseUrl$searchUrl';
  }
  String getSearchNearbyUrl() {
    return '$baseUrl$searchNearbyUrl';
  }
  String getParameters() {
    return '$p.rating,$p.photos,$p.displayName,$p.formattedAddress,$p.types,$p.location,$p.id,$p.nationalPhoneNumber,$p.businessStatus,$p.userRatingCount';
  }
  String getThumbnailUrl(String photoReference) {
    return '$baseUrl/$photoReference/media?key=$apikey&$photoParameters';
  }


}