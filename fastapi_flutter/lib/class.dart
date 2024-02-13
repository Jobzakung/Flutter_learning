class RestApi {
  final int id;
  final String name;

  const RestApi({
    required this.id,
    required this.name,
  });

  factory RestApi.fromJson(Map<String, dynamic> json) {
    return RestApi(
      id: json['id'],
      name: json['name'],
    );
  }
}
