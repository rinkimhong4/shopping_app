import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/app_footer.dart';

class ContactPreferenceItems extends StatelessWidget {
  const ContactPreferenceItems({super.key});

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
        'Contact Preference',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          _buildHeading(context),
          _buildTextFormFields(context),
          SizedBox(height: 50),
          FooterApp(),
        ],
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    List<Map<String, dynamic>> contactTitle = [
      {
        'title': 'Contact  Us',
        'subTitle': 'Any question or remarks? Just write us a message!',
      },
      {
        'title': 'Contact Information',
        'subTitle': 'Say something to start a live chat!!',
      },
    ];
    List<Map<String, dynamic>> contactSocial = [
      {'icon': Icons.phone, 'contact': '+855 86 240668'},
      {'icon': Icons.email_outlined, 'contact': 'rinkimhong4@gmail.com'},
      {
        'icon': Icons.location_on_outlined,
        'contact':
            '25 Street 2009'
            'Sangkat Tuek Thla'
            'Phnom Penh, Cambodia',
      },
    ];
    List<Map<String, dynamic>> socialMedia = [
      {
        'icon': AppAssets.facebook,
        'onTap': () {
          // print("Facebook tapped");
        },
      },
      {
        'icon': AppAssets.instagram,
        'onTap': () {
          // print("Chat tapped");
        },
      },
      {
        'icon': AppAssets.telegram,
        'onTap': () {
          // print("Telegram tapped");
        },
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        spacing: 10,
        children: [
          Text(
            contactTitle[0]['title'],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            contactTitle[0]['subTitle'],
            style: TextStyle(color: Theme.of(context).hintColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 2, top: 2),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF121212),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      spacing: 6,
                      children: [
                        Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          contactTitle[1]['title'],
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          contactTitle[1]['subTitle'],
                          style: TextStyle(color: Colors.white60),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        // Contact Social Media
                        Column(
                          spacing: 15,
                          children: List.generate(
                            contactSocial.length,
                            (index) => Column(
                              spacing: 10,
                              children: [
                                Icon(
                                  contactSocial[index]['icon'],
                                  color: Colors.white,
                                ),
                                Text(
                                  contactSocial[index]['contact'],
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 58),
                        Row(
                          spacing: 24,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            socialMedia.length,
                            (index) => GestureDetector(
                              onTap: socialMedia[index]['onTap'],
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    socialMedia[index]['icon'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 230,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.lightTheme.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 320,
                left: 230,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.lightTheme.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 393,
                left: 278,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.lightTheme.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Column(children: [_buildTextFormFields(context)]),
        ],
      ),
    );
  }

  Widget _buildTextFormFields(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          spacing: 10,
          children: [
            _buildTextField(context, label: 'First name', isRequired: true),
            _buildTextField(context, label: 'Last name', isRequired: true),
            _buildTextField(context, label: 'Email', isRequired: true),
            _buildTextField(context, label: 'Phone', isRequired: true),
            _buildTextFieldComment(
              context,
              label: 'Write your message..',
              isRequired: true,
            ),
            SizedBox(height: 25),
            _buildSendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    TextEditingController? controller,
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

  Widget _buildTextFieldComment(
    BuildContext context, {
    required String label,
    TextEditingController? controller,
    bool isRequired = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLines = 1,
    double? width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Please enter $label';
              }
              return validator?.call(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              hintText: 'Enter $label',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            autocorrect: false,
          ),
        ),
        SizedBox(height: 14),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              //=========
            },
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(double.maxFinite, 52),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            child: Text(
              'Send',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80),
          child: Image.asset(
            'assets/images/letter_send 2.png',
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
