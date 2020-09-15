import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/cart/presentation/pages/tablet/bill_screen.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_prodcut_event.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_state.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/display_burger_tab.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/display_coffee_tab.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/display_deserts_tab.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/display_drinks_tab.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/display_pies_tab.dart';
import 'package:barahi/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'display_juices_tab.dart';

class TabletScreen extends StatefulWidget {
  _TabletScreenState createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController horizontalScrollController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.search),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Ramesh")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.menu,
                ),
              ),
            ],
          ),
          body: Container(
            child: Row(
              children: [
                ///left side
                Container(
                  width: sizingInformation.screenSize.width * 0.7,
                  color: Colors.green,
                  child: Column(
                    children: [
                      ///top banner
                      Container(
                        height: sizingInformation.screenSize.height * 0.25,
                        color: Colors.greenAccent,
                        child: BlocBuilder<DisplayProductBloc,
                            DisplayProductState>(
                          builder: (context, state) {
                            if (state is DisplayProductLoadedState) {
                              return Scrollbar(
                                isAlwaysShown: true,
                                controller: horizontalScrollController,
                                child: ListView.builder(
                                  controller: horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.productDto.popularProducts.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        BlocProvider.of<CartItemBloc>(context)
                                            .add(AddProductEvent(
                                                product: state.productDto
                                                    .popularProducts[index]));
                                      },
                                      child: Card(
                                        child: Container(
                                          height: sizingInformation
                                                  .screenSize.height *
                                              0.25,
                                          width: sizingInformation
                                                  .screenSize.height *
                                              0.25,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              height: sizingInformation
                                                      .screenSize.height *
                                                  0.18,
                                              width: sizingInformation
                                                      .screenSize.height *
                                                  0.18,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  state
                                                      .productDto
                                                      .popularProducts[index]
                                                      .image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Text(state.productDto
                                                .popularProducts[index].name),
                                            Text(state.productDto
                                                .popularProducts[index].price
                                                .toString()),
                                          ]),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),

                      ///middle part
                      Container(
                        height: sizingInformation.screenSize.height * 0.65,
                        child: Column(
                          children: [
                            ///mid-top
                            Container(
                              height:
                                  sizingInformation.screenSize.height * 0.05,
                            ),

                            ///mid-mid
                            Container(
                              height:
                                  sizingInformation.screenSize.height * 0.55,
                              color: Colors.grey,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  DisplayBurgersTab(),
                                  DisplayCoffeesTab(),
                                  DisplayDesertsTab(),
                                  DisplayDrinksTab(),
                                  DisplayJuicesTab(),
                                  DisplayPiesTab(),
                                ],
                              ),
                            ),

                            ///bottom-navigator
                            Container(
                              height:
                                  sizingInformation.screenSize.height * 0.05,
                              child: TabBar(
                                controller: _tabController,
                                tabs: [
                                  Tab(icon: new Text("Burgers")),
                                  Tab(icon: new Text("Coffee")),
                                  Tab(icon: new Text("Desert")),
                                  Tab(icon: new Text("Drinks")),
                                  Tab(icon: new Text("Juice")),
                                  Tab(icon: new Text("Pies")),
                                  // Tab(icon: new Text("Drinks")),
                                  // Tab(icon: new Text("Fast food")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///right side
                BillSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}

void addProductToCart(Product product) {
  CartItemBloc()..add(AddProductEvent(product: product));
}
