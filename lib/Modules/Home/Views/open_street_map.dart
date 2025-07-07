import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

//  not already at all
class ShowMapScreen extends StatefulWidget {
  final Function(LatLng, String)? onLocationConfirmed;

  const ShowMapScreen({super.key, this.onLocationConfirmed});

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  static const _fallbackLocation = LatLng(11.56492, 104.86538);
  static const _initialZoom = 16.0;
  static const _maxZoom = 19.0;
  static const _minZoom = 3.0;
  static const _routeColor = Colors.blue;
  static const _routeStrokeWidth = 4.0;
  static const _osrmBaseUrl =
      'https://router.project-osrm.org/route/v1/driving';
  static const _nominatimBaseUrl = 'https://nominatim.openstreetmap.org/search';
  static const _reverseGeocodeUrl =
      'https://nominatim.openstreetmap.org/reverse';

  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  LatLng? _currentPosition;
  LatLng? _destination;
  List<LatLng> _routePoints = [];
  bool _isLoading = true;
  bool _isMapReady = false;
  bool _followUserLocation = true;
  String _currentAddress = 'Loading address...';
  StreamSubscription<LocationData>? _locationSubscription;
  Location _locationService = Location();

  @override
  void initState() {
    _initializeLocationServices();
    super.initState();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeLocationServices() async {
    try {
      final locationData = await _locationService.getLocation().timeout(
        const Duration(seconds: 2),
      );
      if (!mounted) return;

      if (locationData.latitude == null || locationData.longitude == null) {
        throw 'Invalid location data';
      }
      setState(() {
        _currentPosition = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        if (_isMapReady) _centerMap(_currentPosition!);
      });

      // Get address for current location
      _reverseGeocode(_currentPosition!);
      await _configureLocationSettings();
      await _requestLocationPermissions();
      await _getCurrentLocation();
      _setupLocationUpdates();
    } catch (e) {
      _handleLocationError(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _configureLocationSettings() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
      distanceFilter: 5,
    );
  }

  Future<void> _requestLocationPermissions() async {
    if (!await _locationService.serviceEnabled()) {
      if (!await _locationService.requestService()) {
        throw 'Location services disabled';
      }
    }

    final permission = await _locationService.hasPermission();
    if (permission == PermissionStatus.denied) {
      if (await _locationService.requestPermission() !=
          PermissionStatus.granted) {
        throw 'Location permission denied';
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _locationService.getLocation().timeout(
        const Duration(seconds: 10),
      );

      if (locationData.latitude == null || locationData.longitude == null) {
        throw 'Invalid location data';
      }

      setState(() {
        _currentPosition = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        if (_isMapReady) _centerMap(_currentPosition!);
      });

      // Get address for current location
      _reverseGeocode(_currentPosition!);
    } catch (e) {
      throw 'Failed to get location: ${e.toString()}';
    }
  }

  void _setupLocationUpdates() {
    _locationSubscription = _locationService.onLocationChanged.listen((
      locationData,
    ) {
      if (locationData.latitude == null || locationData.longitude == null)
        return;

      setState(() {
        _currentPosition = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        if (_followUserLocation && _isMapReady) {
          _centerMap(_currentPosition!);
        }
      });
    });
  }

  void _centerMap(LatLng position, [double zoom = _initialZoom]) {
    _mapController.move(position, zoom);
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      _showError('Please enter a location');
      return;
    }

    setState(() {
      _isLoading = true;
      _followUserLocation = false;
    });

    try {
      final uri = Uri.parse(
        '$_nominatimBaseUrl?q=${Uri.encodeComponent(query)}&format=json&limit=1',
      );
      if (!mounted) return;

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'DeliveryApp/1.0'},
      );

      if (response.statusCode != 200) {
        throw 'API error: ${response.statusCode}';
      }

      final data = json.decode(response.body) as List;
      if (data.isEmpty) {
        throw 'Location not found';
      }

      final lat = double.tryParse(data[0]['lat'] ?? '');
      final lon = double.tryParse(data[0]['lon'] ?? '');
      final displayName =
          data[0]['display_name'] as String? ?? 'Unknown location';

      if (lat == null || lon == null) {
        throw 'Invalid coordinates';
      }

      setState(() {
        _destination = LatLng(lat, lon);
        _currentAddress = displayName;
        if (_isMapReady && _destination != null) {
          _centerMap(_destination!);
        }
      });

      await _fetchRoute();
    } catch (e) {
      if (!mounted) return;
      _showError('Search failed: ${e.toString()}');
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchRoute() async {
    if (_currentPosition == null || _destination == null) {
      _showError('Missing location data');
      return;
    }
    setState(() => _isLoading = true);

    try {
      final uri = Uri.parse(
        '$_osrmBaseUrl/'
        '${_currentPosition!.latitude},${_currentPosition!.longitude};'
        '${_destination!.latitude},${_destination!.longitude}'
        '?overview=full&geometries=polyline',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw 'Route API error: ${response.statusCode}';
      }

      final data = json.decode(response.body);
      final routes = data['routes'] as List?;

      if (routes == null || routes.isEmpty) {
        throw 'No route found';
      }

      _decodePolyline(routes.first['geometry'] as String);
    } catch (e) {
      _showError('Routing failed: ${toString()}');
      _showError('Routing failed: ${e.toString()}');
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _decodePolyline(String encoded) {
    try {
      final points = PolylinePoints().decodePolyline(encoded);
      setState(() {
        _routePoints =
            points.map((p) => LatLng(p.latitude, p.longitude)).toList();
        if (!mounted) return;
      });
    } catch (e) {
      if (!mounted) return;
      _showError('Route decoding failed');
    }
  }

  Future<void> _reverseGeocode(LatLng position) async {
    try {
      final uri = Uri.parse(
        '$_reverseGeocodeUrl?format=json&lat=${position.latitude}&lon=${position.longitude}',
      );

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'DeliveryApp/1.0'},
      );

      if (response.statusCode != 200) {
        throw 'Reverse geocode error: ${response.statusCode}';
      }
      if (!mounted) return;

      if (response.statusCode != 200) {
        throw 'Reverse geocode error: ${response.statusCode}';
      }

      final data = json.decode(response.body);
      final address = data['display_name'] as String? ?? 'Unknown location';

      setState(() {
        _currentAddress = address;
      });
    } catch (e) {
      setState(() {
        if (!mounted) return;

        _currentAddress = 'Failed to get address';
      });
    }
  }

  void _resetMap() {
    setState(() {
      _destination = null;
      _routePoints = [];
      _searchController.clear();
      _followUserLocation = true;
    });
    if (_currentPosition != null) {
      _centerMap(_currentPosition!);
      _reverseGeocode(_currentPosition!);
    }
  }

  void _handleLocationError(dynamic error) {
    setState(() {
      _currentPosition = _fallbackLocation;
    });
    // _showError('Using fallback location: ${error.toString()}');
    _reverseGeocode(_fallbackLocation);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Delivery Location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          _buildMap(),
          _buildSearchBar(),
          if (_isLoading) _buildLoader(),
          if (widget.onLocationConfirmed != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed:
                    _currentPosition != null
                        ? () {
                          // Pass location data to callback
                          widget.onLocationConfirmed!(
                            _destination ?? _currentPosition!,
                            _currentAddress,
                          );

                          // Close the map screen
                          Navigator.pop(context);
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add address details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 160,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _currentAddress,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildMapControls(),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentPosition ?? _fallbackLocation,
        initialZoom: _initialZoom,
        minZoom: _minZoom,
        maxZoom: _maxZoom,
        onMapReady: () {
          setState(() => _isMapReady = true);
          if (_currentPosition != null) {
            _centerMap(_currentPosition!);
          }
        },
        onPositionChanged: (_, hasGesture) {
          if (hasGesture) setState(() => _followUserLocation = false);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.deliveryapp',
        ),
        if (_currentPosition != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _currentPosition!,
                width: 50,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.delivery_dining, color: Colors.white),
                ),
              ),
            ],
          ),
        if (_destination != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _destination!,
                width: 60,
                height: 60,
                child: Column(
                  children: [
                    const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Delivery Point',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (_routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                color: _routeColor,
                strokeWidth: _routeStrokeWidth,
                borderColor: Colors.white,
                borderStrokeWidth: 2,
              ),
            ],
          ),
        CurrentLocationLayer(
          style: LocationMarkerStyle(
            marker: DefaultLocationMarker(color: Colors.blue),
            markerSize: const Size(40, 40),
            markerDirection: MarkerDirection.heading,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(30),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter delivery address...',
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                onSubmitted: _searchLocation,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.blue),
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchLocation(_searchController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.black26,
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildMapControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'reset',
          mini: true,
          tooltip: 'Clear route',
          backgroundColor: Colors.white,
          child: const Icon(Icons.clear, color: Colors.red),
          onPressed: _resetMap,
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'follow',
          mini: true,
          tooltip:
              _followUserLocation ? 'Following location' : 'Follow location',
          backgroundColor: _followUserLocation ? Colors.blue : Colors.white,
          child: Icon(
            _followUserLocation ? Icons.gps_fixed : Icons.gps_off,
            color: _followUserLocation ? Colors.white : Colors.blue,
          ),
          onPressed:
              () => setState(() => _followUserLocation = !_followUserLocation),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'location',
          tooltip: 'Center on my location',
          backgroundColor: Colors.blue,
          child: const Icon(Icons.my_location, color: Colors.white),
          onPressed: () {
            if (_currentPosition != null) {
              _centerMap(_currentPosition!, 17);
              setState(() => _followUserLocation = true);
            }
          },
        ),
      ],
    );
  }
}
