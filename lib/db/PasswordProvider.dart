import 'package:pwd/index.dart';
import 'package:sqflite/sqflite.dart';
import 'BaseProvider.dart';
import 'package:pwd/models/password.dart';

class PasswordProvider extends BaseProvider {
  final tbName = 'passwordInfo';

  final title = "title";
  final id = "id";
  final accont = "accont";
  final password = "password";
  final remark = "remark";
  final createdTime = "createdTime";
  final updateTime = "updateTime";
  final last = "last";

  PasswordProvider() : super();

  @override
  createTableSql() {
    return createTableBaseSql(tbName, id) +
        "$title text,$accont text,$password text,$remark text,$createdTime datetime,$updateTime datetime,$last text)";
  }

  @override
  tableName() {
    return tbName;
  }

  Future insert(Password pw) async {
    Database database = await getDataBase();
    // List<Password> pws = await query(pw.title);
    // if (pws.length > 0) {
    //   await delete(pw.title);
    // }
    return database.insert(tbName, _toMap(pw));
  }

  Map<String, dynamic> _toMap(Password pw) {
    Map<String, dynamic> map = {
      id: pw.id,
      title: pw.title,
      accont: pw.accont,
      password: pw.password,
      remark: pw.remark,
      createdTime: pw.createdTime,
      updateTime: pw.updateTime,
      last: pw.last
    };
    return map;
  }

  Future delete(String title) async {
    Database database = await getDataBase();
    return database.delete(tbName, where: "$accont = ?", whereArgs: [title]);
  }

  Future update(num id, Password pw) async {
    Database database = await getDataBase();
    var _pw = _toMap(pw);
    database.update(tbName, _pw, where: "$accont = ?", whereArgs: [title]);
    return database
        .delete(tbName, where: "$accont = ?", whereArgs: [_pw['id']]);
  }

  Future<List<Password>> query([String title]) async {
    Database database = await getDataBase();
    List<Map<String, dynamic>> result = await database.query(tbName);
    var list = List<Password>();
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> it = result[i];
        Password pw = Password.fromJson(it);
        list.add(pw);
      }
    }
    return list;
  }
}
