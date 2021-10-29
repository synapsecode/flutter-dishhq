import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:dishhq/dishhq.dart';

void main() {
  runApp(DishExampleApp());
}

class DishExampleApp extends StatelessWidget {
  const DishExampleApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DishHomePage(),
    );
  }
}

class DishHomePage extends StatelessWidget {
  const DishHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DishHQ Flutter Example'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DishKVPDBExample(),
                  ),
                );
              },
              child: Text('Database Example'),
            ),
          ],
        ),
      ),
    );
  }
}

class DishKVPDBExample extends StatefulWidget {
  const DishKVPDBExample({Key key}) : super(key: key);

  @override
  _DishKVPDBExampleState createState() => _DishKVPDBExampleState();
}

class _DishKVPDBExampleState extends State<DishKVPDBExample> {
  var db = Dish.database(apiKey: 'atharvaJ0MKCG2');
  TextEditingController keyctr = new TextEditingController();
  TextEditingController valctr = new TextEditingController();
  TextEditingController readkeyctr = new TextEditingController();
  TextEditingController delkeyctr = new TextEditingController();

  showToast() => Toast.show(
        "Sending DB Request",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );

  showOutputDialog(Map res, String req) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$req Request Completed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Successful: ${res['success'] ?? ''}"),
            SizedBox(height: 5),
            Text("Message: ${res['message'] ?? ''}"),
            SizedBox(height: 5),
            Text("ReturnValue: ${res['value'] ?? ''}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dish Database Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "KVDatabase",
                style: TextStyle(fontSize: 40),
              ),
              Text("Use this to test the Dish Database Feature"),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: keyctr,
                decoration: InputDecoration(
                  hintText: 'Key',
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: valctr,
                decoration: InputDecoration(
                  hintText: 'Value',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        showToast();
                        Map res = await db.create(
                          key: keyctr.value.text,
                          value: valctr.value.text,
                        );
                        showOutputDialog(res, 'Create');
                      },
                      child: Text('Create'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        showToast();
                        Map res = await db.update(
                          key: keyctr.value.text,
                          value: valctr.value.text,
                        );
                        showOutputDialog(res, 'Update');
                      },
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.purpleAccent.withAlpha(50),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: readkeyctr,
                        decoration: InputDecoration(
                          hintText: 'Key',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showToast();
                        Map res = await db.read(
                          key: readkeyctr.value.text,
                        );
                        showOutputDialog(res, 'Read');
                      },
                      child: Text('Read'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.red.withAlpha(50),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: delkeyctr,
                        decoration: InputDecoration(
                          hintText: 'Key',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showToast();
                        Map res = await db.delete(
                          key: delkeyctr.value.text,
                        );
                        showOutputDialog(res, 'Delete');
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
