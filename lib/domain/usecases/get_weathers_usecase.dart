import 'dart:async';

import 'package:barahi/data/repositories/product_repository_impl.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:weather/src/domain/entities/weather.dart';
import 'package:weather/src/domain/repositories/repository.dart';

class GetWeatherUseCase
    extends UseCase<GetWeatherUseCaseResponse, GetWeatherUseCaseParams> {
  final ProductRepositoryImpl productRepositoryImpl;
  GetWeatherUseCase(this.productRepositoryImpl);

  @override
  Future<Stream<GetWeatherUseCaseResponse>> buildUseCaseStream(
      GetWeatherUseCaseParams params) async {
    final controller = StreamController<GetWeatherUseCaseResponse>();
    try {
      final products = productRepositoryImpl.getAllProducts();
      controller.add(GetWeatherUseCaseResponse(products));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetWeatherUseCaseParams {
  final String location;
  GetWeatherUseCaseParams(this.location);
}

class GetWeatherUseCaseResponse {
  final List<Weather> weatherList;
  GetWeatherUseCaseResponse(this.weatherList);
}
