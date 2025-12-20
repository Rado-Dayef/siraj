import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_numkit/flutter_numkit.dart';

class ImageCacheManager extends CacheManager {
  static const key = "imageCache";

  ImageCacheManager._() : super(Config(key, maxNrOfCacheObjects: 200, stalePeriod: (365 * 10).days));

  static final ImageCacheManager instance = ImageCacheManager._();
}
