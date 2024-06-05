import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';
import 'package:zalada_flutter/shared/widgets/filled_button_custom.dart';
import 'package:zalada_flutter/shared/widgets/text_field_custom.dart';

class EditAddressPage extends StatelessWidget {
  const EditAddressPage({super.key});

  static const routePath = '/edit_address';

  @override
  Widget build(BuildContext context) {
    return EditAddressPages();
  }
}

class EditAddressPages extends StatefulWidget {
  const EditAddressPages({super.key});

  @override
  State<EditAddressPages> createState() => _EditAddressPagesState();
}

class _EditAddressPagesState extends State<EditAddressPages> {
  late TextEditingController nameLocationController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;

  final Completer<GoogleMapController> _controller = Completer();

  //default location current location
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.5564, 104.9282),
    zoom: 14.4746,
  );

  final LatLng initialPosition = LatLng(11.5564, 104.9282);
  double lat = 11.5564;
  double long = 104.9282;

  @override
  void initState() {
    super.initState();
    nameLocationController = TextEditingController();
    addressController = TextEditingController();
    phoneNumberController = TextEditingController();

    // Fetch address and update the address controller
    _updateAddress(lat, long);
  }

  @override
  void dispose() {
    nameLocationController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _updateAddress(double lat, double long) async {
    String? address = await getAddress(lat, long);
    setState(() {
      addressController.text = address ?? '';
    });
  }

  Future<String?> getAddress(double lat, double long) async {
    try {
      final placeMarks = await placemarkFromCoordinates(lat, long);
      final address = placeMarks[0];
      final street = '${address.thoroughfare}';
      final subLocality = '${address.subLocality}';
      final locality = '${address.locality}';
      final country = '${address.country}';
      return '$street, $subLocality, $locality, $country';
    } catch (e) {
      print('Error fetching address: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Select Address'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.md),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onCameraIdle: () {
                    _updateAddress(lat, long);
                  },
                  onCameraMove: (position) {
                    lat = position.target.latitude;
                    long = position.target.longitude;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                ),
                Icon(
                  Icons.location_on,
                  size: 40,
                  color: AppColors.kRedColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    TextFieldCustom(
                      label: 'Name Location',
                      controller: nameLocationController,
                    ),
                    SizedBox(height: AppSpacing.lg),
                    TextFieldCustom(
                      label: 'Address details',
                      controller: addressController,
                      maxLines: 3,
                    ),
                    SizedBox(height: AppSpacing.lg),
                    TextFieldCustom(
                      label: 'Phone number',
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                    ),
                    SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.xlg,
        ),
        child: FilledButtonCustom(
          onPressed: () {},
          text: 'Save',
        ),
      ),
    );
  }
}
