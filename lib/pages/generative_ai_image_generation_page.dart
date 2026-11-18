import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:material_ui/material_ui.dart';

class GenerativeAiImageGenerationPage extends StatefulWidget {
  const GenerativeAiImageGenerationPage({super.key});

  @override
  State<GenerativeAiImageGenerationPage> createState() =>
      _GenerativeAiImageGenerationPageState();
}

class _GenerativeAiImageGenerationPageState
    extends State<GenerativeAiImageGenerationPage> {
  TextEditingController descriptionController = TextEditingController(
    text: "Create me the image of a cat sitting by the window and looking at a bird outside",
  );
  TextEditingController widthController = TextEditingController(text: "1280");
  TextEditingController heightController = TextEditingController(text: "720");
  TextEditingController imageStyleController = TextEditingController(
    text: "Use a cartoon style like in the early Disney movies",
  );
  ScrollController viewController = ScrollController();

  @override
  void dispose() {
    descriptionController.dispose();
    widthController.dispose();
    heightController.dispose();
    imageStyleController.dispose();
    viewController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isGenerating = false;
  String generatedImageUrl = "";
  Uint8List? generatedImageBytes;

  Map<String, dynamic> inputMap = {};

  HttpsCallable imageGeneratorCallable = FirebaseFunctions.instance
      .httpsCallable("generateImage");

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewController.hasClients) {
        viewController.animateTo(
          viewController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }

  Future<void> generateImage() async {
    if (isGenerating) return;
    setState(() {
      isGenerating = true;
      generatedImageBytes = null;
    });
    try {
      final result = await imageGeneratorCallable.call(inputMap);

      if (result.data != null && result.data is Map) {
        final data = result.data as Map;
        final base64String = data['imageBase64'] as String?;
        print(data["storagePath"]);
        print(data["downloadUrl"]);
        if (base64String != null && base64String.isNotEmpty) {
          setState(() {
            generatedImageBytes = base64Decode(base64String);
          });
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error generating image: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isGenerating = false;
          scrollToBottom();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Generation")),
      body: SingleChildScrollView(
        controller: viewController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: isGenerating,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            label: Text("Image Description"),
                            counterText: descriptionController.text.length
                                .toString(),
                            suffix: FilledButton.tonalIcon(
                              label: Text("Clear"),
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  descriptionController.text = "";
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 10) {
                              return "Image Description must be at least 10 characters long";
                            }
                            return null;
                          },
                          maxLines: 2,
                          minLines: 2,
                          onSaved: (value) {
                            inputMap['description'] = value;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: isGenerating,
                                controller: widthController,
                                decoration: InputDecoration(
                                  label: Text("Image Width"),
                                  suffix: FilledButton.tonalIcon(
                                    label: Text("Reset"),
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        widthController.text = "1280";
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null) {
                                    return "Image Width must be a number";
                                  }
                                  if (int.parse(value) < 100 ||
                                      int.parse(value) > 2000) {
                                    return "Image Width must be between 100 and 2000";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  inputMap['width'] = int.parse(value!);
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                readOnly: isGenerating,
                                controller: heightController,
                                decoration: InputDecoration(
                                  label: Text("Image Height"),
                                  suffix: FilledButton.tonalIcon(
                                    label: Text("Reset"),
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        heightController.text = "720";
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null) {
                                    return "Image Height must be a number";
                                  }
                                  if (int.parse(value) < 100 ||
                                      int.parse(value) > 2000) {
                                    return "Image Height must be between 100 and 2000";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  inputMap['height'] = int.parse(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          readOnly: isGenerating,
                          controller: imageStyleController,
                          decoration: InputDecoration(
                            label: Text("Image Style"),
                            counterText: imageStyleController.text.length
                                .toString(),
                            suffix: FilledButton.tonalIcon(
                              label: Text("Clear"),
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  imageStyleController.text = "";
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 20) {
                              return "Image Style must be at least 20 characters long";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            inputMap['image_style'] = value;
                          },
                        ),
                        SizedBox(height: 10),
                        FilledButton(
                          child: Text("Generate"),
                          onPressed: () {
                            if ((_formKey.currentState?.validate() ?? false) &&
                                !isGenerating) {
                              _formKey.currentState?.save();
                              generateImage();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isGenerating) ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 24),
                        Text(
                          "Creating your imagae...",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This may take up to 30 seconds",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (generatedImageBytes != null) ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.memory(
                            generatedImageBytes!,
                            fit: BoxFit.contain,
                            frameBuilder:
                                (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  if (frame != null) {
                                    scrollToBottom();
                                  }
                                  return child;
                                },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withValues(
                                alpha: 0.5,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    generatedImageBytes = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "Generated Image",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              descriptionController.text,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary
                              .withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No image generated yet",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Enter a description above and tap Generate to start!",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
