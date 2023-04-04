import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/todo_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add ToDo List"),
            content: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Write here.....",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    context.read<TodoProvider>().addToDoList(TODOModel(
                        title: _textController.text, isCompleted: false));
                    _textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Submit")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xff622CA7),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: const Center(
                child: Text(
                  "TO DO List",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
                itemCount: provider.allToDoList.length,
                itemBuilder: (context, itemIndex) {
                  return ListTile(
                    onTap: () {
                      provider
                          .todoStatusChange(provider.allToDoList[itemIndex]);
                    },
                    leading: MSHCheckbox(
                        size: 30,
                        value: provider.allToDoList[itemIndex].isCompleted,
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Color(0xff622CA7),
                        ),
                        style: MSHCheckboxStyle.stroke,
                        onChanged: (selected) {
                          provider.todoStatusChange(
                              provider.allToDoList[itemIndex]);
                        }),
                    title: Text(
                      provider.allToDoList[itemIndex].title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration:
                              provider.allToDoList[itemIndex].isCompleted ==
                                      true
                                  ? TextDecoration.lineThrough
                                  : null),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provider
                              .removeToDOList(provider.allToDoList[itemIndex]);
                        },
                        icon: Icon(Icons.delete)),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff622CA7),
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );

    /*Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );*/
  }
}
