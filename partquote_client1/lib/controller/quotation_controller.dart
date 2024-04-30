import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:partquote_client/Screens/user_service.dart';
import 'package:partquote_client/model/cartmodel.dart';
import 'package:partquote_client/model/detailsmodel.dart';

class QuotationController extends GetxController {
  @override
  void onInit() {
    fetchMyquotations();
    super.onInit();
  }

  RxList<QuotationItem> quotation = RxList.empty();

  void addQuotation(QuotationItem quotationItem) {
    CollectionReference quotationCollection =
        FirebaseFirestore.instance.collection('quotations');

    quotationCollection
        .add(quotationItem.toJson())
        .then((value) => {Get.snackbar("Added", "Quotatioon")})
        .catchError((err) => Get.snackbar("Error", '$err'));
  }

  void fetchMyquotations() async {
    CollectionReference quotationCollection =
        FirebaseFirestore.instance.collection('quotations');
    quotation.clear();
    List<QuotationItem> quotations = [];
    QuerySnapshot querySnapshot = await quotationCollection
        .where('quotationBy', isEqualTo: UserService.getUser()!.name)
        .get();

    querySnapshot.docs.forEach((doc) {
      quotations
          .add(QuotationItem.fromJson(doc.data() as Map<String, dynamic>));
    });

    quotation.addAll(quotations);
  }

  double findTotal(List<ShoppingItem> items) {
    double total = 0;
    items.forEach((element) {
      total = total + element.price;
    });
    return total;
  }
}
