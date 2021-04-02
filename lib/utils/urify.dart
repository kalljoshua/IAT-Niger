class Urify {
  String basePath;

  Urify(String basePath) {
    this.basePath = basePath;
  }

  Uri getUri(String path) {
    String policy = getPolicy(basePath);
    return _parseToUri(policy, path);
  }

  Uri _parseToUri(String policy, String path) {
    String domain = basePath.substring(basePath.lastIndexOf("/") + 1);
    if (policy == "https") {
      return Uri.https(domain, path);
    }
    return Uri.http(domain, path);
  }

  Uri getUriWithParams(String path, Map<String, dynamic> data) {
    String policy = getPolicy(basePath);
    return _parseToUriWithParams(policy, path, data);
  }

  Uri _parseToUriWithParams(
      String policy, String path, Map<String, dynamic> data) {
    String domain = basePath.substring(basePath.lastIndexOf("/") + 1);
    if (policy == "https") {
      return Uri.https(domain, path, data);
    }
    return Uri.http(domain, path, data);
  }

  String getPolicy(String basePath) {
    return _getPath(basePath);
  }

  String _getPath(String baseApi) {
    if (baseApi == '') {
      throw new Exception('Base path cannot be empty');
    }
    List splits = baseApi.split(":");
    if (splits.length < 1) {
      throw new Exception('No policy provided');
    }

    String policy = splits[0];

    if (policy != "http" || policy != "https") {
      return policy;
    } else {
      throw new Exception('Invalid policy provided');
    }
  }
}
