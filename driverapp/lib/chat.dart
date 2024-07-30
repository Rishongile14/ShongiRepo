import 'dart:async';
import 'dart:convert';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,required this.passengerName, required this.driver_id, required this.passenger_id});

  @override
  _ChatScreenState createState() => _ChatScreenState();
  final String passengerName;
  final int driver_id;
  final int passenger_id;
}

class _ChatScreenState extends State<ChatScreen> {

  final List<String> _messages = [];
  List<Map<String,dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage( ) async{
    try{
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/sendmessage'),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "content": _controller.text,
          "time_stamp": "2024-07-26T12:00:00Z",
          "receiver_id": widget.passenger_id,
          "sender_id": widget.driver_id
        })
      );

      var data = json.decode(response.body);


    }catch(e){
      throw e;
    }
  }

  Future<void> getMessages(driver_id, passenger_id) async{
    try{
      var response = await http.get(Uri.parse('http://192.168.231.155:5001/getmessages'));

      var data = json.decode(response.body);

      if(data != null && data.isNotEmpty){
        if(data['success'] == true){

            setState(() {
              messages = List<Map<String,dynamic>>.from(data['info']);

              _scrollToBottom();
            });

        }
      }
    }
    catch(e){

    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 2),
      curve: Curves.easeOut,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages(2,1);

    //Timer.periodic(Duration(seconds: 2), (Timer t) =>_scrollToBottom() );
    Timer.periodic(Duration(milliseconds:  2), (Timer t) =>getMessages(2,1) );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               const CircleAvatar(
                 child: Center(
                   child: Icon(
                     CupertinoIcons.person_alt,
                     size: 30,
                     color: Colors.white,
                   ),
                 ),
               ),
               const SizedBox(
                 width: 5.0,
               ),
               Text(
                   widget.passengerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
               ),
             ],
           ),
          Row(
            children: [

              IconButton(
                icon: const Icon(
                  CupertinoIcons.phone,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: (){

                },
              ),
              const SizedBox(
                width: 3.0,
              ),
              IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(
                      Icons.more_vert,
                      size: 30,
                    color: Colors.white,
                  )
              ),

            ],
          )
          ],
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color : Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return Column(
                  children: [
                    if(message['sender_id'] != widget.driver_id)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:ClipPath(
                                clipper: LowerNipMessageClipper(MessageType.receive),
                                child: Container(
                                  padding: const EdgeInsets.all(20) ,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(6.0),
                            ),
                              child: Text('${message['content']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                          ),
                        ),
                      ),
                      if(message['sender_id'] == widget.passenger_id)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:ClipPath(
                                clipper: LowerNipMessageClipper(MessageType.receive),
                                child: Container(
                                  padding: const EdgeInsets.all(20) ,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[600],
                                        borderRadius: BorderRadius.circular(6.0),
                            ),
                              child: Text('${message['content']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(6.0)
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo, color: Colors.grey[800]),
                  onPressed: (){

                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon:  Icon(Icons.send, color: Colors.grey[800]),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}