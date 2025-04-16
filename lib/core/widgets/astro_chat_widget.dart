import 'package:flutter/material.dart';
import 'package:astro_ai_app/core/theme/app_colors.dart';

class AstroChatWidget extends StatefulWidget {
  final String botName;
  final String avatarAsset;
  final List<Map<String, String>> initialMessages;

  const AstroChatWidget({
    super.key,
    required this.botName,
    required this.avatarAsset,
    this.initialMessages = const [],
  });

  @override
  State<AstroChatWidget> createState() => _AstroChatWidgetState();
}

class _AstroChatWidgetState extends State<AstroChatWidget> {
  late List<Map<String, String>> messages;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messages = List.from(widget.initialMessages);
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'sender': 'user', 'text': text});
      _controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add({'sender': 'ai', 'text': 'Let me check your stars... ✨'});
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessage(Map<String, String> msg) {
    bool isUser = msg['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? AppColors.bhagwa_Saffron : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Text(
          msg['text'] ?? '',
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      // decoration:  BoxDecoration(
      //   gradient: LinearGradient(
      //     //colors: [Color(0xFFF3E5F5), Color(0xFFFFF8E1)],
      //     colors: [Color(0xFFFFFFFF),Color(0xFFE3F2FD)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      // ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [Color(0xFF1E1E2C), Color(0xFF2C2C3E)]  // Dark Mode Gradient
              : [Color(0xFFFFFFFF), Color(0xFFE3F2FD)], // Light Mode Gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.bhagwaSaffron(context),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(widget.avatarAsset),
                  radius: isTablet ? 28 : 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.botName,
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text('Online ✨',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.white
                         // color: Colors.grey[600],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) => _buildMessage(messages[index]),
            ),
          ),

          // Input box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Ask about your future...',
                      hintStyle: TextStyle(
                        color: Colors.black
                        // color: Theme.of(context).brightness == Brightness.dark
                        //     ? Colors.white
                        //     : Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    backgroundColor: AppColors.blackWhite(context),
                    radius: isTablet ? 26 : 27,
                    child: const Icon(Icons.send, color: AppColors.bhagwa_Saffron),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
