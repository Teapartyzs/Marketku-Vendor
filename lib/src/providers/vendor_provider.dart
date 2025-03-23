import 'package:marketku_vendor/src/models/vendor.dart';
import 'package:riverpod/riverpod.dart';

class VendorProvider extends StateNotifier<Vendor?> {
  VendorProvider()
      : super(
          Vendor(
              id: "",
              fullname: "",
              email: "",
              password: "",
              city: "",
              role: "",
              fullAddress: ""),
        );
  Vendor? get vendor => state;

  void setVendor(String json) {
    state = Vendor.fromJson(json);
  }

  void signOut() {
    state = null;
  }
}

final vendorProvider = StateNotifierProvider<VendorProvider, Vendor?>((ref) {
  return VendorProvider();
});
