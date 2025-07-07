// Controller for managing logic
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPreferenceController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Reactive variable for button state (e.g., to enable/disable send button)
  var isFormValid = false.obs;

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // Validate form and update button state
  void validateForm() {
    isFormValid.value = formKey.currentState?.validate() ?? false;
  }

  // Handle send button press
  void onSendPressed() {
    if (formKey.currentState?.validate() ?? false) {
      // Handle form submission logic here
      // print(
      //   'Form submitted: '
      //   'First Name: ${firstNameController.text}, '
      //   'Last Name: ${lastNameController.text}, '
      //   'Email: ${emailController.text}, '
      //   'Phone: ${phoneController.text}, '
      //   'Message: ${messageController.text}',
      // );
      // Optionally clear form
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneController.clear();
      messageController.clear();
      isFormValid.value = false;
    }
  }

  // Social media tap handlers
  void onFacebookTap() => ('Facebook tapped');
  void onInstagramTap() => ('Instagram tapped');
  void onTelegramTap() => ('Telegram tapped');
}
