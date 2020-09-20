import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_state.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DisplayBurgersTab extends StatelessWidget {
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
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  shrinkWrap: true,
                  children: List.generate(
                    state.productDto.burgers.length,
                    (index) {
                      return ItemCard(
                        product: state.productDto.burgers[index],
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
