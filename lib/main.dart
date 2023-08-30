import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Chat App',
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return  SignInScreen();
          }
          return ChatScreen(user: user);
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   SignInScreen({super.key});

  void _signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error signing in: $e');
    }
  }

 
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
             TextField(
              controller: passwordController ,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(emailController.text, passwordController.text),
              child: const Text('Sign In with Email/Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final User user;
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatScreen({super.key, required this.user});

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      await _firestore.collection('chats').add({
        'text': text,
        'senderId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Chat'), leading: IconButton(onPressed: () async {
        await FirebaseAuth.instance.signOut();
      }, icon: Icon(Icons.logout)),),
      body: Column(
        children: [
          Expanded(
            child: MessagesList(user: user),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(labelText: 'Enter your message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesList extends StatelessWidget {
  final User user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  MessagesList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('chats').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs;
          List<Widget> messageWidgets = [];
          for (var message in messages) {
            final messageData = message.data() as Map<String, dynamic>;
            final text = messageData['text'] ?? '';
            final senderId = messageData['senderId'] ?? '';

            // Customize the message display based on the sender
            final messageWidget = Text(
              '$senderId: $text',
              style: TextStyle(
                fontWeight: senderId == user.uid ? FontWeight.bold : FontWeight.normal,
                color: senderId == user.uid ? Colors.blue : Colors.black,
              ),
            );

            messageWidgets.add(messageWidget);
          }
          return ListView(
            children: messageWidgets,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
