import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:material_ui/material_ui.dart';

class GenerativeAiStreamingPage extends StatefulWidget {
  const GenerativeAiStreamingPage({super.key});

  @override
  State<GenerativeAiStreamingPage> createState() =>
      _GenerativeAiStreamingPageState();
}

class _GenerativeAiStreamingPageState extends State<GenerativeAiStreamingPage> {
  final TextEditingController userInputController = TextEditingController();
  final TextEditingController systemInstructionController =
      TextEditingController(text: "You're a helpful assistant.");
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerMarkdown = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamSubscription? streamSubscription;
  String responseText = "";

  bool isGenerating = false;

  @override
  void dispose() {
    userInputController.dispose();
    systemInstructionController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
        );
      }
      if (scrollControllerMarkdown.hasClients) {
        scrollControllerMarkdown.animateTo(
          scrollControllerMarkdown.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }

  Future<void> generateText() async {
    if (userInputController.text.isEmpty || isGenerating) return;

    setState(() {
      isGenerating = true;
      responseText = "";
    });

    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        "answerQuestion",
      );
      print(userInputController.text);
      print(systemInstructionController.text);
      final result = callable.stream({
        "question": userInputController.text,
        "system": systemInstructionController.text,
      });
      streamSubscription = result.listen(
        (event) {
          if (event is Chunk) {
            final data = event.partialData;
            setState(() {
              if (data is String) {
                responseText += data;
              } else if (data is Map) {
                responseText += data['message'] ?? data.toString();
              } else {
                responseText += data.toString();
              }
            });
            scrollToBottom();
          }
        },
        onError: (error) {
          setState(() {
            responseText += "\n\n⚠️ Error during stream: ${error.toString()}";
            isGenerating = false;
          });
          scrollToBottom();
        },
        onDone: () {
          setState(() {
            isGenerating = false;
          });
          scrollToBottom();
        },
      );
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generative AI Streaming")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("System Instruction"),
                          IconButton(
                            icon: Icon(Icons.info_rounded),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 600,
                                      ),
                                      child: AlertDialog(
                                        title: const Text("System Instruction"),
                                        content: const SingleChildScrollView(
                                          child: GptMarkdown("""
System instructions define the behavior and per
sonality of the AI. By changing these instructions, 
you can make the AI act differently, such as a pirate, 
a helpful assistant, or a strict teacher.

### Examples

- You are a pirate. You answer all questions as a pirate would.
- You are a helpful assistant. You answer all questions as a helpful assistant would.
- You are a strict teacher. You answer all questions as a strict teacher would.
"""),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: systemInstructionController,
                        readOnly: isGenerating,
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("User Input"),
                                TextFormField(
                                  controller: userInputController,
                                  readOnly: isGenerating,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                generateText();
                              }
                            },
                            child: Text("Generate"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListView(
                                controller: scrollController,
                                primary: false,
                                children: [Text(responseText)],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Text(
                              "Raw output",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            right: 10,
                            top: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Stack(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListView(
                                controller: scrollControllerMarkdown,
                                primary: false,
                                children: [GptMarkdown(responseText)],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Text(
                              "Wrapped in Markdown Renderer",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            right: 10,
                            top: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
