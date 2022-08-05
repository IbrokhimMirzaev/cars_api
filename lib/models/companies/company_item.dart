import 'package:json_annotation/json_annotation.dart';

part 'company_item.g.dart';

@JsonSerializable()
class CompanyItem {
  @JsonKey(defaultValue: 0, name: "id")
  int id;

  @JsonKey(defaultValue: "", name: "car_model")
  String carModel;

  @JsonKey(defaultValue: 0, name: "average_price")
  int averagePrice;

  @JsonKey(defaultValue: "", name: "logo")
  String logo;

  @JsonKey(defaultValue: 0, name: "established_year")
  int year;

  @JsonKey(defaultValue: "", name: "description")
  String desc;

  @JsonKey(defaultValue: [], name: "car_pics")
  List<String> pics;

  CompanyItem({
    required this.id,
    required this.year,
    required this.averagePrice,
    required this.carModel,
    required this.logo,
    required this.desc,
    required this.pics,
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) =>
      _$CompanyItemFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyItemToJson(this);
}
