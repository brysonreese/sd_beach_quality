import 'package:flutter/material.dart';

class QualityReport {
  int siteId;
  String dehId;
  String name;
  double latitude;
  double longitude;
  int cityId;
  int indicatorId;
  int regionId;
  String description;
  String? advisory;
  String? closure;
  bool active;
  int typeId;
  bool favorite;

  QualityReport(
    this.siteId,
    this.dehId,
    this.name,
    this.latitude,
    this.longitude,
    this.cityId,
    this.indicatorId,
    this.regionId,
    this.description,
    this.advisory,
    this.closure,
    this.active,
    this.typeId,
  ) : favorite = false;

  factory QualityReport.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'SiteID': int siteId,
        'DehID': String dehId,
        'Name': String name,
        'Latitude': double latitude,
        'Longitude': double longitude,
        'CityID': int cityId,
        'IndicatorID': int indicatorId,
        'RegionID': int regionId,
        'Description': String description,
        'Advisory': String? advisory,
        'Closure': String? closure,
        'Active': bool active,
        'TypeID': int typeId,
      } =>
        QualityReport(
          siteId,
          dehId,
          name,
          latitude,
          longitude,
          cityId,
          indicatorId,
          regionId,
          description,
          advisory,
          closure,
          active,
          typeId,
        ),
      _ => throw const FormatException('Failed to load Quality Report'),
    };
  }

  @override
  String toString() {
    return 'QualityReport(siteId: $siteId, dehId: $dehId, name: $name, latitude: $latitude, longitude: $longitude, cityId: $cityId, indicatorId: $indicatorId, regionId: $regionId, description: $description, advisory: $advisory, closure: $closure, active: $active, typeId: $typeId)';
  }
}

List<Icon> statusIcons = [
  Icon(Icons.block, color: Colors.red),
  Icon(Icons.check_box, color: Colors.green),
  Icon(Icons.warning, color: Colors.amber),
];
