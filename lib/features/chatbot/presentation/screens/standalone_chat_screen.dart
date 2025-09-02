// // Deprecated StandaloneChatScreen removed. Use EnhancedChatbotScreen.

//               return ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.all(16),
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];
//                   return _buildMessageBubble(message, context);
//                 },
//               );
//             }),
//           ),
//           _buildLoadingIndicator(),
//           _buildInputSection(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(ChatMessage message, BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment:
//             message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!message.isUser) ...[
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
//             ),
//             SizedBox(width: 12),
//           ],
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: message.isUser ? Colors.blue[100]! : Colors.grey[800]!,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(message.isUser ? 20 : 8),
//                   topRight: Radius.circular(message.isUser ? 8 : 20),
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 border: Border.all(color: Colors.grey[600]!, width: 1),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child:
//                   message.isUser
//                       ? Text(
//                         message.text,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           height: 1.4,
//                         ),
//                       )
//                       : MarkdownBody(
//                         data: message.text,
//                         styleSheet: MarkdownStyleSheet(
//                           p: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             height: 1.4,
//                           ),
//                           strong: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           em: TextStyle(
//                             color: Colors.grey[400]!,
//                             fontStyle: FontStyle.italic,
//                           ),
//                           code: TextStyle(
//                             color: Colors.blue,
//                             backgroundColor: Colors.white.withOpacity(0.3),
//                             fontFamily: 'monospace',
//                           ),
//                           listBullet: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//             ),
//           ),
//           if (message.isUser) ...[
//             SizedBox(width: 12),
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(Icons.person, color: Colors.white, size: 20),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Obx(() {
//       if (!controller.isLoading.value && !controller.isTyping.value) {
//         return SizedBox.shrink();
//       }

//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[800]!,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8),
//                     topRight: Radius.circular(20),
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   border: Border.all(color: Colors.grey[600]!, width: 1),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.3),
//                       blurRadius: 8,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     if (controller.isLoading.value) ...[
//                       Text(
//                         controller.currentLoadingState.value,
//                         style: TextStyle(
//                           color: Colors.grey[400]!,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                     ],
//                     SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildInputSection() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.grey[600]!, width: 1)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.3),
//             blurRadius: 20,
//             offset: Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.blue, width: 1),
//               ),
//               child: TextField(
//                 controller: textController,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Ask about credit cards, finances...',
//                   hintStyle: TextStyle(color: Colors.grey[400]!),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                 ),
//                 maxLines: null,
//                 textInputAction: TextInputAction.send,
//                 onSubmitted: (text) => _sendMessage(text),
//               ),
//             ),
//           ),
//           SizedBox(width: 12),
//           Obx(
//             () => Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors:
//                       controller.isLoading.value || controller.isTyping.value
//                           ? [Colors.grey[400]!, Colors.blue]
//                           : [Colors.blue, Colors.purple],
//                 ),
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed:
//                     (controller.isLoading.value || controller.isTyping.value)
//                         ? null
//                         : () => _sendMessage(textController.text),
//                 icon: Icon(Icons.send, color: Colors.white, size: 20),
//                 padding: EdgeInsets.all(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatSidebar(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.black, Colors.grey[900]!],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey[600]!, width: 1),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.history, color: Colors.white, size: 24),
//                   SizedBox(width: 12),
//                   Text(
//                     'Chat History',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: Icon(Icons.close, color: Colors.blue, size: 20),
//                   ),
//                 ],
//               ),
//             ),

//             // New Chat Button
//             Container(
//               margin: EdgeInsets.all(16),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   controller.startNewConversation();
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.add, color: Colors.white),
//                 label: Text('New Chat', style: TextStyle(color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//             ),

//             // Chat History List
//             Expanded(
//               child: Obx(() {
//                 if (controller.isLoadingHistory.value) {
//                   return Center(
//                     child: CircularProgressIndicator(color: Colors.blue),
//                   );
//                 }

//                 if (controller.conversationHistory.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'No chat history yet',
//                       style: TextStyle(color: Colors.grey[400]!, fontSize: 16),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   itemCount: controller.conversationHistory.length,
//                   itemBuilder: (context, index) {
//                     final conversation = controller.conversationHistory[index];
//                     return Container(
//                       margin: EdgeInsets.symmetric(vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.grey[600]!, width: 1),
//                       ),
//                       child: ListTile(
//                         title: Text(
//                           conversation.title,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         subtitle: Text(
//                           '${conversation.messages.length} messages',
//                           style: TextStyle(
//                             color: Colors.grey[400]!,
//                             fontSize: 12,
//                           ),
//                         ),
//                         leading: Icon(
//                           Icons.chat_bubble_outline,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                         trailing: PopupMenuButton<String>(
//                           icon: Icon(
//                             Icons.more_vert,
//                             color: Colors.blue,
//                             size: 18,
//                           ),
//                           onSelected: (value) {
//                             if (value == 'rename') {
//                               _showRenameDialog(context, conversation);
//                             } else if (value == 'delete') {
//                               _showDeleteDialog(context, conversation);
//                             }
//                           },
//                           itemBuilder:
//                               (context) => [
//                                 PopupMenuItem(
//                                   value: 'rename',
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.edit,
//                                         size: 16,
//                                         color: Colors.blue,
//                                       ),
//                                       SizedBox(width: 8),
//                                       Text(
//                                         'Rename',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'delete',
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.delete,
//                                         size: 16,
//                                         color: Colors.blue,
//                                       ),
//                                       SizedBox(width: 8),
//                                       Text(
//                                         'Delete',
//                                         style: TextStyle(color: Colors.blue),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                         ),
//                         onTap: () {
//                           controller.loadConversation(conversation.id);
//                           Navigator.pop(context);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _sendMessage(String text) {
//     if (text.trim().isNotEmpty) {
//       controller.sendMessage(text);
//       textController.clear();
//     }
//   }

//   void _showRenameDialog(BuildContext context, ChatConversation conversation) {
//     final TextEditingController renameController = TextEditingController(
//       text: conversation.title,
//     );

//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text(
//               'Rename Conversation',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: TextField(
//               controller: renameController,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Enter new name',
//                 hintStyle: TextStyle(color: Colors.grey[400]!),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey[600]!),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blue),
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(color: Colors.grey[400]!),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.renameConversation(
//                     conversation.id,
//                     renameController.text.trim(),
//                   );
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 child: Text('Rename', style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context, ChatConversation conversation) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text(
//               'Delete Conversation',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: Text(
//               'Are you sure you want to delete "${conversation.title}"? This action cannot be undone.',
//               style: TextStyle(color: Colors.grey[400]!),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(color: Colors.grey[400]!),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.deleteConversation(conversation.id);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 child: Text('Delete', style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//     );
//   }
// }
