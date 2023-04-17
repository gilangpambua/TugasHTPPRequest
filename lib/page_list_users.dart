import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'users_model.dart';
import 'detail_users.dart';
class PageListUsers extends StatefulWidget {
  const PageListUsers({Key? key}) : super(key: key);

  @override
  State<PageListUsers> createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List User"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instace.loadUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            UsersModel usersModel = UsersModel.fromJson(snapshot.data);
            return _buildSuccessSection(usersModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(UsersModel users) {
    return ListView.builder(
      itemCount: users.data!.length,
      itemBuilder: (context, index) {
        return _buildItemUsers(users.data![index]);
      },
    );
  }

  Widget _buildItemUsers(Data userData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailUsers(idUser: userData.id!,))
      ),
      child: Card(
        child: Row(
          children: [
            Container(
              width: 150,
              child: Image.network(userData.avatar!),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.firstName! + " " + userData.lastName!),
                Text(userData.email!)
              ],
            )
          ],
        ),
      ),
    );
  }
}