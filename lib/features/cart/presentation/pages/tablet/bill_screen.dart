import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BillSection extends StatefulWidget {
  _BillSectionState createState() => _BillSectionState();
}

class _BillSectionState extends State<BillSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Container(
          width: sizingInformation.screenSize.width * 0.3,
          child: Column(
            children: [
              Container(
                  height: sizingInformation.screenSize.height * 0.05,
                  child: Text("Checkout")),
              SingleChildScrollView(
                child: Container(
                  height: sizingInformation.screenSize.height * 0.6,
                  child: BlocBuilder<CartItemBloc, CartItemState>(
                    builder: (context, state) {
                      print("cart state is $state");
                      if (state is DisplayProductErrorState) {
                        return Container();
                      } else if (state is CartItemLoadedState) {
                        return DataTable(
                          columns: [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Quantity')),
                            DataColumn(label: Text('Price')),
                          ],
                          rows: state.cartDto.selectedProducts
                              .map(
                                ((element) => DataRow(
                                      cells: [
                                        DataCell(Text(element.name)),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(AntDesign.minuscircleo),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(AntDesign.pluscircleo),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                            Text(element.price.toString())),
                                      ],
                                    )),
                              )
                              .toList(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              BlocBuilder<CartItemBloc, CartItemState>(
                builder: (context, state) {
                  if (state is CartItemLoadedState) {
                    return Container(
                      height: sizingInformation.screenSize.height * 0.1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total"),
//                              Text(state.cartDto.totalPrice.toString()),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Pay (\$498.00)"),
              )
            ],
          ),
        );
      },
    );
  }
}
