import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class PaymentMethodsItems extends StatelessWidget {
  PaymentMethodsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(appBar: _buildAppBar(context), body: _buildBody(context)),
    );
  }

  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Payment Methods',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: NeumorphicButton(
            child: Icon(Icons.add, color: Colors.black),
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              color: Color(0xFFE5E5EA),
              depth: 0,
              intensity: 0.50,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          _buildSummaryPaid(context),
          SizedBox(height: 20),
          _buildPaymentMethodsCard(context),
        ],
      ),
    );
  }

  Widget _buildSummaryPaid(BuildContext context) {
    final user = authController.currentUser;
    final username =
        profileController.username.value.isNotEmpty
            ? profileController.username.value
            : (user?.email?.split('@')[0] ?? 'Guest');
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.none,
          width: double.infinity,
          height: 120,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              depth: 2,
              intensity: 0.75,
              shadowLightColor: Theme.of(context).cardColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              border: NeumorphicBorder(color: Theme.of(context).cardColor),
              color: Theme.of(context).cardColor,
            ),

            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      Icon(Icons.wallet, size: 24),
                      Text(
                        username[0].toUpperCase() + username.substring(1),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              width: 1,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24, top: 24),
              child: Column(
                spacing: 10,
                children: [
                  Text('Paid', style: TextStyle(fontSize: 18)),
                  Text(
                    '\$100,000.00',
                    style: TextStyle(color: AppColors.primary, fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsCard(BuildContext context) {
    List<Map<String, dynamic>> paymentMethods = [
      {'image': AppAssets.visa, 'name': 'Visa'},
      {'image': AppAssets.masterCard, 'name': 'Mastercard'},
      {'image': AppAssets.americanExpress, 'name': 'American Express'},
      {'image': AppAssets.paypal, 'name': 'PayPal'},
      {'image': AppAssets.applePay, 'name': 'Apple Pay'},
    ];
    return Column(
      spacing: 10,
      children: List.generate(
        paymentMethods.length,
        (index) => Column(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 1,
                intensity: 0.79,
                surfaceIntensity: 0.3,
                shadowLightColor: Theme.of(context).cardColor,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
                border: NeumorphicBorder(color: Theme.of(context).cardColor),
                color: Theme.of(context).cardColor,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 88,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  leading: SvgPicture.asset(
                    paymentMethods[index]['image'],
                    height: 44,
                    width: 44,
                  ),
                  title: Text(paymentMethods[index]['name']),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
