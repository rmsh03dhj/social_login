
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
          create: (context) => OrderCartBloc(),
          child: TabletScreen(),
        );
        //   }
        //   return MobileScreen();
      },
    );
  }
}