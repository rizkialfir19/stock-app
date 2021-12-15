import 'package:stock_app/common/common.dart';

class StocksSymbol extends BaseModel {
  final String? currency;
  final String? description;
  final String? displaySymbol;
  final String? figi;
  final String? mic;
  final String? symbol;
  final String? type;

  StocksSymbol({
    this.currency,
    this.description,
    this.displaySymbol,
    this.figi,
    this.mic,
    this.symbol,
    this.type,
  }) : super({
          "currency": currency,
          "description": description,
          "displaySymbol": displaySymbol,
          "figi": figi,
          "mic": mic,
          "symbol": symbol,
          "type": type,
        });

  factory StocksSymbol.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Null JSON provided');
    }

    return StocksSymbol(
      currency: json['currency'],
      description: json['description'],
      displaySymbol: json['displaySymbol'],
      figi: json['figi'],
      mic: json['mic'],
      symbol: json['symbol'],
      type: json['type'],
    );
  }

  @override
  copyWith({
    String? currency,
    String? description,
    String? displaySymbol,
    String? figi,
    String? mic,
    String? symbol,
    String? type,
  }) {
    return StocksSymbol(
      currency: currency ?? this.currency,
      description: description ?? this.description,
      displaySymbol: displaySymbol ?? this.displaySymbol,
      figi: figi ?? this.figi,
      mic: mic ?? this.mic,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
    );
  }
}
