import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite_3_5/controllers/people_controller.dart';
import 'package:flutter_sqlite_3_5/models/people_model.dart';
import 'package:flutter_sqlite_3_5/pages/home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.peopleModel}) : super(key: key);
  final PeopleModel peopleModel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.peopleModel.name;
    genderController.text = widget.peopleModel.gender;
    addressController.text = widget.peopleModel.address;
  }

  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail People'),
        actions: [
          TextButton(
            onPressed: () async {
              await PeopleController().updatePeople(
                PeopleModel(
                  id: widget.peopleModel.id,
                  name: nameController.text.isEmpty
                      ? widget.peopleModel.name
                      : nameController.text,
                  gender: genderController.text.isEmpty
                      ? widget.peopleModel.gender
                      : genderController.text,
                  address: addressController.text.isEmpty
                      ? widget.peopleModel.address
                      : addressController.text,
                ),
              );
              // ignore: avoid_print
              print('People Updated');
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(width: 16.0)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(fontSize: 20.0),
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                style: const TextStyle(fontSize: 20.0),
                controller: genderController,
                decoration: const InputDecoration(
                  hintText: 'Enter Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                style: const TextStyle(fontSize: 20.0),
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: 'Enter Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: CupertinoButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await PeopleController().deletePeople(
                      widget.peopleModel.id,
                    );
                    // ignore: avoid_print
                    print('People Deleted');
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Text('DELETE'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
