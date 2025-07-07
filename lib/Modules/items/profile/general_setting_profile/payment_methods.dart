import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaymentMethodsItems extends StatelessWidget {
  PaymentMethodsItems({super.key});

  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

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
        'Payment Methods',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 24),
          child: IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Navigate to add payment method screen
              // Get.toNamed(AppRoute.addPaymentMethod); // Replace with your route
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        _buildSummaryPaid(context),
        SizedBox(height: 20),
        Expanded(child: _buildPaymentMethodsSection(context)),
      ],
    );
  }

  Widget _buildSummaryPaid(BuildContext context) {
    final user = authController.currentUser;
    final username =
        profileController.username.value.isNotEmpty
            ? profileController.username.value
            : (user?.email?.split('@')[0] ?? 'Guest');

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.paidScreen),
      child: Container(
        width: double.infinity,
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet,
                    size: 24,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(height: 10),
                  Text(
                    username[0].toUpperCase() + username.substring(1),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 24,
              top: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Paid',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$10,000.00',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 1,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Your Cards',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: 200, child: _buildCreditCard()),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),
              tabs: [
                Tab(text: 'Today'),
                Tab(text: 'Yesterday'),
                Tab(text: 'This Week'),
                Tab(text: 'This Month'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTabContent(context, 0),
                _buildTabContent(context, 1),
                _buildTabContent(context, 2),
                _buildTabContent(context, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, int index) {
    final List<String> tabTitles = [
      'Today',
      'Yesterday',
      'This Week',
      'This Month',
    ];

    final List<Map<String, dynamic>> transactions = [
      {
        'id': 'TXN001',
        'date': '2025-07-06',
        'amount': 50.00,
        'description': 'Grocery Purchase',
        'category': 'Today',
      },
      {
        'id': 'TXN001',
        'date': '2025-07-06',
        'amount': 50.00,
        'description': 'Grocery Purchase',
        'category': 'Today',
      },
      {
        'id': 'TXN001',
        'date': '2025-07-06',
        'amount': 50.00,
        'description': 'Grocery Purchase',
        'category': 'Today',
      },
      {
        'id': 'TXN001',
        'date': '2025-07-06',
        'amount': 50.00,
        'description': 'Grocery Purchase',
        'category': 'Today',
      },
      {
        'id': 'TXN002',
        'date': '2025-07-06',
        'amount': 120.00,
        'description': 'Online Subscription',
        'category': 'Today',
      },
      {
        'id': 'TXN003',
        'date': '2025-07-05',
        'amount': 30.00,
        'description': 'Coffee Shop',
        'category': 'Yesterday',
      },
      {
        'id': 'TXN004',
        'date': '2025-07-05',
        'amount': 200.00,
        'description': 'Electronics',
        'category': 'Yesterday',
      },
      {
        'id': 'TXN005',
        'date': '2025-07-03',
        'amount': 75.00,
        'description': 'Restaurant',
        'category': 'This Week',
      },
      {
        'id': 'TXN006',
        'date': '2025-07-01',
        'amount': 150.00,
        'description': 'Clothing',
        'category': 'This Month',
      },
    ];

    // Filter transactions based on the tab index
    final filteredTransactions =
        transactions.where((txn) {
          switch (index) {
            case 0:
              return txn['category'] == 'Today';
            case 1:
              return txn['category'] == 'Yesterday';
            case 2:
              return txn['category'] == 'This Week';
            case 3:
              return txn['category'] == 'This Month';
            default:
              return false;
          }
        }).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child:
          filteredTransactions.isEmpty
              ? Center(
                child: Text(
                  'No transactions for ${tabTitles[index]}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
              )
              : ListView.separated(
                itemCount: filteredTransactions.length,
                separatorBuilder: (context, index) => _buildDottedDivider(),
                itemBuilder: (context, idx) {
                  final transaction = filteredTransactions[idx];
                  return ListTile(
                    leading: Icon(
                      Icons.payment,
                      color: Theme.of(context).iconTheme.color,
                      size: 24,
                      semanticLabel: 'Transaction',
                    ),
                    title: Text(
                      transaction['description'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Date: ${transaction['date']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      '\$${transaction['amount'].toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Transaction Details',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Date: ${transaction['date']}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Amount: \$${transaction['amount'].toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Description: ${transaction['description']}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }

  Widget _buildCreditCard() {
    List<Map<String, dynamic>> cardDetails = [
      {
        'bankName': 'MasterCard',
        'cardNumber': '1234 5678 9012 3456',
        'expiryDate': '12/25',
        'cardHolderName': 'Kimhong',
        'cvvCode': '1234',
      },
      {
        'bankName': 'Visa',
        'cardNumber': '1234 5678 9012 3456',
        'expiryDate': '12/25',
        'cardHolderName': 'Kim',
        'cvvCode': '1234',
      },
      {
        'bankName': 'Discover',
        'cardNumber': '1234 5678 9012 3456',
        'expiryDate': '12/25',
        'cardHolderName': 'Hong',
        'cvvCode': '1234',
      },
      {
        'bankName': 'Amex',
        'cardNumber': '1234 5678 9012 3456',
        'expiryDate': '12/25',
        'cardHolderName': 'Neath',
        'cvvCode': '1234',
      },
    ];
    return SingleChildScrollView(
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          cardDetails.length,
          (index) => CreditCardWidget(
            height: 180,
            width: 300,
            cardNumber: cardDetails[index]['cardNumber'],
            expiryDate: cardDetails[index]['expiryDate'],
            cardHolderName: cardDetails[index]['cardHolderName'],
            cvvCode: '1234',
            obscureCardCvv: false,
            backgroundNetworkImage:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3TcJm7Gr6DKnTU6Yo37qImUJi3ZRaQ1wZ8BKW5PDzYum7rEqPIUgGYZvUyYsvOZ3ix5o&usqp=CAU',
            cardBgColor: Colors.black45,
            bankName: cardDetails[index]['bankName'],
            cardType: CardType.mastercard,
            obscureCardNumber: true,
            showBackView: false,
            isChipVisible: true,
            isHolderNameVisible: true,
            floatingConfig: FloatingConfig(
              isGlareEnabled: true,
              isShadowEnabled: true,
              shadowConfig: FloatingShadowConfig(),
            ),
            obscureInitialCardNumber: true,
            onCreditCardWidgetChange: (CreditCardBrand) {},
          ),
        ),
      ),
    );
  }

  Widget _buildDottedDivider() {
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 2.0;
          const dashSpace = 3.0;
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(dashCount, (index) {
              return Container(
                width: dashWidth,
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: dashSpace / 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// ==============================================================================
class CreditCardItem extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String backgroundNetworkImage;
  final String bankName;
  final CardType cardType;
  final double width;
  final double height;

  const CreditCardItem({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.backgroundNetworkImage,
    required this.bankName,
    required this.cardType,
    this.width = 300,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      height: height,
      width: width,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      obscureCardCvv: true,
      backgroundNetworkImage: backgroundNetworkImage,
      cardBgColor: Colors.black45,
      bankName: bankName,
      cardType: cardType,
      obscureCardNumber: true,
      showBackView: false,
      isChipVisible: true,
      isHolderNameVisible: true,
      floatingConfig: FloatingConfig(
        isGlareEnabled: true,
        isShadowEnabled: true,
      ),
      obscureInitialCardNumber: true,
      onCreditCardWidgetChange: (brand) {},
    );
  }
}
