import 'package:flutter/material.dart';
import 'package:flutter_hive_database/hive_database/boxes.dart';
import 'package:flutter_hive_database/hive_database/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ValueListenableBuilder<Box<DataModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<DataModel>();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Name: '),
                                Text(data[index].name),
                              ],
                            ),
                            const SizedBox(height: 20.0,),
                            Row(
                              children: [
                                const Text('Description: '),
                                Text(data[index].description),
                              ],
                            ),
                          ],
                        ),
                       const  Spacer(),
                        Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              IconButton(
                                onPressed: () {
                                  update(data[index], data[index].name,
                                      data[index].description);
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  delete(data[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () async {
              myDialog();
            },
            child: const Text('Add Data')),
      ),
    );
  }

  void delete(DataModel dataModel) async {
    await dataModel.delete();
    nameController.clear();
    descriptionController.clear();
  }

  Future<void> update(DataModel dataModel, String newName, String des) async {
    nameController.text = newName;
    descriptionController.text = des;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Data'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
            ],
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  dataModel.name = nameController.text;
                  dataModel.description = descriptionController.text;
                  dataModel.save();
                  nameController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Update')),
          ],
        );
      },
    );
  }

  Future<void> myDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Data'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
            ],
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () {
                  final data = DataModel(
                      name: nameController.text,
                      description: descriptionController.text);
                  final box = Boxes.getData();
                  box.add(data);

                  data.save();
                  nameController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        );
      },
    );
  }
}
