import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../domain/controllers/enhanced_chat_controller.dart';
import '../../../../models/chat_models.dart';

class EnhancedChatbotScreen extends StatelessWidget {
  final EnhancedChatController controller = Get.put(EnhancedChatController());
  final TextEditingController textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  EnhancedChatbotScreen({super.key});
  //make key to open drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final RxBool isSending = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: _buildModernAppBar(context),
        drawer: _buildChatSidebar(context),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!.withValues(alpha: 0.9),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          border: Border(
            bottom: BorderSide(color: Colors.grey[700]!, width: 1.5.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20.r,
              spreadRadius: 5.r,
              offset: Offset(0, 5.h),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15.r,
              spreadRadius: 2.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
      ),
      title: Row(
        children: [
          GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 15.w),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(150.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10.r,
                  offset: Offset(0, 3.h),
                ),
                BoxShadow(
                  color: Colors.blueAccent.withValues(alpha: 0.2),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(5.w),
            child: Icon(Icons.smart_toy, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CredGPT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Online • Ready to help',
                  style: TextStyle(color: Colors.grey[400]!, fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
      toolbarHeight: 60.h,
      automaticallyImplyLeading: false,
      actions: [
        // More Menu Button (combines history and other options)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.15),
                Colors.white.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          margin: EdgeInsets.only(right: 10.w),
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            child: Icon(
              Icons.more_vert,
              color: Colors.white.withValues(alpha: 0.9),
              size: 20.sp,
            ),
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });

              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                itemCount:
                    controller.messages.length +
                    (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  // If this is the loading indicator item
                  if (controller.isLoading.value &&
                      index == controller.messages.length) {
                    return LoadingChatBubble(
                      loadingText: controller.currentLoadingState.value,
                    );
                  }

                  var message = controller.messages[index];
                  return EnhancedChatBubble(
                    message: message,
                    isUser: message.isUser,
                    showAvatar:
                        index == 0 ||
                        controller.messages[index - 1].isUser != message.isUser,
                    isTyping:
                        !message.isUser &&
                        controller.isTypingMessage.value &&
                        index == controller.messages.length - 1,
                    onCopy: () => controller.copyMessageText(message.text),
                  );
                },
              );
            }),
          ),
          MessageInput(
            controller: textController,
            onSend: () async {
              if (textController.text.trim().isNotEmpty && !isSending.value) {
                isSending.value = true;
                try {
                  await controller.sendMessage(textController.text.trim());
                } finally {
                  isSending.value = false;
                }
                textController.clear();
              }
            },
            isSending: isSending,
            onPause: () {
              isSending.value = false;
              controller.isTyping.value = false;
              controller.isLoading.value = false;
            },
            chatController: controller,
          ),
        ],
      ),
    );
  }

  Widget _buildChatSidebar(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        children: [
          // Header with New Chat button
          Container(
            height: 120.h,
            padding: EdgeInsets.only(
              top: 50.h,
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.grey.shade900,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1.w,
                ),
              ),
            ),
            child: Row(
              children: [
                // New Chat Button
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1.w,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.startNewConversation();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'New chat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat History Section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // History Header
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
                    child: Text(
                      'Recent',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // History List
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoadingHistory.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white.withValues(alpha: 0.7),
                            strokeWidth: 2,
                          ),
                        );
                      }

                      if (controller.conversationHistory.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white.withValues(alpha: 0.3),
                                size: 48.sp,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No conversations yet',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: controller.conversationHistory.length,
                        itemBuilder: (context, index) {
                          final conversation =
                              controller.conversationHistory[index];
                          final isCurrentConversation =
                              controller.currentConversation.value?.id ==
                              conversation.id;

                          return Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            child: Material(
                              color:
                                  isCurrentConversation
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8.r),
                                onTap: () {
                                  controller.loadConversation(conversation.id);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 0.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        color:
                                            isCurrentConversation
                                                ? Colors.white
                                                : Colors.white.withValues(
                                                  alpha: 0.6,
                                                ),
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              conversation.title,
                                              style: TextStyle(
                                                color:
                                                    isCurrentConversation
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withValues(
                                                              alpha: 0.9,
                                                            ),
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    isCurrentConversation
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              _formatDate(
                                                conversation.updatedAt,
                                              ),
                                              style: TextStyle(
                                                color: Colors.white.withValues(
                                                  alpha: 0.4,
                                                ),
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // More options for each conversation
                                      PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white.withValues(
                                            alpha: 0.5,
                                          ),
                                          size: 16.sp,
                                        ),
                                        color: Colors.grey.shade800,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          side: BorderSide(
                                            color: Colors.white.withValues(
                                              alpha: 0.1,
                                            ),
                                            width: 1.w,
                                          ),
                                        ),
                                        elevation: 8,
                                        offset: Offset(0, 0),
                                        padding: EdgeInsets.all(0.w),
                                        constraints: BoxConstraints(),
                                        itemBuilder:
                                            (context) => [
                                              PopupMenuItem<String>(
                                                value: 'rename',
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 16.sp,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      'Rename',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'delete',
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 16.sp,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                        onSelected: (value) {
                                          switch (value) {
                                            case 'rename':
                                              _showRenameDialog(
                                                context,
                                                conversation,
                                              );
                                              break;
                                            case 'delete':
                                              _deleteConversation(conversation);
                                              break;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with additional options
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1.w,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildSidebarOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    _showHelpDialog(context);
                  },
                ),
                SizedBox(height: 8.h),
                _buildSidebarOption(
                  icon: Icons.help_outline,
                  title: 'Help & FAQ',
                  onTap: () {
                    Navigator.pop(context);
                    _showHelpDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.7),
                size: 18.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }

  void _showRenameDialog(BuildContext context, ChatConversation conversation) {
    final TextEditingController renameController = TextEditingController(
      text: conversation.title,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            title: Text(
              'Rename conversation',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: renameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter new name',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (renameController.text.trim().isNotEmpty) {
                    controller.renameConversation(
                      conversation.id,
                      renameController.text.trim(),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Save', style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          ),
    );
  }

  void _deleteConversation(ChatConversation conversation) {
    controller.deleteConversation(conversation.id);
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            title: Text(
              'How to use AI Assistant',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHelpItem('Ask about credit cards and financial advice'),
                _buildHelpItem('Get recommendations for rewards and rates'),
                _buildHelpItem('Learn about debt management strategies'),
                _buildHelpItem('Long press AI messages to copy them'),
                _buildHelpItem('View your chat history anytime'),
                _buildHelpItem('Start new conversations as needed'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Got it!',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class EnhancedChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isUser;
  final bool showAvatar;
  final bool isTyping;
  final VoidCallback onCopy;

  const EnhancedChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.showAvatar,
    this.isTyping = false,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser && showAvatar) ...[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),
                    blurRadius: 6.r,
                    offset: Offset(0, 1.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16.sp),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: GestureDetector(
              onLongPress: !isUser ? onCopy : null,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient:
                      isUser
                          ? LinearGradient(
                            colors: [
                              Colors.blueAccent.withValues(alpha: 0.9),
                              Colors.blueAccent.withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.12),
                              Colors.white.withValues(alpha: 0.08),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  borderRadius: BorderRadius.circular(
                    isUser ? 18.r : 16.r,
                  ).copyWith(
                    topLeft:
                        isUser ? Radius.circular(18.r) : Radius.circular(4.r),
                    topRight:
                        isUser ? Radius.circular(4.r) : Radius.circular(18.r),
                  ),
                  border: Border.all(
                    color:
                        isUser
                            ? Colors.blueAccent.withValues(alpha: 0.6)
                            : Colors.white.withValues(alpha: 0.2),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isUser
                              ? Colors.blueAccent.withValues(alpha: 0.4)
                              : Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12.r,
                      spreadRadius: 2.r,
                      offset: Offset(0, 4.h),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Message content with markdown support
                    if (isTyping)
                      Text(
                        message.displayedText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          height: 1.4,
                        ),
                      )
                    else if (!isUser) // Always use markdown for AI responses
                      Container(
                        child: MarkdownBody(
                          data: message.text,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              height: 1.4,
                            ),
                            strong: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            em: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontStyle: FontStyle.italic,
                            ),
                            del: TextStyle(
                              color: Colors.white70,
                              fontSize: 15.sp,
                              decoration: TextDecoration.lineThrough,
                            ),
                            blockquote: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic,
                            ),
                            code: TextStyle(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              color: Colors.greenAccent,
                              fontFamily: 'monospace',
                              fontSize: 14.sp,
                            ),
                            codeblockDecoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            listBullet: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                            h1: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            h2: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            h3: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    else
                      Text(
                        message.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          height: 1.4,
                        ),
                      ),
                    if (!isUser && !isTyping) ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getTimeString(message.timestamp),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.content_copy,
                            color: Colors.white.withValues(alpha: 0.6),
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Long press to copy',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (isUser) ...[
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _getTimeString(message.timestamp),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.check,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 12.sp,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (isUser && showAvatar) ...[
            SizedBox(width: 8.w),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withValues(alpha: 0.3),
                    Colors.blueAccent.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.blueAccent.withValues(alpha: 0.5),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.person, color: Colors.blueAccent, size: 16.sp),
            ),
          ],
        ],
      ),
    );
  }

  String _getTimeString(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}

class LoadingChatBubble extends StatefulWidget {
  final String loadingText;

  const LoadingChatBubble({super.key, required this.loadingText});

  @override
  _LoadingChatBubbleState createState() => _LoadingChatBubbleState();
}

class _LoadingChatBubbleState extends State<LoadingChatBubble>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.white.withValues(alpha: 0.7),
      end: Colors.blueAccent.withValues(alpha: 0.9),
    ).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(8.w),
            child: Icon(Icons.smart_toy, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.12),
                    Colors.white.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(
                  16.r,
                ).copyWith(topLeft: Radius.circular(4.r)),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12.r,
                    spreadRadius: 2.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Text(
                    widget.loadingText,
                    style: TextStyle(
                      color: _colorAnimation.value,
                      fontSize: 15.sp,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final RxBool isSending;
  final VoidCallback onPause;
  final EnhancedChatController chatController;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isSending,
    required this.onPause,
    required this.chatController,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.9),
            Colors.black.withValues(alpha: 0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: _isExpanded ? 120.h : 60.h,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(250.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      enabled:
                          !(widget.isSending.value ||
                              widget.chatController.isTyping.value ||
                              widget.chatController.isLoading.value),
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      decoration: InputDecoration(
                        hintText: 'Ask about credit cards, rates, rewards...',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 16.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: _isExpanded ? null : 1,
                      textInputAction:
                          _isExpanded
                              ? TextInputAction.newline
                              : TextInputAction.send,
                      onSubmitted: (_) => widget.onSend(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_more : Icons.expand_less,
                      color: Colors.white.withOpacity(0.7),
                      size: 20.sp,
                    ),
                    onPressed: _toggleExpanded,
                    padding: EdgeInsets.all(8.w),
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withValues(alpha: 0.8),
                    Colors.blueAccent.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(200.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.4),
                    blurRadius: 12.r,
                    spreadRadius: 2.r,
                    offset: Offset(0, 4.h),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  (widget.isSending.value ||
                          widget.chatController.isTyping.value ||
                          widget.chatController.isLoading.value)
                      ? Icons.pause
                      : Icons.send,
                  color: Colors.white,
                  size: 20.sp,
                ),
                onPressed:
                    (widget.isSending.value ||
                            widget.chatController.isTyping.value ||
                            widget.chatController.isLoading.value)
                        ? widget.onPause
                        : widget.onSend,
                padding: EdgeInsets.all(12.w),
                constraints: BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
