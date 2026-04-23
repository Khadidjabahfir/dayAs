import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/chat/chatwidget.dart';
import 'package:dayas/widget/hero/standardHeroprofile.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: getHeroAvatar('./assets/images/test_hero.png' , AppColors.purplePastel), 
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(
                  text: "hey I just woke up excited to live a day as olivia",
                  time: "8:30 am",
                  isMe: false,
                ),
                ChatBubble(
                  text: "what is your favorite song ?",
                  time: "8:32 am",
                  isMe: false,
                ),
                ChatBubble(
                  text: "it has to be good 4 u.",
                  time: "8:32 am",
                  isMe: true,
                ),
              ],
            ),
          ),
          // fix the typing input 
          // use the standard one 
          // in the screens use cubit and states please 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "typing",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}