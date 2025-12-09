import 'package:flutter/material.dart';
import 'package:todobyslackon/task_details.dart';


void main() { // Entry point of the app
//“Returns an instance of the binding that implements WidgetsBinding.
//If no binding has yet been initialized, the WidgetsFlutterBinding class 
//is used to create and initialize one.”
  
  runApp(MaterialApp(
    home: App(), //Details(), // Calls the Home widget which is the main screen of the app
    theme: ThemeData(primarySwatch: Colors.grey),

  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  
  // List to store tasks
  List<TodoItem> todoList = []; // Tell the type in < ... >
  List<String> completedList = [];
  // Controller for text input
  final TextEditingController _controller = TextEditingController(); // A controller for an editable text field.
  // Index to track which task is being edited
  int updateIndex = -1; // -- Acts like a marker
  bool isEditing = false;
  //FirebaseDatabase database = FirebaseDatabase.instance;

  late FocusNode myFocusNode;
  @override
  void initState(){
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose(){ // a func flutter calls automatically
    // clean up the focus node when the form is disposed
    myFocusNode.dispose();

    super.dispose();
  }

  void addListItem(String task){
    setState(() {
      todoList.add(TodoItem(id: , text: text, category: category, priority: priority, description: description)); // adds a task (string) to the list
      _controller.clear(); // sets the value to empty
    });
  }

  void updateListItem(String task, int index)
  {
    setState(() {
      todoList[index] = task;

      updateIndex = -1; // -- Acts like a marker
      _controller.clear();
    });
  }

  void completeListItem(int index)
  {
    setState(() {  
      completedList.add(todoList[index]); // removes a task at a chosen position (index)
      print(completedList[0]);
      todoList.removeAt(index);
    });
  }

  void undoCompleteListItem(int index)
  {
    setState(() {
      todoList.add(completedList[index]);
      completedList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 79, 79, 83),
      appBar: AppBar(
        title: Text("SlackOn To-Do"),
        backgroundColor: const Color.fromARGB(255, 59, 59, 63),
        foregroundColor: Colors.white,
        centerTitle: true,
        ),

      body: 
      //backgroundColor: ,
      Column(
        
        children: [

          /// TASK SECTION
          Expanded(
            flex: 40,
            child:Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(5))),
              margin: EdgeInsets.all(10),
              color: const Color.fromARGB(255, 66, 66, 70),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: ListView.builder(
                      itemCount: todoList.length, // the number of elem in the list
                      itemBuilder: (context, index){
                        return Card( // similar to Container widget, just more pollished.
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          color: const Color.fromARGB(255, 59, 59, 63),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child: Row(
                              children: [
                                
                                // Displays the text
                                Expanded(
                                  flex: 80,
                                  child: Text(
                                    style: TextStyle(color: Colors.white70, fontSize: 15),
                                    todoList[index],
                                  )
                                ),

                                // Delete button
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      completeListItem(index);
                                    });
                                  }, 
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                
                                // Edit button
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      //if(isEditing = false){isEditing = true; myFocusNode.requestFocus();}
                                      _controller.clear();
                                      myFocusNode.requestFocus();
                                      _controller.text = todoList[index];
                                      updateIndex = index; // enters editing mode
                                      isEditing = false;
                                      //updateListItem(_controller.text, index);
                                    });
                                  }, 
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                )

                              ],
                            ),
                          ),
                        ); 
                      }
                    ),
                  ),
                ]
              ),
            ),    
          ),

          /// COMPLETED SECTION
          Expanded(
            flex: 40,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(5))),
              margin: EdgeInsets.all(10),
              color: const Color.fromARGB(255, 66, 66, 70),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: ListView.builder(
                      itemCount: completedList.length, // the number of elem in the list
                      itemBuilder: (context, index){
                        return Card( // similar to Container widget, just more pollished.
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          color: const Color.fromARGB(255, 59, 59, 63),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child: Row(
                              children: [
                                
                                // Displays the text
                                Expanded(
                                  flex: 80,
                                  child: Text(
                                    style: TextStyle(color: Colors.white70, fontSize: 15),
                                    completedList[index], // This is where you specify what list
                                  )
                                ),

                                // Delete button
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      undoCompleteListItem(index);
                                    });
                                  }, 
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ); 
                      }
                    ),
                  ),
                ]
              ),
            ),
          ),

          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 60,
                  child: TextField(
                    decoration: InputDecoration(
                    ),
                    focusNode: myFocusNode, // myFocusNode gets assigned to this TextField
                    controller: _controller,
                    onSubmitted: (value){
                      if(updateIndex != -1)
                      {
                        updateListItem(value, updateIndex);
                      }
                      else
                      {
                        addListItem(value);
                      }
                    }
                  ),
                ),
                SizedBox(width: 10,),
                FloatingActionButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Details()),
                    );
                  
                    
                    /*
                    debugPrint(updateIndex.toString());
                    if(isEditing == false && updateIndex == -1)
                    {
                      myFocusNode.requestFocus(); // Now requestFocus func words cuz mFN is assigned to a TextField
                      isEditing = true;
                      
                    }
                    else
                    {
                      if (updateIndex != -1)
                      {
                        
                        updateListItem(_controller.text, updateIndex);
                        
                      }
                      else
                      {
                        addListItem(_controller.text);
                        
                      }
                      isEditing = false;
                      myFocusNode.unfocus();
                    }
                    */
                    setState(() {});
                  },
                ),
                
                
              ]
            )
          )
        ],
      )
      
    );
  }
}
/*
Column( 
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Expanded(child:ListTile(
              leading: FlutterLogo(),
              title: Text("Hello"),
              tileColor: Colors.red,
            ),)
          ],
        ),
        ]
      ),

*/

class Task {
  final String id;
  final String title;
  bool completed;

  Task({required this.id, required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

class TodoItem
{
  final String id;
  final String text;
  final String category;
  final int priority;
  final String description;

  TodoItem({required this.id, required this.text, required this.category, required this.priority, required this.description});
}

