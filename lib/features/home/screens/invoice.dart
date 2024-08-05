// ignore_for_file: prefer_interpolation_to_compose_strings, unused_import, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/constants/app_data.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/data/home_provider.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/models/invoice_model.dart';
import 'package:pick_a_service/features/home/widgets/orders_widget.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:pick_a_service/ticket_details_model.dart';
import 'package:pick_a_service/ui/molecules/custom_autocomplete_text_field.dart';
import 'package:pick_a_service/ui/molecules/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatefulWidget {
  TicketDetailsModel arguments;
  InvoiceScreen({super.key, required this.arguments});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> list = [];
  List<InvoiceModel> data = [];
  double totalMoney = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false)
          .getInvoice(widget.arguments.subcategorymodelId , widget.arguments.ticketId);

      await Provider.of<HomeProvider>(context, listen: false)
          .getFilteredInvoice("", widget.arguments.ticketId);

      data = Provider.of<HomeProvider>(context, listen: false).getInvoiceList;
      for (var i in data) {
        Map<String, dynamic> mp = {
          "title": i.title,
          "price": i.price,
          "priceID": i.priceId,
          "isAdvance" : i.isAdvance
        };

        list.add(mp);
      }

      calculateMoney(list);
    });


    // Consumer(
    //   builder: (context, value, child) {},
    // );
    // HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    // for (var i in homeProvider.getInvoiceList) {
    //   Map<String, dynamic> mp = {
    //     "title": i.title,
    //     "price": i.price,
    //     "priceID": i.priceId
    //   };

    //   list.add(mp);
    // }
  }

  void calculateMoney(List<Map<String, dynamic>> mp) {
    totalMoney = 0;
    for (var i in mp) {
      totalMoney += double.parse(i["price"].toString());
    }
    print(totalMoney.toString());
    setState(() {});
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard and unfocus text field when tapping anywhere outside
        _focusNode.unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          // await provider.getacceptedOrders();
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 244, 246, 251),
          appBar: AppBar(
            // backgroundColor: Color.fromARGB(255, 126, 217, 245),
            backgroundColor: Color.fromARGB(255, 244, 246, 251),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.invoice,
                style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w600)),
            leading: GestureDetector(
                onTap: () => CustomNavigator.pop(context),
                child: Image.asset(AppIcons.backbutton)),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Image.asset(
                  AppIcons.app_logo,
                  color: AppColors.primary,
                  height: 43.h,
                  width: 56.w,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<HomeProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    CustomSpacers.height10,
                    _buildSearch(),
                    // CustomSpacers.height20,

                    OrdersWidget(data: widget.arguments),

                    // CustomSpacers.height20,
                    _buidPrices(),
                    CustomSpacers.height10,
                    !value.isGeneratingInvoice
                        ? CustomButton(
                            strButtonText:AppLocalizations.of(context)!.generateinvoice,
                            buttonAction: () {
                              value.createInvoice(widget.arguments.CustomerId,
                                  widget.arguments.ticketId, list, context);
                            },
                            bgColor: AppColors.primary,
                            textColor: AppColors.secondary,
                            dHeight: 40.h,
                            dWidth: 220.w,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    CustomSpacers.height52,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildSearch() {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  print(value.getFilteredInvoiceList);
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextField(
                              focusNode: _focusNode,
                              onChanged: (va) {
                                value.getFilteredInvoice(
                                    va, widget.arguments.ticketId);
                              },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.search,
                                hintText: AppLocalizations.of(context)!.search,
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(height: 8.h),
                            !value.isSearching
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: value.getFilteredInvoiceList
                                          .length, // Replace with your list length
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(value
                                              .getFilteredInvoiceList[index]
                                              .title!),
                                          onTap: () {
                                            Map<String, dynamic> mp = {
                                              "title": value
                                                  .getFilteredInvoiceList[index]
                                                  .title!,
                                              "price": value
                                                  .getFilteredInvoiceList[index]
                                                  .normalPrice,
                                              "priceID": value
                                                  .getFilteredInvoiceList[index]
                                                  .id,


                                                "isAdvance" : 0
                                            };

                                            setState(() {
                                              list.add(mp);
                                              calculateMoney(list);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 40.h,
                  width: 500.w,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CustomSpacers.width10,
                      Icon(Icons.search),
                      CustomSpacers.width10,
                      Text(AppLocalizations.of(context)!.search)
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _buidPrices() => Consumer<HomeProvider>(
        builder: (context, value, child) {
          return !value.isInvoiceLoading
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.price,
                                style: TextStyle(
                                    fontSize: 24.h,
                                    fontWeight: FontWeight.w600)),
                          totalMoney 
                          != 0  ?   Text(totalMoney.toString() + " KD",
                                style: TextStyle(
                                    fontSize: 22.h,
                                    fontWeight: FontWeight.w600)) : Container(),
                          ],
                        ),
                        CustomSpacers.height20,
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index]["title"],
                                      style: TextStyle(
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.w700)),
                                  CustomSpacers.height4,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          list[index]["price"].toString() +
                                              " KD",
                                          style: TextStyle(
                                              fontSize: 14.h,
                                              fontWeight: FontWeight.w500)),
                                     list[index]["isAdvance"] == 0 ?   GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  list.removeAt(index);
                                                  print(list);
                                                  calculateMoney(list);
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: AppColors.red,
                                                size: 20,
                                              ))
                                          : Text(
                                              AppLocalizations.of(context)!.mandatory , 
                                              style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w500 , color: Colors.green),
                                            ),
                                    ],
                                  ),
                                  CustomSpacers.height8,
                                  Divider()
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      );
}
