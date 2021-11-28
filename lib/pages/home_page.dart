import 'package:flutter/material.dart';
import 'package:flutter_sqlite_3_5/controllers/people_controller.dart';
import 'package:flutter_sqlite_3_5/models/people_model.dart';
import 'package:flutter_sqlite_3_5/pages/create_people_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PeopleModel> _peopleList = [];
  bool _status = false;
  Future<void> _selectPeople() async {
    await PeopleController().selectPeople().then((value) {
      setState(() {
        _peopleList.addAll(value);
        _status = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _selectPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Sqlite'),
      ),
      body: _status
          ? ListView.separated(
              itemBuilder: (context, index) {
                var _data = _peopleList[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(_data.id.toString()),
                  ),
                  title: Text(_data.name),
                  subtitle: Text(_data.address),
                  trailing: Text(_data.gender),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.grey);
              },
              itemCount: _peopleList.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePeoplePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
