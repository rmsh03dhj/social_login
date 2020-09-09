import 'package:barahi/bloc/order_cart_bloc.dart';
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
    return ResponsiveBuilder(builder: (_, sizingInformation) {
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
                child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                  if (state is OrderInitial) {
                    return Container();
                  } else if (state is ItemAdded) {
                    return DataTable(
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Price')),
                      ],
                      rows: state.items
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
                                          Text(element.quantity.toString()),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Icon(AntDesign.pluscircleo),
                                        ],
                                      ),
                                    ),
                                    DataCell(Text(element.price.toString())),
                                  ],
                                )),
                          )
                          .toList(),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
            Container(
              height: sizingInformation.screenSize.height * 0.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rewards Points"),
                      Text("450"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount"),
                      Text("2.90"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub total"),
                      Text("500.90"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total"),
                      Text("498.00"),
                    ],
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Pay (\$498.00)"),
            )
          ],
        ),
      );
    });
  }
}
