import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class PaidScreenItems extends StatefulWidget {
  const PaidScreenItems({super.key});

  @override
  State<PaidScreenItems> createState() => _PaidScreenItemsState();
}

class _PaidScreenItemsState extends State<PaidScreenItems> {
  List<Map<String, dynamic>> paidList = [
    {
      'icon': Icons.paid_outlined,
      'orderCode': 'Order #92287157',
      'date': '12/12/2022',
      'amount': 300,
      'onTap': () {
        // print('Payment tapped');
      },
    },
    {
      'icon': Icons.paid_outlined,
      'orderCode': 'Order #92287157',
      'date': '12/12/2022',
      'amount': 100,
      'onTap': () {
        // print('Payment tapped');
      },
    },
    {
      'icon': Icons.paid_outlined,
      'orderCode': 'Order #92287157',
      'date': '12/12/2022',
      'amount': 200.95,
      'onTap': () {
        // print('Payment tapped');
      },
    },
    {
      'icon': Icons.paid_outlined,
      'orderCode': 'Order #92287157',
      'date': '12/12/2022',
      'amount': 300,
      'onTap': () {
        // print('Payment tapped');
      },
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        'Paid Summary',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  _buildBody() {
    final amount = paidList.fold<double>(
      0,
      (prev, element) => prev + element['amount'],
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total Spent:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
          ..._buildPaidList(context),
        ],
      ),
    );
  }

  List<Widget> _buildPaidList(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            children: List.generate(
              paidList.length,
              (index) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: paidList[index]['onTap'],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            paidList[index]['icon'],
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paidList[index]['date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  paidList[index]['orderCode'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${(paidList[index]['amount']).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != paidList.length - 1)
                    Padding(
                      padding: EdgeInsets.zero,
                      child: _buildDottedDivider(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
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
