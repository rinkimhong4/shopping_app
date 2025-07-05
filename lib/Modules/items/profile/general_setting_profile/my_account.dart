import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class MyAccountItems extends StatefulWidget {
  const MyAccountItems({super.key});

  @override
  State<MyAccountItems> createState() => _MyAccountItemsState();
}

class _MyAccountItemsState extends State<MyAccountItems> {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();
  late final TextEditingController usernameCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController phoneNumberCtrl;
  late final TextEditingController genderCtrl;
  late final TextEditingController addressCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final user = authController.currentUser;

    usernameCtrl = TextEditingController(
      text:
          profileController.username.value.isNotEmpty
              ? profileController.username.value
              : (user?.email?.split('@')[0] ?? 'Guest'),
    );

    emailCtrl = TextEditingController(
      text:
          profileController.email.value.isNotEmpty
              ? profileController.email.value
              : (user?.email ?? 'guest@gmail.com'),
    );

    phoneNumberCtrl = TextEditingController(
      text:
          profileController.phoneNumber.value.isNotEmpty
              ? profileController.phoneNumber.value
              : '000-000-0000',
    );

    genderCtrl = TextEditingController(
      text:
          profileController.gender.value.isNotEmpty
              ? profileController.gender.value
              : '',
    );

    addressCtrl = TextEditingController(
      text:
          profileController.address.value.isNotEmpty
              ? profileController.address.value
              : '',
    );
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneNumberCtrl.dispose();
    genderCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(appBar: _buildAppBar(context), body: _buildBody(context)),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Account',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 14), _buildEditProfileSection(context)],
      ),
    );
  }

  Widget _buildEditProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImageSection(context),
        SizedBox(height: 14),
        _buildProfileFields(context),
      ],
    );
  }

  Widget _buildProfileImageSection(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Obx(() {
          final imagePath = profileController.profileImageUrl.value;
          if (profileController.isLoading.value) {
            return _buildLoadingAvatar(context);
          }
          return imagePath.isNotEmpty
              ? _buildAvatarFromPath(context, imagePath)
              : _defaultAvatar(context);
        }),
        Obx(() {
          return profileController.isLoading.value
              ? SizedBox()
              : _buildChangeProfilePictureButton(context);
        }),
      ],
    );
  }

  Widget _buildLoadingAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 74,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: 72,
        backgroundColor: Theme.of(context).cardColor,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildAvatarFromPath(BuildContext context, String imagePath) {
    if (imagePath.startsWith('http')) {
      return CircleAvatar(
        radius: 74,
        backgroundColor: Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: 72,
          backgroundColor: Theme.of(context).cardColor,
          backgroundImage: NetworkImage(imagePath),
          onBackgroundImageError: (_, __) => debugPrint("Network image error"),
        ),
      );
    } else {
      final file = File(imagePath);
      return file.existsSync()
          ? CircleAvatar(
            radius: 74,
            backgroundColor: Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: 72,
              backgroundColor: Theme.of(context).cardColor,
              backgroundImage: FileImage(file),
            ),
          )
          : _defaultAvatar(context);
    }
  }

  Widget _buildChangeProfilePictureButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final userId = authController.currentUser?.id;
        if (userId != null) {
          await profileController.uploadProfileImage(userId);
        }
      },
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).cardColor, width: 2),
        ),
        child: Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white),
      ),
    );
  }

  Widget _defaultAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: 58,
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.person, size: 56, color: Theme.of(context).hintColor),
      ),
    );
  }

  Widget _buildProfileFields(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            context,
            label: 'Username',
            controller: usernameCtrl,
            isRequired: true,
          ),
          _buildTextField(
            context,
            label: 'Email',
            controller: emailCtrl,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null &&
                  !RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          _buildTextField(
            context,
            label: 'Phone Number',
            controller: phoneNumberCtrl,
            isRequired: true,
            keyboardType: TextInputType.phone,
          ),
          _buildTextField(
            context,
            label: 'Gender',
            controller: genderCtrl,
            isRequired: false,
          ),
          _buildTextField(
            context,
            label: 'Address',
            controller: addressCtrl,
            isRequired: true,
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoute.changePassword);
            },
            child: Text(
              'Change Password',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 30),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required bool isRequired,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Please enter $label';
            }
            return validator?.call(value);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 24),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: AppColors.textPrimary),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          autocorrect: false,
        ),
        SizedBox(height: 14),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: Obx(() {
        return ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
            backgroundColor: WidgetStateProperty.all<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          onPressed:
              profileController.isLoading.value
                  ? null
                  : () async {
                    if (_formKey.currentState!.validate()) {
                      await profileController.updateProfile(
                        newUsername: usernameCtrl.text,
                        newEmail: emailCtrl.text,
                        newGender: genderCtrl.text,
                        newPhoneNumber: phoneNumberCtrl.text,
                        newAddress: addressCtrl.text,
                      );
                    }
                  },
          child:
              profileController.isLoading.value
                  ? CircularProgressIndicator.adaptive(strokeWidth: 2)
                  : Text('Save'),
        );
      }),
    );
  }
}
