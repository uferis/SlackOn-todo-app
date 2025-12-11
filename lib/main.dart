import 'package:flutter/material.dart';


void main() { // Entry point of the app
//“Returns an instance of the binding that implements WidgetsBinding.
//If no binding has yet been initialized, the WidgetsFlutterBinding class 
//is used to create and initialize one.”
  
  runApp(MaterialApp(
    home: App(), //Details(), // Calls the Home widget which is the main screen of the app
    

  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  
  // List to store tasks
  List<String> todoList = []; // Tell the type in < ... >
  List<String> completedList = [];
  // Controller for text input
  final TextEditingController _controller = TextEditingController(); // A controller for an editable text field.
  // Index to track which task is being edited
  int updateIndex = -1; // -- Acts like a marker
  int completedListFlex = 40;
  bool isFocused = false;
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
      todoList.add(task); // adds a task (string) to the list
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
      //print(completedList[0]);
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
      backgroundColor: Color(0xFF007693),
      appBar: AppBar(
        title: Text("SlackOn To-Do"),
        backgroundColor: const Color(0xFF003B4A),
        foregroundColor: Color(0xFFFFFFFF),
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
              color: const Color(0xFF024C5E),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: ListView.builder(
                      itemCount: todoList.length, // the number of elem in the list
                      itemBuilder: (context, index){
                        return Card( // similar to Container widget, just more pollished.
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          color: const Color(0xFF036173),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child: Row(
                              children: [
                                
                                // Displays the text
                                Expanded(
                                  flex: 80,
                                  child: Text(
                                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
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
                                    Icons.check_circle_rounded,
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
                                      completedListFlex = 4;
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
            flex: completedListFlex,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(5))),
              margin: EdgeInsets.all(10),
              color: const Color(0xFF024C5E),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: ListView.builder(
                      itemCount: completedList.length, // the number of elem in the list
                      itemBuilder: (context, index){
                        return Card( // similar to Container widget, just more pollished.
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          color: const Color(0xFF036173),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child: Row(
                              children: [
                                
                                // Displays the text
                                Expanded(
                                  flex: 80,
                                  child: Text(
                                    style: TextStyle(color:Color(0xFFFFFFFF), fontSize: 15),
                                    completedList[index], // This is where you specify what list
                                  )
                                ),

                                // GO BACK to TASK button
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      undoCompleteListItem(index);
                                    });
                                  }, 
                                  icon: Icon(
                                    Icons.arrow_circle_up_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),


                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      completedList.removeAt(index);
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //cursorWidth: 12,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFF003B4A),
                        filled: true,
                      ),
                      focusNode: myFocusNode, // myFocusNode gets assigned to this TextField
                      controller: _controller,
                      onTap: (){ 
                        setState(() {
                          isFocused = true; 
                          completedListFlex = 4;
                        });
                      },
                      onSubmitted: (value){
                        completedListFlex = 40;
                        if(updateIndex != -1)
                        {
                          updateListItem(value, updateIndex);
                          isFocused = false;
                        }
                        else
                        {
                          addListItem(value);
                          isFocused = false;
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF003B4A),
                    foregroundColor: Color(0xFFFFFFFF),
                    
                    onPressed: (){

                      debugPrint(updateIndex.toString());
                      if(!isEditing && updateIndex == -1 && !isFocused )
                      {
                        myFocusNode.requestFocus(); // Now requestFocus func words cuz mFN is assigned to a TextField
                        isEditing = true;
                        isFocused = true; 
                        setState(() {
                          completedListFlex = 4;
                        });
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
                        isFocused = false;
                        isEditing = false;
                        myFocusNode.unfocus();
                        setState(() {
                          completedListFlex = 40;
                        });
                      }
                      
                      setState(() {});
                    },
                  ),
                ),
                
                
              ]
            )
          )
        ],
      )
      
    );
  }
}
