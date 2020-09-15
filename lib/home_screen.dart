import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_prodcut_event.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'features/homepage/presentation/bloc/display_product_bloc.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<CartItemBloc>(
              create: (context) => sl<CartItemBloc>(),
            ),
            BlocProvider<DisplayProductBloc>(
                        create: (_) => sl<DisplayProductBloc>()..add(GetAllProductEvent()),
            ),
          ],
          child: TabletScreen(),
        );
        //   }
        //   return MobileScreen();
      },
    );
  }
}
