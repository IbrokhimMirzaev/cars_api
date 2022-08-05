import 'package:cars_api/db/company_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBase {
  static final LocalDataBase getInstance = LocalDataBase._();

  LocalDataBase._();

  factory LocalDataBase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initializeDB("database.db");
      return _database!;
    }
  }

  Future<Database> _initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE $companyTable (
    ${CompanyFields.id} $idType,
    ${CompanyFields.companyId} $intType,
    ${CompanyFields.companyName} $textType,
    ${CompanyFields.isFavourite} $intType,
    ${CompanyFields.logo} $textType
    )
    ''');
  }

  //-------------------------------------------Company Table------------------------------------

  static Future<Company> insertCompany(Company company) async {
    final db = await getInstance.database;
    final id = await db.insert(companyTable, company.toJson());
    return company.copyWith(id: id);
  }

  static Future<List<Company>> getAllCompanies() async {
    final db = await getInstance.database;
    const orderBy = CompanyFields.id;
    final result = await db.query(companyTable, orderBy: orderBy);
    return result.map((json) => Company.fromJson(json)).toList();
  }
}