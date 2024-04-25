class CoreValue {
  String name;
  double percentage;

  CoreValue({
    required this.name,
    required this.percentage,
  });

  static List<CoreValue> fromMap(List<Map<String, dynamic>> coreValuesMap) {
    return coreValuesMap.map((coreValueMap) {
      return CoreValue(
        name: coreValueMap['name'],
        percentage: coreValueMap['percentage'],
      );
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'percentage': percentage,
    };
  }
}