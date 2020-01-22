

import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

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
    style : TextStyle(color: Colors.white ,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontFamily: 'Pacifico_Regular',
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
          child: _buildTextComposer(context),                       //modified
        ),                                                        //new
      ],                                                          //new
    ),
                                                               //new
  ));
}
  Widget _buildTextComposer(BuildContext context) {
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

void _dialogFlowResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets\Eliana-Chatbot-841feb8f5a73.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    ChatMessage message = ChatMessage(
      text: response.getMessage() ??
           CardDialogflow(response.getListMessage()[0]).title,
      name: "Flutter Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }
void _handleSubmitted(String text) {
  _textController.clear();
  setState(() {                                                    //new
    _isComposing = false;                                          //new
  }); 
    ChatMessage message = new ChatMessage(                         //new
      text: text,
      name: "Name",
      
      type: true,                                                  //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    });  
    _dialogFlowResponse(text);
                                                          //new
 }


}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text,this.name,this.type});
  final String text;
  
  final String name;
  final bool type;
  

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('Bot'),backgroundColor: Colors.red[300]),
        
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(child: new Text(this.name[0]),   backgroundColor: Colors.red[100]),
        

      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
    );
  }
}