import '../index.dart';
import 'package:pwd/db/PasswordProvider.dart';
import '../models/password.dart';

class DetailRoute extends StatefulWidget {
  // final Password pwdItem;
  // DetailRoute(this.pwd);
  // _DetailRouteState(this.pws);
  // DetailRoute({Key key, @required this.pwdItem}) : super(key: key);
  //
  @override
  _DetailRouteState createState() => _DetailRouteState();
}

TextEditingController titleCtrl = TextEditingController();
TextEditingController accountCtrl = TextEditingController();
TextEditingController crtTimeCtrl = TextEditingController();
TextEditingController pwdCtrl = TextEditingController();
TextEditingController updTimeCtrl = TextEditingController();
TextEditingController lastCtrl = TextEditingController();
TextEditingController remarkCtrl = TextEditingController();

class _DetailRouteState extends State<DetailRoute> {
  PasswordProvider provider = PasswordProvider();

  var pwd = Password();

  void _submitForm() async {
    // 提交表单
    pwd.title = titleCtrl.text;
    pwd.accont = accountCtrl.text;
    pwd.password = pwdCtrl.text;
    pwd.createdTime = crtTimeCtrl.text;
    pwd.updateTime = updTimeCtrl.text;
    pwd.remark = remarkCtrl.text;
    pwd.last = 'last';
    var result;
    if (pwd.id == null) {
      pwd.id = new DateTime.now().millisecondsSinceEpoch; //id 为当前时间戳
      result = await provider.insert(pwd);
    } else {
      result = await provider.update(pwd.id, pwd);
    }
    print('Add result: $result');

    if (result != 0) {
      // _showAlertDialog("保存成功");
    } else {
      // _showAlertDialog("保存失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(), // 构建主页面
      // drawer: MyDrawer(), //抽屉菜单
    );
  }

  Widget _buildBody() {
    var gm = GmLocalizations.of(context);
    // UserModel userModel = Provider.of<UserModel>(context);
    GlobalKey _formKey = new GlobalKey<FormState>();
    //用户未登录，显示登录按钮
    return new Container(
        child: new Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: gm.formTitle,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: accountCtrl,
              decoration: InputDecoration(
                labelText: gm.formAccount,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: pwdCtrl,
              decoration: InputDecoration(
                labelText: gm.password,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: remarkCtrl,
              decoration: InputDecoration(
                labelText: gm.formRemark,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: updTimeCtrl,
              decoration: InputDecoration(
                labelText: gm.updateTime,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: crtTimeCtrl,
              decoration: InputDecoration(
                labelText: gm.createTime,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              controller: lastCtrl,
              decoration: InputDecoration(
                labelText: gm.last,
              ),
              validator: (v) {
                return v.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitForm,
                  textColor: Colors.white,
                  child: Text('保存'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
