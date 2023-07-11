import 'package:args/args.dart';

import 'settings.dart';

Settings parserSettings(final List<String> args) {
  final ArgParser parser = new ArgParser();
  parser.addOption(
    'port',
    mandatory: true,
    help: "Set Web server listen port",
  );
  parser.addOption(
    'bg-color',
    mandatory: true,
    help: "Set background color of HTML page",
  );

  try {
    final ArgResults results = parser.parse(args);

    final String portString = results['port'];
    final String background = results['bg-color'];

    final RegExp regExpPort = RegExp(r'^\d{1,5}$');
    final bool matchesArgPort = regExpPort.hasMatch(portString);
    if (!matchesArgPort) {
      throw SettingsException(
          "Wrong value '$portString' for argument --port", parser.usage);
    }

    final int port = int.parse(portString);
    if (!(port > 0 && port <= 65535)) {
      throw SettingsException(
          "The argument '--port' is not right range. Set the port to the correct range.",
          parser.usage);
    }

    final RegExp regExpBgColor = RegExp(r'^#[0-9a-fA-F]{6}$');
    final bool matchesArgBgColor = regExpBgColor.hasMatch(background);
    if (!matchesArgBgColor) {
      throw SettingsException(
          "Wrong value '$background' for argument --bg-color", parser.usage);
    }

    final Settings settings = Settings(port, background);
    return settings;
  } on ArgParserException catch (e) {
    throw SettingsException(e.message, parser.usage);
  } on ArgumentError catch (e) {
    throw SettingsException(e.message, parser.usage);
  }
}

class SettingsException extends Error {
  final String usage;
  final String message;

  SettingsException(this.message, this.usage);
}
