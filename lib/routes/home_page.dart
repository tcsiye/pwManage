import 'package:pwd/db/PasswordProvider.dart';

import '../index.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class UpdateUserAction {
  User user;

  UpdateUserAction(this.user);
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.add_box), onPressed: _goAddPw),
        ],
      ),
      body: _buildBody(), // 构建主页面
      drawer: MyDrawer(), //抽屉菜单
    );
  }

  List list = [];
  Future data;
  Future queryList([String title]) async {
    PasswordProvider provider = PasswordProvider();
    List<Password> queryRes = await provider.query();
    List reslist = [];
    for (int i = 0; i < queryRes.length; i++) {
      Password it = queryRes[i];
      Map<String, dynamic> item = it.toJson();
      reslist.add(item);
    }
    return reslist;
  }

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  Widget _buildBody() {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return FutureBuilder(
      future: queryList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        list = snapshot.data;
        print('List in building body: $list');
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return ListView.separated(
              itemCount: list.length,
              //列表项构造器
              itemBuilder: (BuildContext context, int index) {
                if (list[index] != null) {
                  return ListTile(
                      title: Text(list[index]['title']) ?? '1',
                      trailing: Icon(Icons.edit_sharp),
                      onTap: () {
                        // _onShowDetial(list[index]);
                      });
                } else {
                  return ListTile(title: Text('index + 1'));
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return index % 2 == 0 ? divider1 : divider2;
              },
            );
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
  }

  void _onShowDetial(item) {
    // Navigator.pushNamed(context, 'detail');
    // Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //       builder: (context) => new DetailRoute(pwdItem: item),
    //     ));
  }

  void _goAddPw() {
    Navigator.pushNamed(context, 'detail');
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(), //构建抽屉菜单头部
            Expanded(child: _buildMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                    child: value.isLogin
                        ? gmAvatar(value.user.avatar_url, width: 80)
                        : Image.asset(
                            "imgs/avatar-default.png",
                            width: 80,
                          ),
                  ),
                ),
                Text(
                  value.isLogin
                      ? value.user.login
                      : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) Navigator.of(context).pushNamed("login");
          },
        );
      },
    );
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            if (userModel.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //退出账号前先弹二次确认窗
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(gm.cancel),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(gm.yes),
                            onPressed: () {
                              //该赋值语句会触发MaterialApp rebuild
                              userModel.user = null;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
