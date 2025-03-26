import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChatMessage> _messages;
  late TextEditingController _textController;

  Widget? _buildActionButton() {
    if (_textController.text.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filled(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            icon: const Icon(Icons.mic_none),
            onPressed: () {},
          ),
        ],
      );
    }
    return null;
  }

  void _handleTextChange() {
    setState(() {});
  }

  @override
  void initState() {
    _messages = [
      ChatMessage(
        text: 'Hey Johnathan, what’s up?',
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 20)),
        author: const ChatAuthor(
          id: '1011',
          name: 'smith',
        ),
      ),
      ChatMessage(
        text: 'Hey Smith, not much. You?',
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 18)),
        author: const ChatAuthor(
          id: '1010',
          name: 'Johnathan',
        ),
      ),
      ChatMessage(
        text: 'Same here. Hey, do you feel like catching a movie this weekend?',
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 15)),
        author: const ChatAuthor(
          id: '1011',
          name: 'Smith',
        ),
      ),
      ChatMessage(
        text: 'Oh, that sounds fun! What’s playing?',
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 13)),
        author: const ChatAuthor(
          id: '1010',
          name: 'Johnathan',
        ),
      ),
      ChatMessage(
        text: 'I was thinking about John wick. Have you seen it yet?',
        time: DateTime.now().subtract(const Duration(days: 1, minutes: 09)),
        author: const ChatAuthor(
          id: '1011',
          name: 'smith',
        ),
      ),
    ];
    _textController = TextEditingController()..addListener(_handleTextChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTextEntered = _textController.text.isNotEmpty;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SfChat(
          messages: _messages,
          outgoingUser: '1010',
          composer: ChatComposer.builder(
            builder: (context) {
              return TextField(
                minLines: 1,
                maxLines: 5,
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                  hintText: 'Enter the message',
                ),
              );
            },
          ),
          actionButton: ChatActionButton(
            backgroundColor: !isTextEntered ? Colors.transparent : null,
            hoverColor: !isTextEntered ? Colors.transparent : null,
            focusColor: !isTextEntered ? Colors.transparent : null,
            splashColor: !isTextEntered ? Colors.transparent : null,
            size: isTextEntered ? const Size.square(40) : const Size(110, 40),
            tooltip: isTextEntered ? 'Send Button' : null,
            child: _buildActionButton(),
            onPressed: (String text) {
              if (isTextEntered) {
                setState(() {
                  _messages.add(
                    ChatMessage(
                      text: _textController.text,
                      time: DateTime.now(),
                      author: const ChatAuthor(
                        id: '1010',
                        name: 'Johnathan',
                      ),
                    ),
                  );
                  _textController.clear();
                });
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messages.clear();
    _textController
      ..removeListener(_handleTextChange)
      ..dispose();
    super.dispose();
  }
}
