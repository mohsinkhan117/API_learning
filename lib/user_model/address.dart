import 'dart:convert';

import 'package:collection/collection.dart';

import 'geo.dart';

class Address {
	String? street;
	String? suite;
	String? city;
	String? zipcode;
	Geo? geo;

	Address({this.street, this.suite, this.city, this.zipcode, this.geo});

	@override
	String toString() {
		return 'Address(street: $street, suite: $suite, city: $city, zipcode: $zipcode, geo: $geo)';
	}

	factory Address.fromMap(Map<String, dynamic> data) => Address(
				street: data['street'] as String?,
				suite: data['suite'] as String?,
				city: data['city'] as String?,
				zipcode: data['zipcode'] as String?,
				geo: data['geo'] == null
						? null
						: Geo.fromMap(data['geo'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toMap() => {
				'street': street,
				'suite': suite,
				'city': city,
				'zipcode': zipcode,
				'geo': geo?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
	factory Address.fromJson(String data) {
		return Address.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Address) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			street.hashCode ^
			suite.hashCode ^
			city.hashCode ^
			zipcode.hashCode ^
			geo.hashCode;
}
