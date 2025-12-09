import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:todobyslackon/main.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  
  final _category = ["C1", "C2"];
  //String? _selectedItem;
  List<Widget> intervals = [];
  List<Widget> intervalGen(){
    for(double i = 0; i <= 10; i += 0.5 )
    {
      intervals.add(
        Center(
          child: Text("$i",
          style: TextStyle(fontSize: 24)),
          ),
      );
    };
    return intervals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: ListView(
          children: [
            TextField(), // Task Title
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: 
                  DropdownMenu(
                    hintText: "Select Category",
                    onSelected: (value) {debugPrint("value from Details: $value");},
                    dropdownMenuEntries: _category.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),  
                  ),
                ),
                Expanded(child:
                  RatingBar(
                    initialRating: 3,
                    direction: Axis.horizontal,
                    //allowHalfRating: true,
                    //itemSize: 10,
                    itemCount: 3,
                    ratingWidget: RatingWidget(
                      full: Image.asset('assets/sugar_cube.png'),
                      half: Image.asset('assets/sugar_cube.png'),
                      empty: Image.asset('assets/coffee_bean.png')
                    ),
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ), // expanded
              ]
            ),
            TextField(
              
            ), // Description
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DropdownMenu(
                    hintText: "Folder",
                    onSelected: (value) {debugPrint("value from Details: $value");},
                    dropdownMenuEntries: _category.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownMenu(
                    hintText: "Hours",
                    onSelected: (value) {debugPrint("value from Details: $value");},
                    dropdownMenuEntries: _category.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                  ),
                ),
              ],
            ),
            TextField(),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Deadline"
                  ),
                ),
                Expanded(
                  child: DropdownMenu(
                    hintText: "Date",
                    dropdownMenuEntries: _category.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {

                final todo = TodoItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(), 
                  text: text, 
                  category: category, 
                  priority: priority, 
                  description: description
                  );


                Navigator.pop(context);
              },
              child: Text("Go Back"),
            ),
          
          ],

        )
      )
    );
  }
}