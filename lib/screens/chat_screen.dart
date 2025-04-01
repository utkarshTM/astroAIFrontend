import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Simulate AI Response
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'message': _messageController.text});
    });

    // Mock AI response
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({'sender': 'ai', 'message': 'Hello! How can I assist you today?'});
      });
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Chat with Ai')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    bool isUser = message['sender'] == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.orange : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['message']!,
                            style: TextStyle(color: isUser ? Colors.white : Colors.black)),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _sendMessage,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 17),
                      ),
                      child: Icon(Icons.send, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:dart_openai/dart_openai.dart'; // Dart OpenAI Package
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<Map<String, String>> _messages = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     OpenAI.apiKey = "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
//     ";  // Use your OpenAI API key here
//   }
//
//   Future<void> _sendMessage() async {
//     final String userMessage = _messageController.text.trim();
//     if (userMessage.isEmpty) return;
//
//     setState(() {
//       _messages.add({'role': 'user', 'message': userMessage});
//       _messageController.clear();
//       _isLoading = true;
//     });
//
//     try {
//       final chatResponse = await OpenAI.instance.chat.create(
//         model: "gpt-3.5-turbo",  // Use GPT-3.5 for free version
//         messages: [
//           {'role': 'system', 'content': 'You are a helpful assistant.'},
//           ..._messages.map((msg) => {
//             'role': msg['role']!,
//             'content': msg['message']!
//           })
//         ],
//       );
//
//       setState(() {
//         _messages.add({
//           'role': 'assistant',
//           'message': chatResponse.choices.first.message['content']
//         });
//       });
//     } catch (e) {
//       setState(() {
//         _messages.add({'role': 'assistant', 'message': 'Error: $e'});
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//       _scrollToBottom();
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(Duration(milliseconds: 300), () {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with AI")),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   itemCount: _messages.length,
//                   itemBuilder: (context, index) {
//                     final message = _messages[index];
//                     final isUserMessage = message['role'] == 'user';
//                     return Align(
//                       alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 4),
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: isUserMessage ? Colors.blue : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           message['message']!,
//                           style: TextStyle(
//                             color: isUserMessage ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               if (_isLoading) CircularProgressIndicator(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: "Type your message...",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _sendMessage,
//                     child: Text("Send"),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:astro_ai_app/api_constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<Map<String, String>> _messages = [];
//   bool _isLoading = false;
//
//   // Simulate ChatGPT-4 integration
//   Future<void> _sendMessage() async {
//     final String userMessage = _messageController.text.trim();
//     if (userMessage.isEmpty) return;
//
//     setState(() {
//       _messages.add({'role': 'user', 'message': userMessage});
//       _messageController.clear();
//       _isLoading = true;
//     });
//
//     try {
//       // Future-proof for ChatGPT-4 integration
//       final response = await http.post(
//         Uri.parse(ApiConstants.getAuthUrl("chat")),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'messages': _messages.map((msg) => {'role': msg['role'], 'content': msg['message']}).toList()
//         }),
//       );
//
//       final responseData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           _messages.add({'role': 'assistant', 'message': responseData['message']});
//         });
//       } else {
//         throw Exception('Failed to get response');
//       }
//     } catch (e) {
//       setState(() {
//         _messages.add({'role': 'assistant', 'message': 'Error: $e'});
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//       _scrollToBottom();
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(Duration(milliseconds: 300), () {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with AI")),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   final message = _messages[index];
//                   final isUserMessage = message['role'] == 'user';
//                   return Align(
//                     alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: isUserMessage ? Colors.blue : Colors.grey[300],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         message['message']!,
//                         style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             if (_isLoading) Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: "Type your message...",
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _sendMessage,
//                     child: Text("Send"),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

