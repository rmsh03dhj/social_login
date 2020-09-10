

import 'package:barahi/data/repositories/product_repository_impl.dart';
import 'package:barahi/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';

import 'bloc/order/order_cart_bloc.dart';
import 'domain/usecases/get_home_page_products_use_case.dart';

final sl = GetIt.instance;

//Service locator description
void init() async{

//bloc
  sl.registerFactory(() => OrderCartBloc());
  
  //use cases
  sl.registerLazySingleton(() => GetHomePageProductsUseCase(sl()));

  //repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(),
  );

  //external
  final sharedPrefs = await SharedPreferences;
}
