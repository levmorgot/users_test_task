import 'package:equatable/equatable.dart';


class CompanyEntity extends Equatable {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyEntity({
    required this.name,
    required this.catchPhrase,
    required this.bs
  });

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}