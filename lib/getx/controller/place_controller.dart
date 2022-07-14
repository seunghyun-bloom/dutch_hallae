import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/utilities/secret_keys.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

const String naverApiPrefix = 'https://openapi.naver.com/v1/search/local.json';
const String kakaoApiPrefix =
    'https://dapi.kakao.com/v2/local/geo/transcoord.json';

class PlaceController extends GetxController {
  // variables
  RxString title = ''.obs;
  RxString mapx = ''.obs;
  RxString mapy = ''.obs;
  RxString address = ''.obs;
  RxString searchQuery = ''.obs;
  RxList<Map<String, String>> searchedPlaces = <Map<String, String>>[].obs;
  RxMap<String, dynamic> pickedPlace = <String, dynamic>{}.obs;

  // functions
  getData(String query, int ea) async {
    var data = await fetchData(query, ea);

    for (int i = 0; i < ea; i++) {
      String title = stringRefactor(data[i]['title']);

      searchedPlaces.add({
        'title': title,
        'address': data[i]['roadAddress'],
        'category': data[i]['category'],
        'mapx': data[i]['mapx'],
        'mapy': data[i]['mapy'],
      });
    }
  }

  pickPlace(String title, String address, String category, String mapx,
      String mapy) async {
    var coord = await katechTransfer(mapx, mapy);
    double x = coord['x'];
    double y = coord['y'];

    pickedPlace({
      'title': title,
      'address': address,
      'category': category,
      'x': x,
      'y': y,
    });

    Get.put(RecordController()).place = pickedPlace;
  }

  Future fetchData(String query, int ea) async {
    NaverConnectURL connectURL = NaverConnectURL(query: query, ea: ea);

    var res = await Dio(BaseOptions(headers: connectURL.naverApiHeader))
        .get(connectURL.url);

    return res.data['items'];
  }

  stringRefactor(String inputString) {
    String tempString = inputString.replaceAll('<b>', '');
    String outputString = tempString.replaceAll('</b>', '');
    return outputString;
  }

  katechTransfer(String mapx, String mapy) async {
    double x = double.parse(mapx);
    double y = double.parse(mapy);
    KakaoConnectURL connectURL = KakaoConnectURL(mapx: x, mapy: y);

    var res =
        await Dio(BaseOptions(headers: connectURL.apiKey)).get(connectURL.url);

    return res.data['documents'][0];
  }

  @override
  void onInit() {
    interval(
      searchQuery,
      (ctx) {
        searchedPlaces.clear();
        getData(searchQuery.value, 5);
      },
      time: const Duration(milliseconds: 500),
    );
    super.onInit();
  }
}

class NaverConnectURL {
  String query;
  int ea;

  NaverConnectURL({required this.query, this.ea = 5});

  Map<String, String> naverApiHeader = {
    'X-Naver-Client-Id': naverClientID,
    'X-Naver-Client-Secret': naverClientSecret,
  };

  String get url => '$naverApiPrefix?query=$query&start=1&display=$ea&sort=sim';
}

class KakaoConnectURL {
  double mapx;
  double mapy;

  KakaoConnectURL({required this.mapx, required this.mapy});

  Map<String, String> apiKey = {'Authorization': 'KakaoAK $kakaoRestApiKey'};

  String get url =>
      '$kakaoApiPrefix?input_coord=KTM&output_coord=WGS84&x=$mapx&y=$mapy';
}
