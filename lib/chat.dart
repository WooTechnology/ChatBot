

import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "CHATBOT",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {                     //modified
  @override                                                        //new
  State createState() => new ChatScreenState();                    //new
} 

// Add the ChatScreenState class definition in main.dart.

class ChatScreenState extends State<ChatScreen> {  
   final List<ChatMessage> _messages = <ChatMessage>[]; 
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;                 //new
  @override                                                        //new
  Widget build(BuildContext context) {
    
  return new Scaffold(
    appBar: new AppBar(title: new Text("ELIANA-CHATBOT",
    style : TextStyle(color: Colors.white ,fontWeight: FontWeight.bold,fontStyle: FontStyle.bold,fontFamily: 'Pacifico_Regular',
      fontSize: 25),
    ),
    
    backgroundColor: Colors.red[800],
    ),
    
    
    body: 
    Container(
      decoration: BoxDecoration(image : DecorationImage( image : AssetImage("../assets/images/photo5.jpeg"),
      fit: BoxFit.cover,
      ),
      ),
      child : new Column(                                        //modified
      children: <Widget>[                                         //new
        new Flexible(                                             //new
          child: new ListView.builder(                            //new 
            padding: new EdgeInsets.all(8.0),
                                 //new
            reverse: true,                                        //new
            itemBuilder: (_, int index) => _messages[index],      //new
            itemCount: _messages.length,                          //new
          ), 
                                                               //new
        ),
                                                                //new
        new Divider(height: 8.0),                                 //new
        new Container(                                            //new
          decoration: new BoxDecoration(
            color: Colors.red[100],  
            
                          ),                //new
          child: _buildTextComposer(),                       //modified
        ),                                                        //new
      ],                                                          //new
    ),
                                                               //new
  ));
}
  Widget _buildTextComposer() {
  return new IconTheme(
    data: new IconThemeData(color: Theme.of(context).accentColor),
    child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onChanged: (String text) {          //new
                setState(() {                     //new
                  _isComposing = text.length > 0; //new
                });                               //new
              },                                  //new
              onSubmitted: _handleSubmitted,
              decoration:
                  new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: 'Enter your query'
      ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)    //modified
                  : null,                                           //modified
            ),
          ),
        ],
      ),
    ),
  );
}
void _handleSubmitted(String text) {
  _textController.clear();
  setState(() {                                                    //new
    _isComposing = false;                                          //new
  }); 
    ChatMessage message = new ChatMessage(                         //new
      text: text,                                                  //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    });                                                            //new
 }


}
const String _name = "Your Name";
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0]),
            backgroundColor: Colors.red[100]),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
