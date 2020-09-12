import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'features/homepage/presentation/bloc/order_cart_bloc.dart';
import 'features/homepage/presentation/pages/tablet/tablet_screen.dart';
import 'service_locator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // if (sizingInformation.isDesktop){
        //   return DesktopScreen();
        // }
        // if (sizingInformation.isTablet){
        return BlocProvider(
          create: (_) => sl<OrderCartBloc>()..add(GetAllProductEvent()),
          child: TabletScreen(),
        );
        //   }
        //   return MobileScreen();
      },
    );
  }
}
