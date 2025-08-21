import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/promotion_section_card.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/promotion_controller.dart';
import '../../../../services/notification_services.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/text_inputs.dart';

class SendNotificationSection extends StatefulWidget {
  final PromotionController controller;

  const SendNotificationSection({super.key, required this.controller});

  @override
  State<SendNotificationSection> createState() =>
      _SendNotificationSectionState();
}

class _SendNotificationSectionState extends State<SendNotificationSection> {
  String? errorText;
  bool isButtonDisabled = true;
  int _currentLength = 0; // Track input length

  @override
  void initState() {
    super.initState();
    _currentLength = widget.controller.notificationController.text.length;
    _validateInput(widget.controller.notificationController.text);
    widget.controller.notificationController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.notificationController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.notificationController.text;
    setState(() {
      _currentLength = text.length;
    });
    _validateInput(text);
  }

  void _validateInput(String text) {
    setState(() {
      if (text.isEmpty) {
        errorText = null;
        isButtonDisabled = true;
      } else if (text.length > 300) {
        errorText = "Message cannot exceed 300 characters";
        isButtonDisabled = true;
      } else {
        errorText = null;
        isButtonDisabled = false;
      }
    });
  }

  Future<void> _sendNotification() async {
    final text = widget.controller.notificationController.text;

    // Extra safety validation
    if (text.isEmpty || text.length > 300) {
      setState(() {
        errorText =
            text.length > 300 ? "Message cannot exceed 300 characters" : null;
        isButtonDisabled = true;
      });
      return;
    }

    if (isButtonDisabled) return;

    try {
      await NotificationServices().sendNotificationToAllUsers(
        title: "Special Discount 🎉",
        body: text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification sent successfully')),
      );

      // Clear input after sending
      widget.controller.notificationController.clear();
      _validateInput('');
      setState(() {
        _currentLength = 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PromotionSectionCard(
      title: "3. Send Discount Notification",
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PromotionScreenTextInput(
                  maxLines: 3,
                  labelText: 'Promotion Message',
                  isPrefixIconRequired: false,
                  controller: widget.controller.notificationController,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$_currentLength / 300',
                    style: TextStyle(
                      color: _currentLength > 300 ? Colors.red : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                SecondaryButton(
                  title: "Send Notification",
                  btnColor: AppColors.primaryColor,
                  onPressed: isButtonDisabled ? null : _sendNotification,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
