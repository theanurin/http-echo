import 'package:test/test.dart';

import '../lib/args_parser.dart';
import '../lib/settings.dart';

void main() {
  final parserArgsFunc = parserSettings;

  group('Positive', () {
    test('--bg-color #ff0000 --port 8080', () {
      final List<String> args = ["--bg-color", "#ff0000", "--port", "8080"];
      final Settings mySettings = parserArgsFunc(args);
      expect(mySettings.background, equals("#ff0000"));
      expect(mySettings.port, equals(8080));
    });

    test('--port 8080 --bg-color #ff0000', () {
      final List<String> args = ["--port", "8080", "--bg-color", "#ff0000"];
      final Settings mySettings = parserArgsFunc(args);
      expect(mySettings.background, equals("#ff0000"));
      expect(mySettings.port, equals(8080));
    });

    test('--port 8081 --bg-color #ff0000', () {
      final List<String> args = ["--port", "8081", "--bg-color", "#ff0000"];
      final Settings mySettings = parserArgsFunc(args);
      expect(mySettings.background, equals("#ff0000"));
      expect(mySettings.port, equals(8081));
    });

    test('--port 8080 --bg-color #ff00ff', () {
      final List<String> args = ["--port", "8080", "--bg-color", "#ff00ff"];
      final Settings mySettings = parserArgsFunc(args);
      expect(mySettings.background, equals("#ff00ff"));
      expect(mySettings.port, equals(8080));
    });
  });

  group('Negative', () {
    test('--port #ff0000 --bg-color 8080', () {
      final List<String> args = ["--port", "#ff0000", "--bg-color", "8080"];

      Object? testException = null;
      try {
        parserArgsFunc(args);
      } catch (ex) {
        testException = ex;
      }

      if (testException == null) {
        fail("parserArgsFunc does not raise exception while should raise");
      }

      expect(testException, isA<SettingsException>());
      final SettingsException friendlyEx = testException as SettingsException;
      expect(
        friendlyEx.message,
        equals("Wrong value '#ff0000' for argument --port"),
      );
    });
  });

  test('--port 8080 --bg-color qwq', () {
    final List<String> args = ["--port", "8080", "--bg-color", "qwq"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals("Wrong value 'qwq' for argument --bg-color"),
    );
  });

  test('--port --bg-color --bg-color #ff0000', () {
    final List<String> args = ["--port", "--bg-color", "--bg-color", "#ff0000"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals("Wrong value '--bg-color' for argument --port"),
    );
  });

  test('--port 8080 --bg-color', () {
    final List<String> args = ["--port", "8080", "--bg-color"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Missing argument for "bg-color".'),
    );
  });

  test('--bg-color #ff0000 port', () {
    final List<String> args = ["--bg-color", "#ff0000", "--port"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Missing argument for "port".'),
    );
  });

  test('--bg-color #ff0000', () {
    final List<String> args = ["--bg-color", "#ff0000"];
    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Option port is mandatory.'),
    );
  });

  test('--port 8080', () {
    final List<String> args = ["--port", "8080"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Option bg-color is mandatory.'),
    );
  });

  test('8080, #ff0000', () {
    final List<String> args = ["8080", "#ff0000"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Option port is mandatory.'),
    );
  });

  test('--port, 8080, #ff0000', () {
    final List<String> args = ["--port", "8080", "#ff0000"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Option bg-color is mandatory.'),
    );
  });

  test('--port, 66636, --bg-color, #ff0000', () {
    final List<String> args = ["--port", "66636", "--bg-color", "#ff0000"];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }

    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals(
          "The argument '--port' is not right range. Set the port to the correct range."),
    );
  });

  test('isEmpty example', () {
    final List<String> args = [];

    Object? testException = null;
    try {
      parserArgsFunc(args);
    } catch (ex) {
      testException = ex;
    }

    if (testException == null) {
      fail("parserArgsFunc does not raise exception while should raise");
    }
    expect(args, isEmpty);
    expect(testException, isA<SettingsException>());
    final SettingsException friendlyEx = testException as SettingsException;
    expect(
      friendlyEx.message,
      equals('Option port is mandatory.'),
    );
  });
}
