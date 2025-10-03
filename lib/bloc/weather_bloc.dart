import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await repository.fetchWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
