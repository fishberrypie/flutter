import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

    var total = 3;
    var click = [0,0,0];
    var name = ['김영숙', '홍길동', '피자집'];
    var newContact ='';


    // _MyAppState에서 addOne이라는 함수가 호출되면 total++ 됨.
    void addOne(String newContact) {
      setState(() {
        total++;
        click.add(0);
        name.add(newContact);
        print(name.toString());}
      );
    }

    void deleteOne(String name){
      setState(() {
        this.name.remove(name.toString());
        total--;
        print(this.name.toString());
      });
    }



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text('버튼'),
          onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return DialogUI(addOne : addOne, newContatct : newContact, deleteOne : deleteOne);
                });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),

        body: ListView.builder(
            itemCount: total,
            itemBuilder: (c, i) {
              return Row(
                children: [
                          Expanded(
                            child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.all(10),
                                  child: Text(click[i].toString())),
                                  Text(name[i])
                                ],
                              ),
                          ),

                          TextButton( 
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                primary: Colors.white
                              ),
                              onPressed: (){
                                setState(() {
                                  click[i]++;
                                });
                              },
                              child: Text('좋아요'))
                        ],
              );
                  }
        ),



        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.phone),
              Icon(Icons.chat),
              Icon(Icons.contact_page),
            ],
          ),
        ),
      ),


    );
  }
}


// fAB 함수

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addOne, this.newContatct, this.deleteOne});
  final addOne;
  var newContatct;
  var deleteOne;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Contact"),
      content: Container(
        width: 150, height: 150,
        child: TextField(
          controller: inputData,
        ),
      ),
      actions: [
           TextButton(onPressed: (){  Navigator.of(context).pop();}, child: Text('나가기')),
           TextButton(onPressed: (){ deleteOne(inputData.text);}, child: Text('삭제')),
           TextButton(onPressed: (){  print(inputData.text);}, child: Text('OK')),
           TextButton(onPressed: (){  newContatct = inputData.text; addOne(newContatct);  }, child: Text('추가')),
               ],
    );
  }
}

