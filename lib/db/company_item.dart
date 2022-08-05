const String companyTable = "company_table";

class CompanyFields {
  static const String id = "_id";
  static const String isFavourite = "is_favourite";
  static const String companyName = "company_name";
  static const String companyId = "company_id";
  static const String logo = "logo";
}

class Company {
  final int? id;
  final int isFavourite;
  final String companyName;
  final int companyId;
  final String logo;

  Company({
    this.id,
    required this.companyId,
    required this.companyName,
    required this.isFavourite,
    required this.logo,
  });

  Company copyWith({
    int? id,
    int? companyId,
    String? companyName,
    int? isFavourite,
    String? logo,
  }) =>
      Company(
        id: id ?? this.id,
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        isFavourite: isFavourite ?? this.isFavourite,
        logo: logo ?? this.logo,
      );

  static Company fromJson(Map<String, Object?> json) => Company(
        id: json[CompanyFields.id] as int?,
        companyId: json[CompanyFields.companyId] as int,
        companyName: json[CompanyFields.companyName] as String,
        isFavourite: json[CompanyFields.isFavourite] as int,
        logo: json[CompanyFields.logo] as String,
      );

  Map<String, Object?> toJson() {
    return {
      CompanyFields.id: id,
      CompanyFields.companyName: companyName,
      CompanyFields.companyId: companyId,
      CompanyFields.isFavourite: isFavourite,
      CompanyFields.logo : logo,
    };
  }

  @override
  String toString() => "ID = $id;  isFavourite = $isFavourite;";
}
