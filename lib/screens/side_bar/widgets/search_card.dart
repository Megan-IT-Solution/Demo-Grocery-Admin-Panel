import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';

class SearchCard extends StatefulWidget {
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final TextEditingController? controller;
  final Function(String? v)? onChanged;

  const SearchCard({
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.controller,
    this.onChanged,
  });

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  String _selectedFilter = 'All Orders';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: const EdgeInsets.symmetric(horizontal: 19),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            "Total Orders",
            style: AppTextStyles.nunitoSemiBod.copyWith(fontSize: 20.sp),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 180.w,
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x7F2E2E2E)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFilter,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'All Orders',
                    child: Text('All Orders'),
                  ),
                  DropdownMenuItem(
                    value: 'Pending Orders',
                    child: Text('Pending Orders'),
                  ),
                  DropdownMenuItem(
                    value: 'Confirm Orders',
                    child: Text('Confirm Orders'),
                  ),
                  DropdownMenuItem(
                    value: 'Cancel Orders',
                    child: Text('Cancel Orders'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedFilter = value;
                    });
                    // Optional: callback here if needed
                  }
                },
              ),
            ),
          ),
          const Spacer(),
          Text(
            "${AppStrings.search}:",
            style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
          ),
          SizedBox(width: 22.w),
          SizedBox(
            width: 292.w,
            height: 58.h,
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0x7F2E2E2E)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
