import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_text_styles.dart';

class OrderStatusDropdownWidget extends StatelessWidget {
  final String? selectedFilterValue;
  final Function(String? v)? onChanged;
  const OrderStatusDropdownWidget({
    super.key,
    this.selectedFilterValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: 280.w,
      // height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x7F2E2E2E)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          style: AppTextStyles.h1.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          value: selectedFilterValue,
          isExpanded: true,
          items: [
            DropdownMenuItem(value: 'All Orders', child: Text('All Orders')),
            DropdownMenuItem(value: 'Pending', child: Text('Pending Orders')),
            DropdownMenuItem(value: 'Confirmed', child: Text('Confirm Orders')),
            DropdownMenuItem(value: 'Cancelled', child: Text('Cancel Orders')),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
