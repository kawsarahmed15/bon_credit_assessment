import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/controllers/marketplace_controller.dart';
import '../../domain/models/marketplace_card.dart';
import 'marketplace_card_detail_screen.dart';

class MarketplaceHomeScreen extends StatelessWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketplaceController controller = Get.put(MarketplaceController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 21, 12, 32),
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1.5.w,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20.r,
                spreadRadius: 5.r,
                offset: Offset(0, 5.h),
              ),
              BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                blurRadius: 15.r,
                spreadRadius: 2.r,
                offset: Offset(0, 3.h),
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
                    Colors.deepPurpleAccent.withOpacity(0.2),
                    Colors.deepPurpleAccent.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(0.3),
                  width: 1.w,
                ),
              ),
              padding: EdgeInsets.all(4.w),
              child: Icon(
                CupertinoIcons.creditcard_fill,
                color: Colors.deepPurpleAccent,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Card Marketplace',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.w,
              ),
            ),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.white,
                size: 18.sp,
              ),
              onPressed: () => _showFilterDialog(context, controller),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: CustomScrollView(
          slivers: [
            // Modern search bar
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 3.h),
                      ),
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(0.1),
                        blurRadius: 6.r,
                        spreadRadius: 0.5.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search cards...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14.sp,
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(8.w),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.deepPurpleAccent,
                          size: 16.sp,
                        ),
                      ),
                      suffixIcon: Obx(
                        () =>
                            controller.searchQuery.value.isNotEmpty
                                ? Container(
                                  padding: EdgeInsets.all(6.w),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      color: Colors.white.withOpacity(0.6),
                                      size: 16.sp,
                                    ),
                                    onPressed: controller.clearSearch,
                                  ),
                                )
                                : SizedBox(),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Modern category filters
            SliverToBoxAdapter(
              child: Container(
                height: 30.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return Obx(
                      () => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: GestureDetector(
                          onTap: () => controller.updateCategory(category),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              gradient:
                                  controller.selectedCategory.value == category
                                      ? LinearGradient(
                                        colors: [
                                          Colors.deepPurpleAccent,
                                          Colors.deepPurpleAccent.shade100,
                                        ],
                                      )
                                      : LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                      ),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color:
                                    controller.selectedCategory.value ==
                                            category
                                        ? Colors.deepPurpleAccent.withOpacity(
                                          0.5,
                                        )
                                        : Colors.white.withOpacity(0.2),
                                width: 1.w,
                              ),
                              boxShadow:
                                  controller.selectedCategory.value == category
                                      ? [
                                        BoxShadow(
                                          color: Colors.deepPurpleAccent
                                              .withOpacity(0.3),
                                          blurRadius: 6.r,
                                          spreadRadius: 1.r,
                                          offset: Offset(0, 3.h),
                                        ),
                                      ]
                                      : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 3.r,
                                          offset: Offset(0, 1.h),
                                        ),
                                      ],
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      controller.selectedCategory.value ==
                                              category
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.8),
                                  fontSize: 12.sp,
                                  fontWeight:
                                      controller.selectedCategory.value ==
                                              category
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Featured offers banner
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.cardOffers.isEmpty) return SizedBox();
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  height: 110.h,
                  child: PageView.builder(
                    itemCount: controller.cardOffers.length,
                    itemBuilder: (context, index) {
                      final offer = controller.cardOffers[index];
                      return _buildOfferBanner(offer);
                    },
                  ),
                );
              }),
            ),

            // Modern Sort and Filter Section
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.04),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.r,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.sort_down,
                      color: Colors.white.withOpacity(0.8),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Sort by:',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 25.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurpleAccent.withOpacity(0.2),
                              Colors.deepPurpleAccent.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(0.3),
                            width: 1.w,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: controller.sortBy.value,
                          dropdownColor: Colors.grey.shade900,
                          padding: EdgeInsets.zero,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          underline: Container(),
                          icon: Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.white.withOpacity(0.7),
                            size: 12.sp,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'rating',
                              child: Text('⭐ Rating'),
                            ),
                            DropdownMenuItem(
                              value: 'apr',
                              child: Text('📊 APR'),
                            ),
                            DropdownMenuItem(
                              value: 'cashback',
                              child: Text('💰 Cashback'),
                            ),
                            DropdownMenuItem(
                              value: 'name',
                              child: Text('🔤 Name'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.updateSortBy(value);
                            }
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.creditcard,
                              color: Colors.white.withOpacity(0.7),
                              size: 12.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${controller.filteredCards.length} cards',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Cards list
            Obx(() {
              if (controller.isLoading.value) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade600,
                    ),
                  ),
                );
              }

              if (controller.filteredCards.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_off,
                          size: 64.sp,
                          color: Colors.white30,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No cards found',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try adjusting your filters',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final card = controller.filteredCards[index];
                  return _buildCardItem(context, card, controller);
                }, childCount: controller.filteredCards.length),
              );
            }),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: 80.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferBanner(CardOffer offer) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurpleAccent,
            Colors.deepPurpleAccent.shade100,
            Colors.purpleAccent.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.3),
            blurRadius: 20.r,
            spreadRadius: 2.r,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // Add glassmorphism overlay
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.transparent,
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (offer.isLimitedTime)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.white.withOpacity(0.9)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Text(
                        'LIMITED TIME',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                offer.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                offer.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(
    BuildContext context,
    MarketplaceCard card,
    MarketplaceController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
              card.isPromoted
                  ? Colors.deepPurpleAccent.withOpacity(0.4)
                  : Colors.white.withOpacity(0.15),
          width: card.isPromoted ? 2.w : 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16.r,
            spreadRadius: 1.r,
            offset: Offset(0, 6.h),
          ),
          BoxShadow(
            color:
                card.isPromoted
                    ? Colors.deepPurpleAccent.withOpacity(0.2)
                    : Colors.black.withOpacity(0.1),
            blurRadius: 12.r,
            spreadRadius: 1.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => Get.to(() => MarketplaceCardDetailScreen(card: card)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              // Add subtle texture overlay
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.transparent,
                  Colors.black.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with enhanced design
                  Row(
                    children: [
                      // Modern card issuer logo
                      Container(
                        width: 40.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurpleAccent.withOpacity(0.3),
                              Colors.deepPurpleAccent.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(0.4),
                            width: 1.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withOpacity(0.2),
                              blurRadius: 6.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            card.issuer.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              card.issuer,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (card.isPromoted)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurpleAccent,
                                Colors.deepPurpleAccent.shade100,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent.withOpacity(0.3),
                                blurRadius: 6.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                          child: Text(
                            'FEATURED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Benefits with modern chips
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children:
                        card.benefits.take(3).map((benefit) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.15),
                                  Colors.white.withOpacity(0.08),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3.r,
                                  offset: Offset(0, 1.h),
                                ),
                              ],
                            ),
                            child: Text(
                              benefit,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                  ),

                  SizedBox(height: 12.h),

                  // Enhanced key stats
                  Row(
                    children: [
                      _buildModernStatChip(
                        '${card.apr}% APR',
                        CupertinoIcons.percent,
                      ),
                      SizedBox(width: 6.w),
                      _buildModernStatChip(
                        card.annualFee == 0
                            ? 'No Fee'
                            : '\$${card.annualFee.toInt()} Fee',
                        CupertinoIcons.money_dollar_circle,
                      ),
                      SizedBox(width: 6.w),
                      if (card.cashbackRate > 0)
                        _buildModernStatChip(
                          '${card.cashbackRate}% Back',
                          CupertinoIcons.money_dollar,
                        ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Modern rating and apply button
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.3),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.amber,
                              size: 12.sp,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '${card.rating} (${card.reviewCount})',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurpleAccent,
                              Colors.deepPurpleAccent.shade100,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withOpacity(0.3),
                              blurRadius: 10.r,
                              spreadRadius: 1.r,
                              offset: Offset(0, 3.h),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => controller.applyForCard(card),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          child: Text(
                            'Apply Now',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernStatChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.12),
            Colors.white.withOpacity(0.06),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: 12.sp),
          SizedBox(width: 3.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(
    BuildContext context,
    MarketplaceController controller,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text('Filter Cards', style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => SwitchListTile(
                    title: Text(
                      'No Annual Fee Only',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: controller.showZeroFeeOnly.value,
                    onChanged: (value) => controller.toggleZeroFeeFilter(),
                    activeColor: Colors.blue.shade600,
                  ),
                ),
                // Add more filter options here
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.blue.shade400),
                ),
              ),
            ],
          ),
    );
  }
}
