// ignore_for_file: prefer_const_constructors, use_rethrow_when_possible, prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/loaded_widget.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/models/get_checklist_model.dart';
import 'package:pick_a_service/features/home/models/get_tons_model.dart';
import 'package:pick_a_service/features/home/models/invoice_model.dart';
import 'package:pick_a_service/features/home/models/invoice_price_model.dart';
import 'package:pick_a_service/features/home/models/tons_model.dart';
import 'package:pick_a_service/route/custom_navigator.dart';

class HomeProvider extends ChangeNotifier {
  List<AcceptedOrdersModel> _acceptedTodayOrdersList = [];
  List<AcceptedOrdersModel> _acceptedTomorrowOrdersList = [];
  List<AcceptedOrdersModel> _acceptedThisWeekOrdersList = [];

  bool _isOrdersLoading = false;
  List<AcceptedOrdersModel> get acceptedTodayOrdersList =>
      _acceptedTodayOrdersList;
  List<AcceptedOrdersModel> get acceptedTomorrowOrdersList =>
      _acceptedTomorrowOrdersList;

  List<AcceptedOrdersModel> get acceptedThisWeekOrdersList =>
      _acceptedThisWeekOrdersList;

  bool get isOrdersLoading => _isOrdersLoading;
  DateTime today = DateTime.now();

  Future<void> getacceptedOrders() async {
    _acceptedTodayOrdersList.clear();
    _acceptedThisWeekOrdersList.clear();
    _acceptedTomorrowOrdersList.clear();
    _isOrdersLoading = true;
    notifyListeners();
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");
    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "technicianId": techId,
      };
      http.Response response = await http.post(Uri.parse(GETACCEPTEDORDERS),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        for (var i in data["result"]) {
          AcceptedOrdersModel model = AcceptedOrdersModel.fromJson(i);

          if (model.day == "today") {
            _acceptedTodayOrdersList.add(model);
          } else if (model.day == "tommorrow") {
            _acceptedTomorrowOrdersList.add(model);
          } else if (model.day == "this week") {
            _acceptedThisWeekOrdersList.add(model);
          }
        }

        _isOrdersLoading = false;
        notifyListeners();
      } else {
        _isOrdersLoading = false;
        notifyListeners();
        _acceptedThisWeekOrdersList = [];
        _acceptedTodayOrdersList = [];

        _acceptedTomorrowOrdersList = [];

        // OverlayManager.showToast(type: ToastType.Error, msg: data["message"]);
        // throw data["message"];
      }
    } catch (e) {
      _acceptedThisWeekOrdersList = [];
      _acceptedTodayOrdersList = [];

      _acceptedTomorrowOrdersList = [];
      _isOrdersLoading = false;
      notifyListeners();
      // OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      throw e;
    }
  }

  //CHECKLIST AND INVOICE

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<GetTonsModel> _getTonsList = [];
  List<GetTonsModel> get getTonsList => _getTonsList;

  List<TonsModel> _getModelList = [];
  List<TonsModel> get getModelList => _getModelList;

  Future<void> getTons(int categoryId, int subCategoryId) async {
    _isLoading = true;

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    print(categoryId);
    print(subCategoryId);
    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "categoryId": categoryId,
        "subCategoryId": subCategoryId
      };
      http.Response response = await http.post(Uri.parse(GETTONS),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      print("Get Checklist");
      List<GetTonsModel> list = [];
      if (response.statusCode == 200) {
        print("Success");
        for (var i in data["result"]) {
          GetTonsModel _model = GetTonsModel.fromJson(i);
          list.add(_model);
        }

        _getTonsList = list;
        print(_getTonsList);
        _isLoading = false;

        notifyListeners();
      } else {
        print("else");
        _getTonsList = [];
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _getTonsList = [];
      _isLoading = false;
      notifyListeners();
      print(e);

      throw e;
    }
  }

  Future<void> getTonsModel(int subCategoryId) async {
    _isLoading = true;

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {"subSubCatId": subCategoryId};
      http.Response response = await http.post(Uri.parse(GETTONSMODEL),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      List<TonsModel> list = [];
      if (response.statusCode == 200) {
        for (var i in data["result"]) {
          TonsModel _model = TonsModel.fromJson(i);
          list.add(_model);
        }

        _getModelList = list;
        _isLoading = false;

        notifyListeners();
      } else {
        _getModelList = [];
        _isLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _getModelList = [];
      _isLoading = false;
      notifyListeners();
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  //================== CREATE CHECKLIST ============================

  bool _isSaving = false;

  bool get isSaving => _isSaving;

  Future<void> createChecklist(int ticketId, int userId, int subcategoryId,
      int modelID, BuildContext context, String image) async {
    int techId = SharedPreferencesManager.getInt("user_id");
    _isSaving = true;

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'token': jwt_token};
      var request = http.MultipartRequest('POST', Uri.parse(CREATECHECKLIST));
      request.fields.addAll({
        'ticketId': ticketId.toString(),
        'userId': userId.toString(),
        'technicianId': techId.toString(),
        'subCategoryId': subcategoryId.toString(),
        'subCategoryModelId': modelID.toString()
      });
      request.files
          .add(await http.MultipartFile.fromPath('checklistImg', image));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print("before 200");
      if (response.statusCode == 200) {
        print("200");
        // print(await response.stream.bytesToString());
        _isSaving = false;
        notifyListeners();
        CustomNavigator.pop(context);
      } else {
        _isSaving = false;
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      _getModelList = [];
      _isSaving = false;
      notifyListeners();
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  // ===============INVOICE =========================
  bool _isInvoiceLoading = false;
  bool get isInvoiceLoading => _isInvoiceLoading;

  List<InvoiceModel> _getInvoiceList = [];
  List<InvoiceModel> get getInvoiceList => _getInvoiceList;

  Future<void> getInvoice(int subCategoryId, int ticketId) async {
    _isInvoiceLoading = true;
    print(subCategoryId);
    print(ticketId);

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "subCategoryModelId": subCategoryId,
        "ticketId": ticketId
      };
      http.Response response = await http.post(Uri.parse(GETINVOICELIST),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      List<InvoiceModel> list = [];
      if (response.statusCode == 200) {
        print("Success");
        for (var i in data["result"]) {
          InvoiceModel _model = InvoiceModel.fromJson(i);
          list.add(_model);
        }
        print("after");

        _getInvoiceList = list;
        print(_getInvoiceList);
        _isInvoiceLoading = false;

        notifyListeners();
      } else {
        print("else");
        _getInvoiceList = [];
        _isInvoiceLoading = false;
        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _getInvoiceList = [];
      _isInvoiceLoading = false;
      notifyListeners();
      print(e);
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  //=====================SEARCH INVOICE ITEMS ===================================
  List<InvoicePriceListModel> _getFilteredInvoiceList = [];
  List<InvoicePriceListModel> get getFilteredInvoiceList =>
      _getFilteredInvoiceList;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  Future<void> getFilteredInvoice(String s, int ticketId) async {
    _isSearching = true;
    notifyListeners();
    print("hello");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {"searchInput": s, "ticketId": ticketId};
      http.Response response = await http.post(Uri.parse(SEARCHINVOICEPRICE),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      List<InvoicePriceListModel> list = [];
      if (response.statusCode == 200) {
        print("Success");
        for (var i in data["result"]) {
          InvoicePriceListModel _model = InvoicePriceListModel.fromJson(i);
          list.add(_model);
        }

        _getFilteredInvoiceList = list;
        _isSearching = false;

        notifyListeners();
      } else {
        print("else");
        _getFilteredInvoiceList = [];
        _isSearching = false;
        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _getFilteredInvoiceList = [];
      _isSearching = false;

      notifyListeners();
      print(e);
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  bool _isGeneratingInvoice = false;
  bool get isGeneratingInvoice => _isGeneratingInvoice;
  //========================= CREATE INVOICE ========================
  Future<void> createInvoice(int customerID, int ticketId,
      List<Map<String, dynamic>> invoice_items, BuildContext context) async {
    _isGeneratingInvoice = true;

    notifyListeners();

    List<Map<String, dynamic>> d = [];
    for (var i in invoice_items) {
      Map<String, dynamic> mp = {
        "priceId": i["priceID"],
      };

      d.add(mp);
    }
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      print(d);
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "customerId": customerID,
        "ticketId": ticketId,
        "invoiceItems": d.toList()
      };
      http.Response response = await http.post(Uri.parse(CREATEINVOICE),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Success");
        // for (var i in data["result"]) {
        //   InvoiceModel _model = InvoiceModel.fromJson(i);
        //   list.add(_model);
        // }

        _isGeneratingInvoice = false;

        notifyListeners();
        CustomNavigator.pop(context);
      } else {
        print("else");

        _isGeneratingInvoice = false;
        notifyListeners();
        // OverlayManager.showToast(
        //     type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _isGeneratingInvoice = false;
      notifyListeners();
      print(e);
      // OverlayManager.showToast(
      //     type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  // =======================GET CHECKLIST ================================

  bool _isGettingChecklist = false;
  bool get isGettingChecklist => _isGettingChecklist;

  List<GetChecklistModel> _getChecklistModel = [];
  List<GetChecklistModel> get getChecklistModel => _getChecklistModel;

  Future<void> getChecklistData(int checklistId, BuildContext context) async {
    _isGettingChecklist = true;
    print("==========checklist id ==============");
    print(checklistId);

    notifyListeners();
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "checklistId": checklistId,
      };
      http.Response response = await http.post(Uri.parse(GETCHECKLIST),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);
      List<GetChecklistModel> list = [];
      if (response.statusCode == 200) {
        print("Success");
        for (var i in data["result"]) {
          GetChecklistModel _model = GetChecklistModel.fromJson(i);
          list.add(_model);
        }
        _getChecklistModel = list;

        print(_getChecklistModel);
        _isGettingChecklist = false;

        notifyListeners();
        // CustomNavigator.pop(context);
      } else {
        print("else");
        _getChecklistModel = [];
        _isGettingChecklist = false;
        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _getChecklistModel = [];

      _isGettingChecklist = false;
      notifyListeners();
      print(e);
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

  // =================== VIEW INVOICE ============================
  bool _isGettingInvoice = false;
  bool get isGettingInvoice => _isGettingInvoice;
  Map<String, dynamic> _viewInvoiceData = {};
  Map<String, dynamic> get viewInvoiceData => _viewInvoiceData;
  Future<void> viewInvoice(int invoiceId, BuildContext context) async {
    _isGettingInvoice = true;

    notifyListeners();
    print(invoiceId);
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "invoiceId": invoiceId,
      };
      http.Response response = await http.post(Uri.parse(VIEWINVOICE),
          headers: headers, body: jsonEncode(body));

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("Success");
        _viewInvoiceData = data["result"];
        _isGettingInvoice = false;

        notifyListeners();
        // CustomNavigator.pop(context);
      } else {
        print("else");
        _viewInvoiceData = {};
        _isGettingInvoice = false;
        notifyListeners();
        // OverlayManager.showToast(
        // type: ToastType.Error, msg: "Something went wrong !");

        // throw data["message"];
      }
    } catch (e) {
      _viewInvoiceData = {};

      _isGettingInvoice = false;
      notifyListeners();
      print(e);
      // OverlayManager.showToast(
      // type: ToastType.Error, msg: "Something went wrong !");
      throw e;
    }
  }

//====================== OFFLINE PAYMENT ==============================

  bool _isPayment = false;
  bool get isPayment => _isPayment;

  Future<void> offliinePayment(
      String mop,
      String invoiceNo,
      String paidAmount,
      int invoiceId,
      int ticketId,
      Map<String, dynamic> invoice_items,
      BuildContext context) async {
    _isPayment = true;

    notifyListeners();
    print(invoiceId);

    List<Map<String, dynamic>> d = [];
    for (var i in invoice_items["invoiceItems"]) {
      Map<String, dynamic> mp = {
        "priceId": i["price_id"],
      };

      d.add(mp);
    }
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "mop": mop,
        "invoiceNo": invoiceNo,
        "paidAmount": int.parse(paidAmount),
        "invoiceId": invoiceId,
        "ticketId": ticketId,
        "paidInvoiceItems": d
      };
      http.Response response = await http.post(Uri.parse(OFFLINEPAYMENT),
          headers: headers, body: jsonEncode(body));

      print("===========body==========");
      print(jsonEncode(body));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _isPayment = false;

        notifyListeners();
        CustomNavigator.pop(context);
      } else {
        print("else");
        _isPayment = false;
        notifyListeners();
      }
    } catch (e) {
      _isPayment = false;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  //==========SEND TRACKING LINK ========================
  bool _isTrack = false;
  bool get isTrack => _isTrack;
  Future<void> sendTrack(BuildContext context, int custID, int ticketId) async {
    _isTrack = true;
    notifyListeners();
    print(custID);
    print(ticketId);
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");

    try {
      var headers = {'Content-Type': 'application/json', 'token': jwt_token};
      Map<String, dynamic> body = {
        "customerId": custID,
        "technicianId": techId,
        "ticketId": ticketId
      };
      http.Response response = await http.post(Uri.parse(SENDTRACKINGLINK),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        OverlayManager.showToast(type: ToastType.Success , msg: "Succesfully send the tracking link");
        print("success");
        _isTrack = false;
        notifyListeners();
      } else {
        _isTrack = false;
        notifyListeners();
      }
    } catch (e) {
      _isTrack = false;
      notifyListeners();
      throw e;
    }
  }
}
