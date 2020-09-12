import 'package:barahi/features/homepage/presentation/bloc/order_cart_bloc.dart';
import 'package:barahi/features/homepage/presentation/pages/tablet/popular_items_tab.dart';
import 'package:barahi/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'bill_screen.dart';
import 'fast_food_items_tab.dart';

class TabletScreen extends StatefulWidget {
  _TabletScreenState createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController horizontalScrollController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
                        child: BlocBuilder<OrderCartBloc, OrderCartState>(
                          builder: (context, state) {
                            if (state is OrderCartLoadedState) {
                              return Scrollbar(
                                isAlwaysShown: true,
                                controller: horizontalScrollController,
                                child: ListView.builder(
                                  controller: horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: null,
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
                                                  state.products[index].image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Text(state.products[index].name),
                                            Text(state.products[index].price
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
                                  BlocProvider(
                                    create: (_) => sl<OrderCartBloc>()
                                      ..add(GetBurgersEvent()),
                                    child: PopularItemsTab(),
                                  ),
                                  BlocProvider(
                                    create: (_) => sl<OrderCartBloc>()
                                      ..add(GetDrinksEvent()),
                                    child: FastFoodTab(),
                                  ),
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
                                  Tab(icon: new Text("Popular")),
                                  Tab(icon: new Text("Coffee")),
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
