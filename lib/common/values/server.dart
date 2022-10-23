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
  static const String serverUrl = "https://api.enjoyfujitech.com/";
  static const String invite =
      'https://invite.enjoyfujitech.com/invite/index.html#/invite';
  //// prod-scope-end

//https://jvf9eoi39e.execute-api.us-west-2.amazonaws.com/
//https://api.enjoyfujitech.com/

  static const String baseUrl = '${Server.serverUrl}';
}
