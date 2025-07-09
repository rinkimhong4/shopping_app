import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:shopping_app/widgets/app_footer.dart';

class CustomerSupportItems extends GetView<ProfileController> {
  const CustomerSupportItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  title: Text(
                    'Customer Support',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  pinned: true,
                  snap: true,
                  centerTitle: true,
                  elevation: 0,
                  floating: true,
                ),
              ],
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final support = controller.hypeWearMetaData.value.customerSupport;
      if (support == null) {
        return const Center(
          child: Text('No customer support information available'),
        );
      }

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle(support.title ?? 'Customer Support'),
                const SizedBox(height: 16),
                if (support.introduction != null)
                  _buildSectionContent(support.introduction!),
              ]),
            ),
          ),

          // Contact Methods Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _buildSubtitle('Contact Methods'),
                SizedBox(height: 10),
                _buildContactMethod(
                  AppAssets.email,
                  'Email',
                  support.contactMethods?.email ?? 'Not available',
                  context,
                ),
                _buildContactMethod(
                  AppAssets.contact,
                  'Phone',
                  support.contactMethods?.phone ?? 'Not available',
                  context,
                ),
                _buildContactMethod(
                  AppAssets.chatCircle,
                  'Live Chat',
                  support.contactMethods?.liveChat ?? 'Not available',
                  context,
                ),
              ]),
            ),
          ),

          // Support Topics Section
          if (support.supportTopics != null &&
              support.supportTopics!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),
                  _buildSubtitle('Support Topics'),
                  const SizedBox(height: 8),
                  ...support.supportTopics!
                      .map((topic) => _buildSupportTopic(topic, context))
                      .toList(),
                ]),
              ),
            ),

          // Response Time Section
          if (support.responseTime != null)
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSectionContent(support.responseTime!),
                  SizedBox(height: 50),
                  FooterApp(),
                ]),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      style: Get.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(Get.context!).iconTheme.color,
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Text(text, style: Get.textTheme.bodyMedium?.copyWith(height: 1.5));
  }

  Widget _buildContactMethod(
    String assetPath,
    String label,
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
                SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTopic(String topic, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssets.info,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),

          SizedBox(width: 10),
          Expanded(child: Text(topic, style: Get.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
