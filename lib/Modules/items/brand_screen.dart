import 'package:flutter/material.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // showCustomBottomSheet(context); // Open FilterBottomSheet
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildFeaturedBrand(context), // Use imported function
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'All Brands',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildBrandGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandGrid(BuildContext context) {
    List<Map<String, dynamic>> allBrands = [
      {'name': 'Nike', 'logo': 'assets/images/Nike-Logo.png'},
      {'name': 'Adidas', 'logo': 'assets/images/adidas.png'},
      {'name': 'Puma', 'logo': 'assets/images/puma.png'},
      {'name': 'Zara', 'logo': 'assets/images/zara.png'},
      {'name': 'Zendo', 'logo': 'assets/images/ZANDO.png'},
      {'name': 'Ten11', 'logo': 'assets/images/ten11.png'},
      {'name': 'Crocodile', 'logo': 'assets/images/CROCODILE.png'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: allBrands.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('Tapped on ${allBrands[index]['name']}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BrandDetailsPage(
                      brand: allBrands[index]['name'],
                      logo: allBrands[index]['logo'],
                    ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    allBrands[index]['logo'],
                    fit: BoxFit.contain,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                allBrands[index]['name'],
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==========================

class BrandDetailsPage extends StatelessWidget {
  final String brand;
  final String logo;

  const BrandDetailsPage({super.key, required this.brand, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brand, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Stack(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(logo),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
