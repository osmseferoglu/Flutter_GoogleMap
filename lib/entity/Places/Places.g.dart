// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Places.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 0;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      places: (fields[0] as List).cast<PlaceElement>(),
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.places);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaceElementAdapter extends TypeAdapter<PlaceElement> {
  @override
  final int typeId = 1;

  @override
  PlaceElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceElement(
      types: (fields[0] as List).cast<String>(),
      nationalPhoneNumber: fields[1] as String?,
      id: fields[2] as String,
      formattedAddress: fields[3] as String,
      displayName: fields[4] as DisplayName,
      rating: fields[5] as double?,
      businessStatus: fields[6] as String,
      location: fields[7] as Location,
      photos: (fields[8] as List).cast<Photo>(),
      userRatingCount: fields[9] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceElement obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.types)
      ..writeByte(1)
      ..write(obj.nationalPhoneNumber)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.formattedAddress)
      ..writeByte(4)
      ..write(obj.displayName)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.businessStatus)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.photos)
      ..writeByte(9)
      ..write(obj.userRatingCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DisplayNameAdapter extends TypeAdapter<DisplayName> {
  @override
  final int typeId = 2;

  @override
  DisplayName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DisplayName(
      text: fields[0] as String,
      languageCode: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DisplayName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisplayNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 3;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhotoAdapter extends TypeAdapter<Photo> {
  @override
  final int typeId = 4;

  @override
  Photo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Photo(
      name: fields[0] as String,
      widthPx: fields[1] as int,
      heightPx: fields[2] as int,
      authorAttributions: (fields[3] as List?)?.cast<AuthorAttribution>(),
      imageBytes: fields[4] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, Photo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.widthPx)
      ..writeByte(2)
      ..write(obj.heightPx)
      ..writeByte(3)
      ..write(obj.authorAttributions)
      ..writeByte(4)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthorAttributionAdapter extends TypeAdapter<AuthorAttribution> {
  @override
  final int typeId = 5;

  @override
  AuthorAttribution read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorAttribution(
      displayName: fields[0] as String,
      uri: fields[1] as String,
      photoUri: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthorAttribution obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.uri)
      ..writeByte(2)
      ..write(obj.photoUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorAttributionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
