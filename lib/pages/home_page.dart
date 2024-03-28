import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/bloc/chat_bloc.dart';
import 'package:space_pod/models/chat_message_model.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  ScrollController controller = new ScrollController();


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/bg.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        // _controller.setPlaybackSpeed(0.8);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

    @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 

      Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller,),
                ),
              ),
            ),
              
      BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return 
              
              
              // Container(
              //   width: double.maxFinite,
              //   height: double.maxFinite,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           opacity: 0.5,
              //           image: VideoPlayer(_controller),
                        
              //           // AssetImage("assets/space_bg2.jpg"),
              //           fit: BoxFit.cover)),
              //   child: 
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 100,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Space Pod",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.image_search,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                           controller: controller,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 16, right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: messages[index].role == "user"
                                          ? Colors.amber.withOpacity(0.1)
                                          : Colors.pink.withOpacity(0.1)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == "user"
                                            ? "User"
                                            : "Space Pod",
                                        style: TextStyle(
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.amber
                                                    : Colors.pink),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        messages[index].parts.first.text,
                                        style: const TextStyle(height: 1.2),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          Lottie.asset('assets/loader.json',
                              width: 100, height: 100),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('Loading...')
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Ask Something...",
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 12),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(100))),
                          )),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            splashFactory: InkRipple.splashFactory,
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Center(
                                    child: Icon(
                                  Icons.send,
                                  size: 25,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
             
             
             
             
              // );

            default:
              return const SizedBox();
          }
        },
      ),
   
   
          ],
        ),
      
    
   
   
    );
  }
}
