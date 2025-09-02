// // Legacy ChatbotScreen removed. Use EnhancedChatbotScreen instead.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black.withValues(alpha: 0.8),
//                 Colors.black.withValues(alpha: 0.6),
//                 Colors.black.withValues(alpha: 0.4),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.white.withValues(alpha: 0.15),
//                 width: 1.5,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.5),
//                 blurRadius: 20,
//                 spreadRadius: 5,
//                 offset: Offset(0, 5),
//               ),
//               BoxShadow(
//                 color: Colors.blueAccent.withValues(alpha: 0.1),
//                 blurRadius: 15,
//                 spreadRadius: 2,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//         ),
//         title: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withValues(alpha: 0.2),
//                     Colors.white.withValues(alpha: 0.1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.3),
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 10,
//                     offset: Offset(0, 3),
//                   ),
//                   BoxShadow(
//                     color: Colors.blueAccent.withValues(alpha: 0.2),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.all(10),
//               child: Icon(Icons.smart_toy, color: Colors.white, size: 24),
//             ),
//             SizedBox(width: 15),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'CredGPT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black.withValues(alpha: 0.5),
//                           blurRadius: 8,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     'Online • Ready to help',
//                     style: TextStyle(
//                       color: Colors.white.withValues(alpha: 0.7),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         toolbarHeight: 70,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         actions: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.15),
//                   Colors.white.withValues(alpha: 0.08),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.25),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.3),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.only(right: 16),
//             child: IconButton(
//               icon: Icon(
//                 Icons.more_vert,
//                 color: Colors.white.withValues(alpha: 0.9),
//                 size: 20,
//               ),
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   backgroundColor: Colors.grey.shade900,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                   builder:
//                       (context) => Container(
//                         padding: EdgeInsets.all(20),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ListTile(
//                               leading: Icon(
//                                 Icons.clear_all,
//                                 color: Colors.white,
//                               ),
//                               title: Text(
//                                 'Clear Chat',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               onTap: () {
//                                 controller.clearChat();
//                                 Navigator.pop(context);
//                               },
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.help, color: Colors.white),
//                               title: Text(
//                                 'Help',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 _showHelpDialog(context);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                 );
//               },
//               padding: EdgeInsets.all(8),
//               constraints: BoxConstraints(),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.black.withValues(alpha: 0.95),
//               Colors.black.withValues(alpha: 0.9),
//               Colors.black.withValues(alpha: 0.8),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: Obx(() {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   if (_scrollController.hasClients) {
//                     _scrollController.animateTo(
//                       _scrollController.position.maxScrollExtent,
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeOut,
//                     );
//                   }
//                 });

//                 return ListView.builder(
//                   controller: _scrollController,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//                   itemCount:
//                       controller.messages.length +
//                       (controller.isLoading.value ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     // If this is the loading indicator item
//                     if (controller.isLoading.value &&
//                         index == controller.messages.length) {
//                       return LoadingChatBubble(
//                         loadingText: controller.currentLoadingState.value,
//                       );
//                     }

//                     var message = controller.messages[index];
//                     return ChatBubble(
//                       message: message,
//                       isUser: message.isUser,
//                       showAvatar:
//                           index == 0 ||
//                           controller.messages[index - 1].isUser !=
//                               message.isUser,
//                       isTyping:
//                           !message.isUser &&
//                           controller.isTypingMessage.value &&
//                           index == controller.messages.length - 1,
//                     );
//                   },
//                 );
//               }),
//             ),
//             MessageInput(
//               controller: textController,
//               onSend: () {
//                 if (textController.text.trim().isNotEmpty) {
//                   controller.sendMessage(textController.text.trim());
//                   textController.clear();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showHelpDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             backgroundColor: Colors.grey.shade900,
//             title: Text(
//               'AI Assistant Help',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'I\'m your BON Credit AI assistant! I can help you with:',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 16),
//                 _buildHelpItem('💳 Credit card recommendations'),
//                 _buildHelpItem('📊 Interest rates and fees'),
//                 _buildHelpItem('🎁 Rewards programs'),
//                 _buildHelpItem('📈 Credit score improvement'),
//                 _buildHelpItem('💰 Debt management'),
//                 _buildHelpItem('📅 Financial planning'),
//                 SizedBox(height: 16),
//                 Text(
//                   'Just type your question and I\'ll provide personalized advice!',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Got it!',
//                   style: TextStyle(color: Colors.blueAccent),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   Widget _buildHelpItem(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Icon(Icons.check_circle, color: Colors.green, size: 16),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(color: Colors.white70, fontSize: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final ChatMessage message;
//   final bool isUser;
//   final bool showAvatar;
//   final bool isTyping;

//   const ChatBubble({
//     required this.message,
//     required this.isUser,
//     required this.showAvatar,
//     this.isTyping = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Row(
//         mainAxisAlignment:
//             isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!isUser && showAvatar) ...[
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withValues(alpha: 0.2),
//                     Colors.white.withValues(alpha: 0.1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.3),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                   BoxShadow(
//                     color: Colors.blueAccent.withValues(alpha: 0.2),
//                     blurRadius: 6,
//                     offset: Offset(0, 1),
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.all(8),
//               child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
//             ),
//             SizedBox(width: 12),
//           ] else if (!isUser) ...[
//             SizedBox(width: 48),
//           ],
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.75,
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors:
//                       isUser
//                           ? [
//                             Colors.blueAccent.withValues(alpha: 0.8),
//                             Colors.blueAccent.withValues(alpha: 0.6),
//                           ]
//                           : [
//                             Colors.white.withValues(alpha: 0.1),
//                             Colors.white.withValues(alpha: 0.05),
//                           ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(isUser ? 18 : 4),
//                   topRight: Radius.circular(isUser ? 4 : 18),
//                   bottomLeft: Radius.circular(18),
//                   bottomRight: Radius.circular(18),
//                 ),
//                 border: Border.all(
//                   color:
//                       isUser
//                           ? Colors.blueAccent.withValues(alpha: 0.3)
//                           : Colors.white.withValues(alpha: 0.2),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 12,
//                     spreadRadius: 1,
//                     offset: Offset(0, 4),
//                   ),
//                   BoxShadow(
//                     color:
//                         isUser
//                             ? Colors.blueAccent.withValues(alpha: 0.2)
//                             : Colors.blueAccent.withValues(alpha: 0.1),
//                     blurRadius: 8,
//                     spreadRadius: 0.5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           isUser ? message.text : message.displayedText,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             height: 1.4,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       if (isTyping) ...[
//                         SizedBox(width: 2),
//                         AnimatedTypingCursor(),
//                       ],
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         _formatTime(message.timestamp),
//                         style: TextStyle(
//                           color: Colors.white.withValues(alpha: 0.6),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       if (isUser) ...[
//                         SizedBox(width: 8),
//                         Icon(
//                           Icons.done_all,
//                           color: Colors.white.withValues(alpha: 0.6),
//                           size: 14,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isUser && showAvatar) ...[
//             SizedBox(width: 12),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withValues(alpha: 0.15),
//                     Colors.white.withValues(alpha: 0.08),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.25),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.all(8),
//               child: Icon(
//                 Icons.person,
//                 color: Colors.white.withValues(alpha: 0.9),
//                 size: 16,
//               ),
//             ),
//           ] else if (isUser) ...[
//             SizedBox(width: 48),
//           ],
//         ],
//       ),
//     );
//   }

//   String _formatTime(DateTime time) {
//     return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
//   }
// }

// class MessageInput extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onSend;

//   const MessageInput({required this.controller, required this.onSend});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.black.withValues(alpha: 0.8),
//             Colors.black.withValues(alpha: 0.9),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         border: Border(
//           top: BorderSide(
//             color: Colors.white.withValues(alpha: 0.15),
//             width: 1,
//           ),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.5),
//             blurRadius: 20,
//             spreadRadius: 5,
//             offset: Offset(0, -5),
//           ),
//           BoxShadow(
//             color: Colors.blueAccent.withValues(alpha: 0.1),
//             blurRadius: 15,
//             spreadRadius: 2,
//             offset: Offset(0, -3),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withValues(alpha: 0.1),
//                       Colors.white.withValues(alpha: 0.05),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: Colors.white.withValues(alpha: 0.2),
//                     width: 1.5,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.3),
//                       blurRadius: 12,
//                       spreadRadius: 1,
//                       offset: Offset(0, 4),
//                     ),
//                     BoxShadow(
//                       color: Colors.blueAccent.withValues(alpha: 0.1),
//                       blurRadius: 8,
//                       spreadRadius: 0.5,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: controller,
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                         decoration: InputDecoration(
//                           hintText: 'Ask me anything about finance...',
//                           hintStyle: TextStyle(
//                             color: Colors.white.withValues(alpha: 0.5),
//                             fontSize: 16,
//                           ),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 16,
//                           ),
//                         ),
//                         maxLines: null,
//                         textCapitalization: TextCapitalization.sentences,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(width: 12),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.blueAccent.withValues(alpha: 0.8),
//                     Colors.blueAccent.withValues(alpha: 0.6),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.3),
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blueAccent.withValues(alpha: 0.4),
//                     blurRadius: 12,
//                     spreadRadius: 2,
//                     offset: Offset(0, 4),
//                   ),
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     spreadRadius: 1,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 icon: Icon(Icons.send, color: Colors.white, size: 20),
//                 onPressed: onSend,
//                 padding: EdgeInsets.all(12),
//                 constraints: BoxConstraints(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoadingChatBubble extends StatefulWidget {
//   final String loadingText;

//   const LoadingChatBubble({required this.loadingText});

//   @override
//   _LoadingChatBubbleState createState() => _LoadingChatBubbleState();
// }

// class _LoadingChatBubbleState extends State<LoadingChatBubble>
//     with TickerProviderStateMixin {
//   late AnimationController _colorController;
//   late Animation<Color?> _colorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _colorController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);

//     _colorAnimation = ColorTween(
//       begin: Colors.white.withValues(alpha: 0.7),
//       end: Colors.blueAccent.withValues(alpha: 0.9),
//     ).animate(
//       CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _colorController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.2),
//                   Colors.white.withValues(alpha: 0.1),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.3),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.3),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//                 BoxShadow(
//                   color: Colors.blueAccent.withValues(alpha: 0.2),
//                   blurRadius: 6,
//                   offset: Offset(0, 1),
//                 ),
//               ],
//             ),
//             padding: EdgeInsets.all(8),
//             child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
//           ),
//           SizedBox(width: 12),
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.75,
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withValues(alpha: 0.1),
//                     Colors.white.withValues(alpha: 0.05),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(4),
//                   topRight: Radius.circular(18),
//                   bottomLeft: Radius.circular(18),
//                   bottomRight: Radius.circular(18),
//                 ),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.2),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 12,
//                     spreadRadius: 1,
//                     offset: Offset(0, 4),
//                   ),
//                   BoxShadow(
//                     color: Colors.blueAccent.withValues(alpha: 0.1),
//                     blurRadius: 8,
//                     spreadRadius: 0.5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: AnimatedBuilder(
//                 animation: _colorAnimation,
//                 builder: (context, child) {
//                   return Text(
//                     widget.loadingText,
//                     style: TextStyle(
//                       color: _colorAnimation.value,
//                       fontSize: 16,
//                       height: 1.4,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AnimatedTypingCursor extends StatefulWidget {
//   const AnimatedTypingCursor({super.key});

//   @override
//   _AnimatedTypingCursorState createState() => _AnimatedTypingCursorState();
// }

// class _AnimatedTypingCursorState extends State<AnimatedTypingCursor>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _animation.value,
//           child: Text(
//             '|',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
