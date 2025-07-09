import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/widgets/app_footer.dart';

class TermConditionItems extends GetView<ProfileController> {
  const TermConditionItems({super.key});

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
                    'Terms & Conditions',
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
          body: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final terms = controller.hypeWearMetaData.value.termsAndConditions;
      if (terms == null) {
        return const Center(child: Text('No terms and conditions available'));
      }

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: _buildSectionTitle(
                      terms.title ?? 'Terms & Conditions',
                    ),
                  );
                }
                final section = terms.sections?[index - 1];
                if (section == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionSubtitle(section.title ?? ''),
                      SizedBox(height: 10),
                      _buildSectionContent(section.content ?? ''),
                    ],
                  ),
                );
              }, childCount: (terms.sections?.length ?? 0) + 1),
            ),
          ),
          SliverToBoxAdapter(child: FooterApp()),
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

  Widget _buildSectionSubtitle(String text) {
    return Text(
      text,
      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionContent(String text) {
    return Text(text, style: Get.textTheme.bodyMedium?.copyWith(height: 1.5));
  }
}
