import 'package:ai_image_generator/feature/prompt/bloc/prompt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    super.initState();
    promptBloc.add(PromptInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Images 🚀"),
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {
          // You can show snackbars here if needed
        },
        builder: (context, state) {
          Widget imageWidget;

          if (state is PromptGeneratingImageLoadState) {
            imageWidget = const Center(child: CircularProgressIndicator());
          } else if (state is PromptGeneratingImageAssetState) {
            imageWidget = Image.asset(
              state.assetPath,
              width: double.maxFinite,
              height: double.infinity,
              fit: BoxFit.cover,
            );
          } else if (state is PromptGeneratingImageSuccessState) {
            imageWidget = Image.file(
              state.file,
              width: double.maxFinite,
              height: double.infinity,
              fit: BoxFit.cover,
            );
          } else if (state is PromptGeneratingImageErrorState) {
            imageWidget = const Center(
              child: Text("Something went wrong"),
            );
          } else {
            imageWidget = const SizedBox();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image section
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  color: Colors.grey[200],
                  child: imageWidget,
                ),
              ),

              // Bottom prompt input section
              Container(
                height: 240,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your prompt...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.deepPurple,
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            promptBloc.add(
                              PromptEnteredEvent(prompt: controller.text),
                            );
                          }
                        },
                        label: const Text("Generate"),
                        icon: const Icon(Icons.generating_tokens),
                      ),
                    ),
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
