import 'package:barahi/OrderBloc.dart';
import 'package:barahi/bloc_provider.dart';
import 'package:barahi/model/data_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FastFoodTab extends StatelessWidget {
  final ScrollController verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return StreamBuilder<Categories>(
          stream: BlocProvider.of<OrderBloc>(context).fastFoodItems,
          builder: (context, snapshot) {
            if (snapshot.data == null) return Container();
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
                  snapshot.data.items.length,
                  (index) {
                    return Card(
                      child: Container(
                        height: sizingInformation.screenSize.height * 0.25,
                        width: sizingInformation.screenSize.height * 0.25,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(children: [
                          Image.asset(
                            snapshot.data.items[index].image,
                            fit: BoxFit.fill,
                          ),
                          Text(snapshot.data.items[index].name),
                          Text(snapshot.data.items[index].price.toString()),
                        ]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
