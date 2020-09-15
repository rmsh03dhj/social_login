import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DisplayDesertsTab extends StatelessWidget {
  final ScrollController verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return BlocBuilder<DisplayProductBloc, DisplayProductState>(
          builder: (context, state) {
            if (state is DisplayProductInitialState) {
              return Container();
            } else if (state is DisplayProductLoadedState) {
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
                    state.productDto.deserts.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<CartItemBloc>(context).add(
                              AddProductEvent(
                                  product:
                                      state.productDto.popularProducts[index]));
                        },
                        child: Card(
                          child: Container(
                            height: sizingInformation.screenSize.height * 0.25,
                            width: sizingInformation.screenSize.height * 0.25,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(children: [
                              Container(
                                height:
                                    sizingInformation.screenSize.height * 0.12,
                                width:
                                    sizingInformation.screenSize.height * 0.12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    state.productDto.deserts[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(state.productDto.deserts[index].name),
                              Text(state.productDto.deserts[index].price
                                  .toString()),
                            ]),
                          ),
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
