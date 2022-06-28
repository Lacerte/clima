/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima/data/models/full_weather_model.dart';
import 'package:clima/domain/entities/city.dart';
import 'package:clima/domain/entities/daily_forecast.dart';
import 'package:clima/domain/entities/full_weather.dart';
import 'package:clima/domain/entities/hourly_forecast.dart';
import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/domain/entities/weather.dart';
import 'package:test/test.dart';

void main() {
  group('FullWeather', () {
    group('currentDayForecast', () {
      test("returns current day forecast in the location's local time zone",
          () {
        // This weather data was chosen because its daily forecasts are shifted
        // one day backward in UTC compared to the local time zone of the
        // location. For instance, the first forecast is on Wednesday in UTC
        // time, but on Thursday in the local time zone.
        //
        // See https://github.com/Lacerte/clima/issues/317.
        final fullWeather = FullWeatherModel.fromJson(
          jsonDecode(
            '{"lat":-43.5257,"lon":172.6398,"timezone":"Pacific/Auckland","timezone_offset":43200,"current":{"dt":1656521578,"sunrise":1656533011,"sunset":1656565330,"temp":271.42,"feels_like":269.36,"pressure":1008,"humidity":100,"dew_point":271.42,"uvi":0,"clouds":0,"visibility":3900,"wind_speed":1.54,"wind_deg":20,"weather":[{"id":701,"main":"Mist","description":"mist","icon":"50n"}]},"minutely":[{"dt":1656521580,"precipitation":0},{"dt":1656521640,"precipitation":0},{"dt":1656521700,"precipitation":0},{"dt":1656521760,"precipitation":0},{"dt":1656521820,"precipitation":0},{"dt":1656521880,"precipitation":0},{"dt":1656521940,"precipitation":0},{"dt":1656522000,"precipitation":0},{"dt":1656522060,"precipitation":0},{"dt":1656522120,"precipitation":0},{"dt":1656522180,"precipitation":0},{"dt":1656522240,"precipitation":0},{"dt":1656522300,"precipitation":0},{"dt":1656522360,"precipitation":0},{"dt":1656522420,"precipitation":0},{"dt":1656522480,"precipitation":0},{"dt":1656522540,"precipitation":0},{"dt":1656522600,"precipitation":0},{"dt":1656522660,"precipitation":0},{"dt":1656522720,"precipitation":0},{"dt":1656522780,"precipitation":0},{"dt":1656522840,"precipitation":0},{"dt":1656522900,"precipitation":0},{"dt":1656522960,"precipitation":0},{"dt":1656523020,"precipitation":0},{"dt":1656523080,"precipitation":0},{"dt":1656523140,"precipitation":0},{"dt":1656523200,"precipitation":0},{"dt":1656523260,"precipitation":0},{"dt":1656523320,"precipitation":0},{"dt":1656523380,"precipitation":0},{"dt":1656523440,"precipitation":0},{"dt":1656523500,"precipitation":0},{"dt":1656523560,"precipitation":0},{"dt":1656523620,"precipitation":0},{"dt":1656523680,"precipitation":0},{"dt":1656523740,"precipitation":0},{"dt":1656523800,"precipitation":0},{"dt":1656523860,"precipitation":0},{"dt":1656523920,"precipitation":0},{"dt":1656523980,"precipitation":0},{"dt":1656524040,"precipitation":0},{"dt":1656524100,"precipitation":0},{"dt":1656524160,"precipitation":0},{"dt":1656524220,"precipitation":0},{"dt":1656524280,"precipitation":0},{"dt":1656524340,"precipitation":0},{"dt":1656524400,"precipitation":0},{"dt":1656524460,"precipitation":0},{"dt":1656524520,"precipitation":0},{"dt":1656524580,"precipitation":0},{"dt":1656524640,"precipitation":0},{"dt":1656524700,"precipitation":0},{"dt":1656524760,"precipitation":0},{"dt":1656524820,"precipitation":0},{"dt":1656524880,"precipitation":0},{"dt":1656524940,"precipitation":0},{"dt":1656525000,"precipitation":0},{"dt":1656525060,"precipitation":0},{"dt":1656525120,"precipitation":0},{"dt":1656525180,"precipitation":0}],"hourly":[{"dt":1656518400,"temp":272.78,"feels_like":270.55,"pressure":1008,"humidity":96,"dew_point":272.29,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":1.78,"wind_deg":4,"wind_gust":2.09,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656522000,"temp":271.42,"feels_like":268.75,"pressure":1008,"humidity":100,"dew_point":271.42,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":1.95,"wind_deg":27,"wind_gust":2.4,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656525600,"temp":272.77,"feels_like":269.89,"pressure":1008,"humidity":96,"dew_point":272.28,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":2.3,"wind_deg":41,"wind_gust":2.96,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656529200,"temp":274.2,"feels_like":271.77,"pressure":1008,"humidity":92,"dew_point":273.06,"uvi":0,"clouds":27,"visibility":10000,"wind_speed":2.13,"wind_deg":39,"wind_gust":2.85,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"pop":0},{"dt":1656532800,"temp":275.54,"feels_like":273.95,"pressure":1008,"humidity":89,"dew_point":273.92,"uvi":0,"clouds":25,"visibility":10000,"wind_speed":1.62,"wind_deg":37,"wind_gust":2.33,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"pop":0},{"dt":1656536400,"temp":277.44,"feels_like":276.38,"pressure":1007,"humidity":85,"dew_point":275.15,"uvi":0.18,"clouds":26,"visibility":10000,"wind_speed":1.43,"wind_deg":27,"wind_gust":2.06,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1656540000,"temp":280.24,"feels_like":279.26,"pressure":1007,"humidity":77,"dew_point":276.27,"uvi":0.5,"clouds":29,"visibility":10000,"wind_speed":1.69,"wind_deg":21,"wind_gust":2.43,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1656543600,"temp":281.21,"feels_like":280.33,"pressure":1006,"humidity":72,"dew_point":276.41,"uvi":0.89,"clouds":42,"visibility":10000,"wind_speed":1.74,"wind_deg":28,"wind_gust":2.15,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1656547200,"temp":282.07,"feels_like":282.07,"pressure":1005,"humidity":69,"dew_point":276.55,"uvi":1.19,"clouds":42,"visibility":10000,"wind_speed":1.16,"wind_deg":9,"wind_gust":1.33,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1656550800,"temp":282.79,"feels_like":282.79,"pressure":1004,"humidity":67,"dew_point":276.66,"uvi":1.07,"clouds":64,"visibility":10000,"wind_speed":1.27,"wind_deg":290,"wind_gust":2.02,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1656554400,"temp":283.7,"feels_like":282.51,"pressure":1004,"humidity":65,"dew_point":277.26,"uvi":0.81,"clouds":82,"visibility":10000,"wind_speed":1.85,"wind_deg":255,"wind_gust":3.89,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1656558000,"temp":284.35,"feels_like":283.3,"pressure":1003,"humidity":68,"dew_point":278.45,"uvi":0.45,"clouds":88,"visibility":10000,"wind_speed":0.9,"wind_deg":312,"wind_gust":2.12,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1656561600,"temp":284.09,"feels_like":283.02,"pressure":1003,"humidity":68,"dew_point":278.26,"uvi":0.17,"clouds":91,"visibility":10000,"wind_speed":2.07,"wind_deg":325,"wind_gust":3.66,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0.02},{"dt":1656565200,"temp":284.04,"feels_like":282.88,"pressure":1002,"humidity":65,"dew_point":277.54,"uvi":0,"clouds":93,"visibility":10000,"wind_speed":4.66,"wind_deg":314,"wind_gust":9.18,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0.02},{"dt":1656568800,"temp":285.05,"feels_like":283.84,"pressure":1001,"humidity":59,"dew_point":277.24,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":7.82,"wind_deg":302,"wind_gust":15.13,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.02},{"dt":1656572400,"temp":284,"feels_like":282.84,"pressure":1002,"humidity":65,"dew_point":277.48,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":5.89,"wind_deg":306,"wind_gust":11.16,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1656576000,"temp":282.36,"feels_like":278.86,"pressure":1004,"humidity":76,"dew_point":278.1,"uvi":0,"clouds":55,"visibility":10000,"wind_speed":7.74,"wind_deg":213,"wind_gust":13.41,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0},{"dt":1656579600,"temp":281.14,"feels_like":277.11,"pressure":1007,"humidity":81,"dew_point":277.92,"uvi":0,"clouds":54,"visibility":10000,"wind_speed":8.37,"wind_deg":200,"wind_gust":12.43,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0.01},{"dt":1656583200,"temp":280.48,"feels_like":276.5,"pressure":1009,"humidity":82,"dew_point":277.47,"uvi":0,"clouds":65,"visibility":10000,"wind_speed":7.49,"wind_deg":214,"wind_gust":11.63,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"pop":0.74,"rain":{"1h":0.49}},{"dt":1656586800,"temp":279.3,"feels_like":275.18,"pressure":1011,"humidity":87,"dew_point":277.18,"uvi":0,"clouds":72,"visibility":10000,"wind_speed":6.88,"wind_deg":215,"wind_gust":11.54,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10n"}],"pop":1,"rain":{"1h":1.12}},{"dt":1656590400,"temp":278.92,"feels_like":274.92,"pressure":1012,"humidity":88,"dew_point":276.95,"uvi":0,"clouds":77,"visibility":10000,"wind_speed":6.26,"wind_deg":226,"wind_gust":11.09,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"pop":1,"rain":{"1h":0.8}},{"dt":1656594000,"temp":278.84,"feels_like":275.32,"pressure":1013,"humidity":84,"dew_point":276.06,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":5.06,"wind_deg":230,"wind_gust":11.41,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"pop":0.82,"rain":{"1h":0.48}},{"dt":1656597600,"temp":278.26,"feels_like":274.78,"pressure":1013,"humidity":88,"dew_point":276.16,"uvi":0,"clouds":95,"visibility":10000,"wind_speed":4.69,"wind_deg":280,"wind_gust":6.57,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.75},{"dt":1656601200,"temp":277.23,"feels_like":273.69,"pressure":1013,"humidity":95,"dew_point":276.32,"uvi":0,"clouds":90,"visibility":10000,"wind_speed":4.33,"wind_deg":292,"wind_gust":5.93,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.56},{"dt":1656604800,"temp":277.18,"feels_like":274.58,"pressure":1013,"humidity":91,"dew_point":275.74,"uvi":0,"clouds":87,"visibility":10000,"wind_speed":2.89,"wind_deg":305,"wind_gust":4.33,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.44},{"dt":1656608400,"temp":276.93,"feels_like":274.9,"pressure":1013,"humidity":88,"dew_point":274.94,"uvi":0,"clouds":75,"visibility":10000,"wind_speed":2.19,"wind_deg":325,"wind_gust":3.1,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0.36},{"dt":1656612000,"temp":276.79,"feels_like":275.16,"pressure":1013,"humidity":85,"dew_point":274.34,"uvi":0,"clouds":63,"visibility":10000,"wind_speed":1.8,"wind_deg":348,"wind_gust":2.56,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0.3},{"dt":1656615600,"temp":276.83,"feels_like":275.14,"pressure":1013,"humidity":82,"dew_point":273.92,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":1.86,"wind_deg":0,"wind_gust":2.39,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656619200,"temp":276.83,"feels_like":275.39,"pressure":1013,"humidity":82,"dew_point":273.72,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":1.65,"wind_deg":1,"wind_gust":2.24,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656622800,"temp":277.43,"feels_like":275.82,"pressure":1013,"humidity":80,"dew_point":274.17,"uvi":0.18,"clouds":0,"visibility":10000,"wind_speed":1.87,"wind_deg":0,"wind_gust":2.57,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656626400,"temp":278.71,"feels_like":276.52,"pressure":1013,"humidity":77,"dew_point":274.92,"uvi":0.47,"clouds":0,"visibility":10000,"wind_speed":2.74,"wind_deg":359,"wind_gust":4.24,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656630000,"temp":279.79,"feels_like":278.23,"pressure":1013,"humidity":72,"dew_point":274.94,"uvi":0.84,"clouds":1,"visibility":10000,"wind_speed":2.22,"wind_deg":2,"wind_gust":3.29,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656633600,"temp":280.73,"feels_like":280.17,"pressure":1013,"humidity":66,"dew_point":274.7,"uvi":1.11,"clouds":3,"visibility":10000,"wind_speed":1.39,"wind_deg":357,"wind_gust":1.97,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656637200,"temp":281.44,"feels_like":281.44,"pressure":1012,"humidity":62,"dew_point":274.41,"uvi":1.1,"clouds":3,"visibility":10000,"wind_speed":0.96,"wind_deg":330,"wind_gust":1.72,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656640800,"temp":281.93,"feels_like":281.93,"pressure":1012,"humidity":59,"dew_point":274.16,"uvi":0.84,"clouds":4,"visibility":10000,"wind_speed":0.6,"wind_deg":298,"wind_gust":1.55,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656644400,"temp":282.15,"feels_like":282.15,"pressure":1012,"humidity":58,"dew_point":274.27,"uvi":0.47,"clouds":4,"visibility":10000,"wind_speed":0.76,"wind_deg":304,"wind_gust":2.01,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656648000,"temp":281.65,"feels_like":281.65,"pressure":1012,"humidity":63,"dew_point":274.88,"uvi":0.18,"clouds":3,"visibility":10000,"wind_speed":0.52,"wind_deg":31,"wind_gust":1.3,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656651600,"temp":280.09,"feels_like":280.09,"pressure":1012,"humidity":67,"dew_point":274.23,"uvi":0,"clouds":3,"visibility":10000,"wind_speed":0.8,"wind_deg":355,"wind_gust":1.48,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1656655200,"temp":279.66,"feels_like":278.5,"pressure":1013,"humidity":71,"dew_point":274.5,"uvi":0,"clouds":3,"visibility":10000,"wind_speed":1.78,"wind_deg":304,"wind_gust":2.27,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656658800,"temp":279.12,"feels_like":277.03,"pressure":1014,"humidity":75,"dew_point":274.76,"uvi":0,"clouds":6,"visibility":10000,"wind_speed":2.71,"wind_deg":286,"wind_gust":3.32,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656662400,"temp":278.53,"feels_like":275.88,"pressure":1015,"humidity":79,"dew_point":275.09,"uvi":0,"clouds":4,"visibility":10000,"wind_speed":3.34,"wind_deg":287,"wind_gust":4.93,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656666000,"temp":278.22,"feels_like":275.59,"pressure":1015,"humidity":80,"dew_point":274.81,"uvi":0,"clouds":3,"visibility":10000,"wind_speed":3.21,"wind_deg":279,"wind_gust":4.72,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656669600,"temp":278.02,"feels_like":275.82,"pressure":1016,"humidity":79,"dew_point":274.51,"uvi":0,"clouds":2,"visibility":10000,"wind_speed":2.59,"wind_deg":266,"wind_gust":3.58,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656673200,"temp":278.01,"feels_like":276.06,"pressure":1016,"humidity":78,"dew_point":274.31,"uvi":0,"clouds":2,"visibility":10000,"wind_speed":2.3,"wind_deg":264,"wind_gust":3.1,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656676800,"temp":278.08,"feels_like":276.13,"pressure":1017,"humidity":77,"dew_point":274.12,"uvi":0,"clouds":2,"visibility":10000,"wind_speed":2.32,"wind_deg":274,"wind_gust":2.99,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656680400,"temp":277.94,"feels_like":276.22,"pressure":1018,"humidity":77,"dew_point":274.05,"uvi":0,"clouds":1,"visibility":10000,"wind_speed":2.05,"wind_deg":273,"wind_gust":2.72,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656684000,"temp":277.9,"feels_like":276.73,"pressure":1018,"humidity":77,"dew_point":273.99,"uvi":0,"clouds":1,"visibility":10000,"wind_speed":1.56,"wind_deg":265,"wind_gust":2.12,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1656687600,"temp":277.98,"feels_like":277.98,"pressure":1018,"humidity":76,"dew_point":273.92,"uvi":0,"clouds":0,"visibility":10000,"wind_speed":1.15,"wind_deg":264,"wind_gust":1.74,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0}],"daily":[{"dt":1656547200,"sunrise":1656533011,"sunset":1656565330,"moonrise":1656536700,"moonset":1656567360,"moon_phase":0.03,"temp":{"day":282.07,"min":271.42,"max":285.05,"night":279.3,"eve":285.05,"morn":272.77},"feels_like":{"day":282.07,"night":275.18,"eve":283.84,"morn":269.89},"pressure":1005,"humidity":69,"dew_point":276.55,"wind_speed":8.37,"wind_deg":200,"wind_gust":15.13,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"clouds":42,"pop":1,"rain":1.61,"uvi":1.19},{"dt":1656633600,"sunrise":1656619405,"sunset":1656651759,"moonrise":1656625620,"moonset":1656657360,"moon_phase":0.06,"temp":{"day":280.73,"min":276.79,"max":282.15,"night":278.01,"eve":279.66,"morn":276.79},"feels_like":{"day":280.17,"night":276.06,"eve":278.5,"morn":275.16},"pressure":1013,"humidity":66,"dew_point":274.7,"wind_speed":6.26,"wind_deg":226,"wind_gust":11.41,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":3,"pop":1,"rain":1.28,"uvi":1.11},{"dt":1656720000,"sunrise":1656705796,"sunset":1656738189,"moonrise":1656714060,"moonset":1656747600,"moon_phase":0.09,"temp":{"day":282.6,"min":277.85,"max":283.08,"night":279.54,"eve":280.67,"morn":277.85},"feels_like":{"day":280.81,"night":278.44,"eve":280.67,"morn":277.85},"pressure":1019,"humidity":67,"dew_point":276.69,"wind_speed":3.41,"wind_deg":53,"wind_gust":5.19,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":2,"pop":0,"uvi":1.18},{"dt":1656806400,"sunrise":1656792186,"sunset":1656824621,"moonrise":1656802200,"moonset":1656837840,"moon_phase":0.12,"temp":{"day":284.21,"min":278.5,"max":284.63,"night":280.31,"eve":281.16,"morn":278.5},"feels_like":{"day":282.96,"night":278.74,"eve":279.59,"morn":276.16},"pressure":1019,"humidity":61,"dew_point":276.83,"wind_speed":2.88,"wind_deg":252,"wind_gust":3.49,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":1.22},{"dt":1656892800,"sunrise":1656878573,"sunset":1656911055,"moonrise":1656890040,"moonset":1656928200,"moon_phase":0.15,"temp":{"day":283.6,"min":278.56,"max":286.17,"night":280.73,"eve":282.67,"morn":278.56},"feels_like":{"day":282.29,"night":280.73,"eve":282.42,"morn":278.56},"pressure":1022,"humidity":61,"dew_point":276.24,"wind_speed":2.85,"wind_deg":265,"wind_gust":4.44,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":48,"pop":0,"uvi":2},{"dt":1656979200,"sunrise":1656964958,"sunset":1656997490,"moonrise":1656977760,"moonset":1657018500,"moon_phase":0.18,"temp":{"day":283.04,"min":279.79,"max":284.44,"night":281.55,"eve":282.26,"morn":279.79},"feels_like":{"day":283.04,"night":280.01,"eve":281.02,"morn":278.84},"pressure":1019,"humidity":67,"dew_point":277.17,"wind_speed":2.92,"wind_deg":42,"wind_gust":4.7,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0,"uvi":2},{"dt":1657065600,"sunrise":1657051341,"sunset":1657083927,"moonrise":1657065360,"moonset":0,"moon_phase":0.21,"temp":{"day":282.54,"min":278.52,"max":282.73,"night":278.52,"eve":279.78,"morn":280.82},"feels_like":{"day":279.85,"night":276.39,"eve":278.15,"morn":278.4},"pressure":1029,"humidity":62,"dew_point":275.5,"wind_speed":5.33,"wind_deg":223,"wind_gust":9.53,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":80,"pop":0.34,"rain":0.18,"uvi":2},{"dt":1657152000,"sunrise":1657137722,"sunset":1657170365,"moonrise":1657152960,"moonset":1657108920,"moon_phase":0.25,"temp":{"day":281.02,"min":277.21,"max":281.69,"night":279.26,"eve":279.33,"morn":277.21},"feels_like":{"day":279.42,"night":276.76,"eve":276.8,"morn":276.22},"pressure":1031,"humidity":67,"dew_point":275.2,"wind_speed":3.52,"wind_deg":62,"wind_gust":5.11,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":7,"pop":0,"uvi":2}],"alerts":[{"sender_name":"Meteorological Service of New Zealand Limited","event":"wind","start":1656550800,"end":1656572400,"description":"Northwest winds may approach severe gale force in exposed places.","tags":["Wind"]}]}',
          ) as Map<String, dynamic>,
          city: const City(name: 'Christchurch'),
        ).fullWeather;

        expect(
          fullWeather.currentDayForecast,
          fullWeather.dailyForecasts[0],
        );
      });
    });

    group('changeUnitSystem', () {
      const city = City(name: 'Philadelphia');

      final currentDateTime = DateTime.now();

      // I know the values are nonsense, just ignore it.

      // TODO: figure out how to better explain this.
      // Why is this a function? Well, because floating-point error.
      // Specifically in this case, if you convert the wind speed from km/h to
      // mph and then back to km/h, you won't necessarily get the same value.
      // See the usages of this function below.
      FullWeather getMetricWeather({required double windSpeed}) => FullWeather(
            unitSystem: UnitSystem.metric,
            city: city,
            timeZoneOffset: Duration.zero,
            currentWeather: Weather(
              unitSystem: UnitSystem.metric,
              date: currentDateTime,
              clouds: 30,
              condition: 800,
              description: 'Cloudy',
              humidity: 45,
              iconCode: '01n',
              pressure: 1013,
              tempFeel: 30,
              temperature: 32,
              uvIndex: 0.5,
              windSpeed: windSpeed,
            ),
            dailyForecasts: [
              DailyForecast(
                unitSystem: UnitSystem.metric,
                date: currentDateTime.add(const Duration(days: 1)),
                iconCode: '10d',
                minTemperature: 25,
                maxTemperature: 34,
                pop: 0.42,
                sunrise: currentDateTime.add(const Duration(hours: 24 - 8)),
                sunset: currentDateTime.add(const Duration(hours: 24 + 8)),
              ),
            ],
            hourlyForecasts: [
              HourlyForecast(
                unitSystem: UnitSystem.metric,
                date: currentDateTime.add(const Duration(hours: 2)),
                iconCode: '04n',
                pop: 0.1,
                temperature: 26,
              ),
            ],
          );

      // TODO: re-write this to use `copyWith` when we have that (e.g. when/if
      // we start using Freezed).

      final imperialWeather = FullWeather(
        unitSystem: UnitSystem.imperial,
        city: city,
        timeZoneOffset: Duration.zero,
        currentWeather: Weather(
          unitSystem: UnitSystem.imperial,
          date: currentDateTime,
          clouds: 30,
          condition: 800,
          description: 'Cloudy',
          humidity: 45,
          iconCode: '01n',
          pressure: 1013,
          tempFeel: 86,
          temperature: 89.6,
          uvIndex: 0.5,
          windSpeed: 0.621371,
        ),
        dailyForecasts: [
          DailyForecast(
            unitSystem: UnitSystem.imperial,
            date: currentDateTime.add(const Duration(days: 1)),
            iconCode: '10d',
            minTemperature: 77,
            maxTemperature: 93.2,
            pop: 0.42,
            sunrise: currentDateTime.add(const Duration(hours: 24 - 8)),
            sunset: currentDateTime.add(const Duration(hours: 24 + 8)),
          ),
        ],
        hourlyForecasts: [
          HourlyForecast(
            unitSystem: UnitSystem.imperial,
            date: currentDateTime.add(const Duration(hours: 2)),
            iconCode: '04n',
            pop: 0.1,
            temperature: 78.8,
          ),
        ],
      );

      test('from metric to imperial', () {
        expect(
          getMetricWeather(windSpeed: 1).changeUnitSystem(UnitSystem.imperial),
          imperialWeather,
        );
      });

      test('from imperial to metric', () {
        expect(
          imperialWeather.changeUnitSystem(UnitSystem.metric),
          // Theoretically the wind speed should be 1, but floating-point
          // inaccuracies. :/
          // See the comment above`getMetricWeather`.
          getMetricWeather(windSpeed: 0.9999996906240001),
        );
      });

      test('from metric to metric', () {
        expect(
          getMetricWeather(windSpeed: 1).changeUnitSystem(UnitSystem.metric),
          getMetricWeather(windSpeed: 1),
        );
      });

      test('from imperial to imperial', () {
        expect(
          imperialWeather.changeUnitSystem(UnitSystem.imperial),
          imperialWeather,
        );
      });
    });
  });
}
