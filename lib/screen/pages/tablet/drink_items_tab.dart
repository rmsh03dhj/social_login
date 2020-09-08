import 'package:barahi/bloc/order_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DrinksTab extends StatelessWidget {
  final ScrollController verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderInitial) {
              return Container();
            } else if (state is ItemAdded) {
              return Scrollbar(
                isAlwaysShown: true,
                controller: verticalScrollController,
                child: GridView.count(
                  controller: verticalScrollController,
                  crossAxisCount: 5,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  children: List.generate(
                    state.items.length,
                    (index) {
                      return Card(
                        child: Container(
                          height: sizingInformation.screenSize.height * 0.25,
                          width: sizingInformation.screenSize.height * 0.25,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(children: [
                            Image.asset(
                              state.items[index].image,
                              fit: BoxFit.fill,
                            ),
                            Text(state.items[index].name),
                            Text(state.items[index].price.toString()),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
