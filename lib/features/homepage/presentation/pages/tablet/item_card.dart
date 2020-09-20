import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (_, sizingInformation) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            BlocProvider.of<CartItemBloc>(context)
                .add(AddProductEvent(product: product));
          },
          child: Card(
            child: Container(
              height: sizingInformation.screenSize.height * 0.20,
              width: sizingInformation.screenSize.height * 0.20,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  Container(
                    height: sizingInformation.screenSize.height * 0.10,
                    width: sizingInformation.screenSize.height * 0.10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(product.name),
                  SizedBox(height: 4,),
                  Text("AUD "+product.price.toString()),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
