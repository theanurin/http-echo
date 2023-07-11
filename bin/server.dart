import "dart:async" show Future;
import "dart:convert" show JsonEncoder;
import "dart:io"
    show
        ContentType,
        HttpConnectionInfo,
        InternetAddress,
        Platform,
        ProcessSignal,
        exit;
import "package:shelf/shelf.dart"
    show MiddlewareExtensions, Request, Response, logRequests;
import "package:shelf/shelf_io.dart" as shelf_io;

import "package:echo/args_parser.dart" show SettingsException, parserSettings;
import "package:echo/settings.dart" show Settings;

Settings? mySettings;

Future<void> gracefulShutdown(signal) async {
  print("Got a kill signal. Trying to exit gracefully.");
  exit(0);
}

Future<void> main(final List<String> args) async {
  ProcessSignal.sigint.watch().listen(gracefulShutdown);
  ProcessSignal.sigterm.watch().listen(gracefulShutdown);

  try {
    mySettings = parserSettings(args);
  } on SettingsException catch (e) {
    print(e.message);
    print("");
    print("To use this application you should use following options:");
    print(e.usage);
    exit(1);
  }

  // See https://pub.dev/documentation/shelf/latest/shelf_io/serve.html
  final server = await shelf_io.serve(
    logRequests().addHandler(_handler),
    InternetAddress.anyIPv4, // Allows external connections
    mySettings!.port,
  );

  print("");
  print("HTTP Echo Service");
  print("");
  print(
      "Using custom background color for HTML page: http://${server.address.host}");
  print("");
  print("Listening for incoming HTTP requests on a port ${server.port}");
  print("");
}

bool resolveHtmlRequested(String? acceptHeaderValue) {
  if (acceptHeaderValue != null) {
    final List<String> acceptArray = acceptHeaderValue.split(",");
    for (int index = 0; index < acceptArray.length; index++) {
      if (acceptArray[index] == "text/html") {
        return true;
      }
    }
  }
  return false;
}

Future<Response> _handler(Request request) async {
  final HttpConnectionInfo? httpConnInfo =
      request.context["shelf.io.connection_info"] as HttpConnectionInfo?;

  final String hostname = Platform.localHostname;

  final String body = await request.readAsString();

  final Map dataRaw = {
    "path": request.requestedUri.path,
    "headers": request.headers,
    "method": request.method,
    "body": body,
    "hostname": request.requestedUri.host,
    "protocol": request.requestedUri.scheme,
    "protocolVersion": request.protocolVersion,
    "query": request.requestedUri.queryParameters,
    "os": {"hostname": hostname},
  };

  if (httpConnInfo != null) {
    dataRaw["client"] = {
      "localPort": httpConnInfo.localPort,
      "remoteAddress": httpConnInfo.remoteAddress.address,
      "remotePort": httpConnInfo.remotePort,
    };
  }

  final dataJson = JsonEncoder.withIndent(" " * 4).convert(dataRaw);

  final bool isHtmlRequested = resolveHtmlRequested(request.headers["Accept"]);

  String parserBgColor = mySettings!.background;

  String data;
  ContentType contentType;
  if (isHtmlRequested) {
    contentType = ContentType("text", "html");
    data = '<html><body style="background-color:${parserBgColor}">' +
        '<pre style="word-wrap: break-word; white-space: pre-wrap;"> ${dataJson}' +
        '</pre></body></html>';
  } else {
    contentType = ContentType("application", "json", charset: "utf-8");
    data = dataJson;
  }

  return Response.ok(
    data,
    headers: {
      "Content-Type": contentType.toString(),
      "Cache-Control": "no-cache"
    },
  );
}
