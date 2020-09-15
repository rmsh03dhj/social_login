import 'package:barahi/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:barahi/features/cart/presentation/bloc/cart_item_bloc.dart';
import 'package:barahi/features/homepage/data/datasources/local_data_source.dart';
import 'package:barahi/features/homepage/data/datasources/remote_data_source.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';
import 'features/homepage/data/repositories/product_repository_impl.dart';
import 'features/homepage/domain/repositories/product_repository.dart';
import 'features/homepage/domain/usecases/get_home_page_products_use_case.dart';
import 'features/homepage/presentation/bloc/display_product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc
  sl.registerFactory(() => DisplayProductBloc(getHomePageProductsUseCase: sl()));
  sl.registerFactory(() => CartItemBloc(addProductToCartUseCase: sl()));

  //use cases
  sl.registerLazySingleton(() => GetHomePageProductsUseCase(sl()));
  sl.registerLazySingleton(() => AddProductToCartUseCase(sl()));

  //repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

    // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  //external
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
}
