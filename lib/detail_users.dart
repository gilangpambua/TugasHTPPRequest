import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'detail_users_model.dart';

class DetailUsers extends StatefulWidget {
  final int idUser;

  const DetailUsers({required this.idUser, Key? key}) : super(key: key);

  @override
  State<DetailUsers> createState() => _DetailUsersState();
}

class _DetailUsersState extends State<DetailUsers> {
  late Future<DetailModel> _futureDetailModel;

  @override
  void initState() {
    super.initState();
    _futureDetailModel = ApiDataSource.instace.loadDetailUser(widget.idUser).then((json) => DetailModel.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User ${widget.idUser}"),
      ),
      body: _buildDetailUserBody(),
    );
  }

  Widget _buildDetailUserBody() {
    return Center(
      child: FutureBuilder<DetailModel>(
        future: _futureDetailModel,
        builder: (BuildContext context, AsyncSnapshot<DetailModel> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.hasData) {
            DetailModel detailModel = snapshot.data!;
            return Column(
              children: [
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      detailModel.data!.avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Text(
                  detailModel.data!.firstName! + " " + detailModel.data!.lastName!,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  detailModel.data!.email!,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}