// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';
import 'package:hive/hive.dart';


part 'Places.g.dart';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Place {
  @HiveField(0)
  List<PlaceElement> places;

  Place({
    required this.places,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      places: (json['places'] as List<dynamic>?)
              ?.map((placeJson) => PlaceElement.fromJson(placeJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}
@HiveType(typeId: 1)
class PlaceElement {
  @HiveField(0)
  List<String> types;

  @HiveField(1)
  String? nationalPhoneNumber;

  @HiveField(2)
  String id;

  @HiveField(3)
  String formattedAddress;

  @HiveField(4)
  DisplayName displayName;

  @HiveField(5)
  double? rating;
  
  @HiveField(6)
  String businessStatus;

  @HiveField(7)
  Location location;

  @HiveField(8)
  List<Photo> photos;
  @HiveField(9)
  dynamic userRatingCount;

  PlaceElement({
    required this.types,
    required this.nationalPhoneNumber,
    required this.id,
    required this.formattedAddress,
    required this.displayName,
    required this.rating,
    required this.businessStatus,
    required this.location,
    required this.photos,
    required this.userRatingCount
  });

 factory PlaceElement.fromJson(Map<String, dynamic> json) => PlaceElement(
        types: List<String>.from(json["types"].map((x) => x)),
        nationalPhoneNumber: json["nationalPhoneNumber"],
        id: json["id"],
        formattedAddress: json["formattedAddress"],
        displayName: DisplayName.fromJson(json["displayName"]),
        rating: json["rating"]?.toDouble(),
        businessStatus: json["businessStatus"],
        location: Location.fromJson(json["location"]),
        photos: (json["photos"] as List<dynamic>?)
                ?.map((x) => Photo.fromJson(x))
                .toList() ??
            [],
            userRatingCount: json['userRatingCount']
      );

  factory PlaceElement.fromMap(Map<String, dynamic> map) => PlaceElement(
        types: List<String>.from(map["types"].map((x) => x)),
        nationalPhoneNumber: map["nationalPhoneNumber"],
        id: map["id"],
        formattedAddress: map["formattedAddress"],
        displayName: DisplayName.fromJson(map["displayName"]),
        rating: map["rating"]?.toDouble(),
        businessStatus: map["businessStatus"],
        location: Location.fromJson(map["location"]),
        photos: (map["photos"] as List<dynamic>?)
                ?.map((x) => Photo.fromMap(x))
                .toList() ??
            [],
            userRatingCount: map['userRatingCount']
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types.map((x) => x)),
        "nationalPhoneNumber": nationalPhoneNumber,
        "id": id,
        "formattedAddress": formattedAddress,
        "displayName": displayName.toJson(),
        "rating": rating,
        "location": location.toJson(),
        "businessStatus": businessStatus,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "userRatingCount": userRatingCount
      };

  Map<String, dynamic> toMap() {
    return {
      "types": List<dynamic>.from(types.map((x) => x)),
      "nationalPhoneNumber": nationalPhoneNumber,
      "id": id,
      "formattedAddress": formattedAddress,
      "displayName": displayName.toJson(),
      "rating": rating,
      "location": location.toJson(),
      "businessStatus": businessStatus,
      "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
      "userRatingCount": userRatingCount

    };
  }
}


@HiveType(typeId: 2)
class DisplayName {
  @HiveField(0)
  String text;
  @HiveField(1)
  String languageCode;

  DisplayName({
    required this.text,
    required this.languageCode,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
        text: json["text"],
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "languageCode": languageCode,
      };
}
@HiveType(typeId: 3)
class Location {
  @HiveField(0)
  double latitude;
  @HiveField(1)
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
@HiveType(typeId: 4)
class Photo {
  @HiveField(0)
  String name;
  @HiveField(1)
  int widthPx;
  @HiveField(2)
  int heightPx;
  @HiveField(3)
  List<AuthorAttribution>? authorAttributions;

  @HiveField(4)
  Uint8List? imageBytes;


  Photo({
    required this.name,
    required this.widthPx,
    required this.heightPx,
    required this.authorAttributions,
    this.imageBytes,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        name: json["name"],
        widthPx: json["widthPx"],
        heightPx: json["heightPx"],
        authorAttributions: List<AuthorAttribution>.from(
            json["authorAttributions"]
                .map((x) => AuthorAttribution.fromJson(x))),
      );

  factory Photo.fromMap(Map<String, dynamic> map) => Photo(
        name: map["name"],
        widthPx: map["widthPx"],
        heightPx: map["heightPx"],
        authorAttributions: List<AuthorAttribution>.from(
            map["authorAttributions"].map((x) => AuthorAttribution.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "widthPx": widthPx,
        "heightPx": heightPx,
        "authorAttributions":
            List<dynamic>.from(authorAttributions!.map((x) => x.toJson())),
        "imageBytes": imageBytes,
      };

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "widthPx": widthPx,
      "heightPx": heightPx,
      "authorAttributions":
          List<dynamic>.from(authorAttributions!.map((x) => x.toMap())),
      "imageBytes": imageBytes,
    };
  }
}

@HiveType(typeId: 5)
class AuthorAttribution {
  @HiveField(0)
  String displayName;
  @HiveField(1)
  String uri;
  @HiveField(2)
  String photoUri;

  AuthorAttribution({
    required this.displayName,
    required this.uri,
    required this.photoUri,
  });

  factory AuthorAttribution.fromJson(Map<String, dynamic> json) =>
      AuthorAttribution(
        displayName: json["displayName"],
        uri: json["uri"],
        photoUri: json["photoUri"],
      );

  factory AuthorAttribution.fromMap(Map<String, dynamic> map) =>
      AuthorAttribution(
        displayName: map["displayName"],
        uri: map["uri"],
        photoUri: map["photoUri"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "uri": uri,
        "photoUri": photoUri,
      };

  Map<String, dynamic> toMap() {
    return {
      "displayName": displayName,
      "uri": uri,
      "photoUri": photoUri,
    };
  }
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
