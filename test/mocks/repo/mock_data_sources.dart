import 'package:meal_planner/features/home/data/data_sources/local/home_local_data_source.dart';
import 'package:meal_planner/features/home/data/data_sources/remote/home_remote_Data_source.dart';
import 'package:mocktail/mocktail.dart';


class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockHomeLocalDataSource extends Mock implements HomeLocalDataSource {}