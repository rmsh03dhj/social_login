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
          width: sizingInformation.screenSize.width * 0.35,
          child: Column(
            children: [
              Container(
                height: sizingInformation.screenSize.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: sizingInformation.screenSize.height * 0.6,
                  child: BlocBuilder<CartItemBloc, CartItemState>(
                    builder: (context, state) {
                      if (state is DisplayProductErrorState) {
                        return Container();
                      } else if (state is CartItemLoadedState) {
                        if (state.cartDto.selectedProducts.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "No items added.",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        } else {
                          return DataTable(
                            columns: [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Price (AUD)')),
                            ],
                            rows: state.cartDto.selectedProducts
                                .map(
                                  ((element) => DataRow(
                                        cells: [
                                          DataCell(Text(element.product.name)),
                                          DataCell(
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                      AntDesign.minuscircleo),
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                CartItemBloc>(
                                                            context)
                                                        .add(
                                                            DecrementQuantityEvent(
                                                                product: element
                                                                    .product));
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(element.quantity
                                                    .toString()),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                      AntDesign.pluscircleo),
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                CartItemBloc>(
                                                            context)
                                                        .add(
                                                            IncrementQuantityEvent(
                                                                product: element
                                                                    .product));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          DataCell(Text(element.totalPrice)),
                                        ],
                                      )),
                                )
                                .toList(),
                          );
                        }
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
                    if (state.cartDto.totalPrice == 0) {
                      return Column(
                        children: [
                          Container(
                            height: sizingInformation.screenSize.height * 0.15,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Pay"),
                            color: Colors.grey,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: sizingInformation.screenSize.height * 0.15,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Total"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(state.cartDto.totalPrice
                                          .toStringAsFixed(2)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Pay (\$" +
                                state.cartDto.totalPrice.toStringAsFixed(2) +
                                ")"),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
