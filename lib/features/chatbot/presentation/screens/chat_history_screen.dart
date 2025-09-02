import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/controllers/enhanced_chat_controller.dart';
import '../../../../models/chat_models.dart';

class ChatHistoryScreen extends StatelessWidget {
  final EnhancedChatController controller = Get.find<EnhancedChatController>();

  ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.9),
              Colors.black.withValues(alpha: 0.7),
              Colors.black.withValues(alpha: 0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5.w,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20.r,
              spreadRadius: 5.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
      ),
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(15.r),
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
              ],
            ),
            padding: EdgeInsets.all(10.w),
            child: Icon(Icons.history, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat History',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Text(
                    '${controller.conversationHistory.length} conversations',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      toolbarHeight: 70.h,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
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
          margin: EdgeInsets.only(right: 16.w),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white.withValues(alpha: 0.9),
              size: 20.sp,
            ),
            onPressed: () {
              controller.startNewConversation();
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(8.w),
            constraints: BoxConstraints(),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.95),
            Colors.black.withValues(alpha: 0.9),
            Colors.black.withValues(alpha: 0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Obx(() {
        if (controller.isLoadingHistory.value) {
          return _buildLoadingState();
        }

        if (controller.conversationHistory.isEmpty) {
          return _buildEmptyState();
        }

        return _buildHistoryList();
      }),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          SizedBox(height: 20.h),
          Text(
            'Loading chat history...',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 2.w,
              ),
            ),
            padding: EdgeInsets.all(30.w),
            child: Icon(
              Icons.chat_outlined,
              size: 60.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            'No chat history yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start a conversation with your AI assistant',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              controller.startNewConversation();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            child: Text(
              'Start New Chat',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: controller.conversationHistory.length,
      itemBuilder: (context, index) {
        final conversation = controller.conversationHistory[index];
        return _buildConversationTile(conversation, index);
      },
    );
  }

  Widget _buildConversationTile(ChatConversation conversation, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1.w,
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
      child: ListTile(
        contentPadding: EdgeInsets.all(15.w),
        leading: Container(
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
          ),
          padding: EdgeInsets.all(10.w),
          child: Icon(
            Icons.chat_bubble_outline,
            color: Colors.blueAccent,
            size: 20.sp,
          ),
        ),
        title: Text(
          conversation.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Text(
              conversation.getPreview(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 12.sp,
                ),
                SizedBox(width: 5.w),
                Text(
                  conversation.getFormattedDate(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.blueAccent.withValues(alpha: 0.3),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    '${conversation.messages.length} messages',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          color: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.w,
            ),
          ),
          onSelected: (value) {
            switch (value) {
              case 'rename':
                _showRenameDialog(conversation);
                break;
              case 'delete':
                _showDeleteDialog(conversation);
                break;
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'rename',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.white, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text('Rename', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
        ),
        onTap: () {
          controller.loadConversation(conversation.id);
          Get.back();
        },
      ),
    );
  }

  void _showRenameDialog(ChatConversation conversation) {
    final textController = TextEditingController(text: conversation.title);

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.w,
          ),
        ),
        title: Text(
          'Rename Conversation',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: textController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new title',
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
            ),
          ),
          autofocus: true,
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = textController.text.trim();
              if (newTitle.isNotEmpty) {
                controller.renameConversation(conversation.id, newTitle);
                Get.back();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            child: Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(ChatConversation conversation) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(
            color: Colors.red.withValues(alpha: 0.3),
            width: 1.w,
          ),
        ),
        title: Text('Delete Conversation', style: TextStyle(color: Colors.red)),
        content: Text(
          'Are you sure you want to delete "${conversation.title}"? This action cannot be undone.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteConversation(conversation.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
