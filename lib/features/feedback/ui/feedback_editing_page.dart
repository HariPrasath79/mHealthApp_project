import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackEditor extends StatefulWidget {
  const FeedbackEditor({super.key});

  @override
  State<FeedbackEditor> createState() => _FeedbackEditorState();
}

class _FeedbackEditorState extends State<FeedbackEditor> {
  final _feedbackController = TextEditingController();
  bool isText = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.xmark),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.attachment_outlined)),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (isText) {}
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  isText ? Colors.blueAccent : Colors.grey),
            ),
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                height: height * 0.5,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _feedbackController,
                  minLines: 1,
                  maxLines: null,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isText = true;
                      });
                    } else {
                      setState(() {
                        isText = false;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Post your feedback',
                      hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
