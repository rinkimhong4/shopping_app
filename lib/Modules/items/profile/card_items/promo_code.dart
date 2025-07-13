import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/qr.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class PromoCodeItems extends StatelessWidget {
  const PromoCodeItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor:
                    innerBoxIsScrolled
                        ? Theme.of(context).cardColor
                        : Theme.of(context).appBarTheme.backgroundColor,
                title: Text(
                  'Promos Code',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                pinned: true,
                floating: true,
                snap: true,
                centerTitle: true,
                elevation: 0,
              ),
            ],
        body: SingleChildScrollView(
          child: Column(children: [promoCodeCard(context)]),
        ),
      ),
    );
  }

  Widget promoCodeCard(BuildContext context) {
    List<Map<String, dynamic>> ticketDatas = [
      {
        'logo': 'assets/images/Nike-Logo.png',
        'subTitle': 'Summer Sale',
        'discount': '35% OFF',
        'expires': 'Aug 31, 2025',
        'code': 'HW54GP',
        'description':
            'Enjoy 35% off on all summer apparel and accessories. Perfect for beach trips and summer adventures!',
      },
      {
        'logo': 'assets/images/adidas.png',
        'subTitle': 'Summer Sale',
        'discount': '35% OFF',
        'expires': 'Jul 19, 2025',
        'code': 'HW14GP',
        'description':
            'Get ready for summer with 35% off on select items. Limited time offer, shop now!',
      },
      {
        'logo': 'assets/images/puma.png',
        'subTitle': 'Mid Year Sale',
        'discount': '50% OFF',
        'expires': 'Aug 3, 2025',
        'code': 'HW59GO',
        'description':
            'Celebrate mid-year with up to 50% off on electronics and home goods. Don’t miss out!',
      },
      {
        'logo': 'assets/images/zara.png',
        'subTitle': 'Back to School',
        'discount': '20% OFF',
        'expires': 'Sep 15, 2025',
        'code': 'SCHOOL20',
        'description':
            'Gear up for school with 20% off on backpacks, stationery, and more.',
      },
      {
        'logo': 'assets/images/ZANDO.png',
        'subTitle': 'Fall Promo',
        'discount': '40% OFF',
        'expires': 'Oct 10, 2025',
        'code': 'FALL40',
        'description':
            'Embrace the fall season with 40% off on cozy sweaters and jackets.',
      },
      {
        'logo': 'assets/images/ten11.png',
        'subTitle': 'Holiday Special',
        'discount': '30% OFF',
        'expires': 'Dec 25, 2025',
        'code': 'HOLIDAY30',
        'description':
            'Spread holiday cheer with 30% off on gifts and festive decorations.',
      },
      {
        'logo': 'assets/images/CROCODILE.png',
        'subTitle': 'Flash Sale',
        'discount': '25% OFF',
        'expires': 'Jul 30, 2025',
        'code': 'FLASH25',
        'description':
            'Hurry! 25% off sitewide for a limited time during our flash sale.',
      },
      {
        'logo': 'assets/images/ten11.png',
        'subTitle': 'Clearance Sale',
        'discount': '60% OFF',
        'expires': 'Aug 20, 2025',
        'code': 'CLEAR60',
        'description':
            'Clearance alert! Save up to 60% on select items while stocks last.',
      },
      {
        'logo': 'assets/images/ten11.png',
        'subTitle': 'VIP Discount',
        'discount': '15% OFF',
        'expires': 'Sep 1, 2025',
        'code': 'VIP15',
        'description':
            'Exclusive 15% off for VIP members on all purchases. Join now!',
      },
      {
        'logo': 'assets/images/Nike-Logo.png',
        'subTitle': 'Weekend Deal',
        'discount': '45% OFF',
        'expires': 'Jul 27, 2025',
        'code': 'WEEKEND45',
        'description':
            'Make your weekend special with 45% off on select categories.',
      },
    ];
    return Column(
      spacing: 24,
      children: List.generate(
        ticketDatas.length,
        (index) => Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          PromoDetailsPage(promoData: ticketDatas[index]),
                ),
              );
            },
            child: ClipPath(
              clipper: TicketRoundedEdgeClipper(
                edge: Edge.horizontal,
                position: 110,
                radius: 25,
              ),
              child: SizedBox(
                width: 360,
                height: 165,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 14,
                                      ),
                                      child: Container(
                                        width: 72,
                                        height: 72,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  ticketDatas[index]['logo'],
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 30,
                                        top: 14,
                                      ),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // spacing: 5,
                                        children: [
                                          Text(
                                            ticketDatas[index]['subTitle'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                ticketDatas[index]['discount'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'EXPIRES',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ticketDatas[index]['expires'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 2,
                              children: List.generate(
                                12,
                                (index) => Container(
                                  width: 1.5,
                                  height: 3.3,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 150,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                  ),
                                  // color: Colors.amber,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      ticketDatas[index]['code'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.copy_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
