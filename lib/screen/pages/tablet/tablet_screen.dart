import 'package:barahi/data/repository/product_repository_impl.dart';
import 'package:barahi/screen/pages/tablet/popular_items_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'bill_screen.dart';
import 'coffee_items_tab.dart';
import 'drink_items_tab.dart';
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
    _tabController = TabController(length: 4, vsync: this);
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
                  color: Colors.red,
                  child: Column(
                    children: [
                      ///top banner
                      Container(
                        height: sizingInformation.screenSize.height * 0.25,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: horizontalScrollController,
                          child: ListView.builder(
                            controller: horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                ProductRepositoryImpl().getAllProducts().length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: ,
                                child: Card(
                                  child: Container(
                                    height:
                                        sizingInformation.screenSize.height *
                                            0.25,
                                    width: sizingInformation.screenSize.height *
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
                                        child: Image.asset(
                                          ProductRepositoryImpl()
                                              .getAllProducts()[index]
                                              .image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(ProductRepositoryImpl()
                                          .getAllProducts()[index]
                                          .name),
                                      Text(ProductRepositoryImpl()
                                          .getAllProducts()[index]
                                          .price
                                          .toString()),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ),
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
                                  PopularItemsTab(),
                                  CoffeeTab(),
                                  DrinksTab(),
                                  FastFoodTab(),
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
                                  Tab(icon: new Text("Drinks")),
                                  Tab(icon: new Text("Fast food")),
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
