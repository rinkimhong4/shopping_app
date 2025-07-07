import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Modules/Home/Views/open_street_map.dart';

class MyAddressItems extends StatefulWidget {
  const MyAddressItems({super.key});

  @override
  State<MyAddressItems> createState() => _MyAddressItemsState();
}

class _MyAddressItemsState extends State<MyAddressItems> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  List<Address> _addresses = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
      });
    });
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? addressList = prefs.getStringList('saved_addresses');
    if (addressList != null) {
      setState(() {
        _addresses =
            addressList
                .map((json) => Address.fromJson(jsonDecode(json)))
                .toList();
      });
    }
  }

  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> addressList =
        _addresses.map((addr) => jsonEncode(addr.toJson())).toList();
    await prefs.setStringList('saved_addresses', addressList);
  }

  void _addAddress(Address address) {
    setState(() {
      _addresses.add(address);
    });
    _saveAddresses();
  }

  void _removeAddress(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
    _saveAddresses();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [_buildAppBar(context), _buildAddressList(context)],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      elevation: 0,
      pinned: true,
      title: Text(
        'My Address',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
      backgroundColor:
          _isScrolled
              ? Colors.blue
              : Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
      floating: true,
      snap: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 24),
          child: IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Get.bottomSheet(
                _buildAddAddressBottomSheet(context),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // In MyAddressItems class
  Widget _buildAddAddressBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: Get.height * 0.945,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ShowMapScreen(
        onLocationConfirmed: (location, address) {
          _addAddressDirectly(location, address);
        },
      ),
    );
  }

  void _addAddressDirectly(LatLng location, String address) {
    // Generate a default name based on address
    final defaultName = address.split(',').take(2).join(',');

    _addAddress(
      Address(
        name: defaultName,
        address: address,
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );

    Get.snackbar(
      "Address Saved",
      "$defaultName has been saved",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Widget _buildAddressList(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final address = _addresses[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.location_on_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                address.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Lat: ${address.latitude.toStringAsFixed(6)}, Lng: ${address.longitude.toStringAsFixed(6)}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => _removeAddress(index),
                  ),
                ],
              ),
            ),
            if (index < _addresses.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildDottedDivider(),
              ),
          ],
        );
      }, childCount: _addresses.length),
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

class Address {
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Address({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: json['name'],
    address: json['address'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );
}
