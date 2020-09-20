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
import 'package:barahi/features/homepage/presentation/pages/tablet/item_card.dart';
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
                  width: sizingInformation.screenSize.width * 0.65,
                  child: Column(
                    children: [
                      ///top banner
                      Container(
                        height: sizingInformation.screenSize.height * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Popular Items",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: sizingInformation.screenSize.height * 0.20,
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
                                    return ItemCard(
                                      product: state
                                          .productDto.popularProducts[index],
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
