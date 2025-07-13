import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class QrCodeWidget extends StatelessWidget {
  final String promoCode;

  const QrCodeWidget({super.key, required this.promoCode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: promoCode,
        eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
        version: QrVersions.auto,
        size: 200.0,
        gapless: false,
        backgroundColor: Colors.white,
      ),
    );
  }
}

// ===================
/// Builds a widget that displays the details of a promotion in a card-like layout.
class PromoDetailsPage extends StatelessWidget {
  final Map<String, dynamic> promoData;

  const PromoDetailsPage({super.key, required this.promoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(promoData['subTitle'])),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Center(child: _buildPromoDetails()),
      ),
    );
  }

  Widget _buildPromoDetails() {
    return ClipPath(
      clipper: TicketRoundedEdgeClipper(
        edge: Edge.horizontal,
        position: 368,
        radius: 25,
      ),
      child: SizedBox(
        width: 340,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 30),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: AssetImage(promoData['logo']),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    promoData['subTitle'],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    promoData['discount'],
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    promoData['code'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decorationThickness: 1.5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      promoData['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      33,
                      (index) => Container(
                        height: 1.3,
                        width: 6,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  QrCodeWidget(promoCode: promoData['code']),
                  SizedBox(height: 24),
                  Row(
                    spacing: 34,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // expires
                      Icon(Icons.ios_share_outlined, color: Colors.white),
                      Text(
                        promoData['expires'],
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Icon(Icons.info_outline_rounded, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
