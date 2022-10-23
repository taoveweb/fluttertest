const isProd = bool.fromEnvironment('dart.vm.product');

class Server {
  ///测试
  //// test-scope-start
  // static const String serverUrl = 'https://api.testenjoyfujitech.com/';
  // static const String invite =
  // 'https://testweb.testenjoyfujitech.com/invite/index.html#/invite';
  //// test-scope-end

  ///生产
  //// prod-scope-start
  static const String serverUrl = "https://6e21-14-199-156-3.jp.ngrok.io/";

  //// prod-scope-end

//https://jvf9eoi39e.execute-api.us-west-2.amazonaws.com/
//https://api.enjoyfujitech.com/

  static const String baseUrl = '${Server.serverUrl}';
}
