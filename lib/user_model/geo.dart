import 'dart:convert';

import 'package:collection/collection.dart';

class Geo {
	String? lat;
	String? lng;

	Geo({this.lat, this.lng});

	@override
	String toString() => 'Geo(lat: $lat, lng: $lng)';

	factory Geo.fromMap(Map<String, dynamic> data) => Geo(
				lat: data['lat'] as String?,
				lng: data['lng'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'lat': lat,
				'lng': lng,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Geo].
	factory Geo.fromJson(String data) {
		return Geo.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Geo] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Geo) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => lat.hashCode ^ lng.hashCode;
}
