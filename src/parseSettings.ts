import { stringify } from "node:querystring";
import { Settings } from "./settings";
import { error } from "node:console";
import { ParseArgsConfig, parseArgs } from 'node:util';

// export function parseSettings(args: Array<string>): Settings {
// 	//

// 	const setting = new Settings(3000, "#FF0000");
// 	return setting;
// }

// export function parseSettings(args: Array<string>): Settings {
// 	//
// 	let port: number | null = null;
// 	let background: string | null = null;

// 	const argsLength: number = args.length;
// 	for (let index: number = 0; index < argsLength; index++) {
// 		const currentArg: string = args[index];
// 		if (currentArg === "--port") {
// 			const nextIndex: number = index + 1;
// 			if (nextIndex >= argsLength) {
// 				throw new ArgParserException(
// 					"No value specified for --port",
// 				);
// 			}
// 			const nextArg: string = args[index + 1];
// 			index++;

// 			let regExpPort: RegExp = new RegExp('^[0-9]{1,5}$');
// 			let matchersArgPort: boolean = regExpPort.test(nextArg);
// 			if (!matchersArgPort) {
// 				throw new ArgParserException(`Wrong value ${nextArg} for argument --port`,
// 				);
// 			}

// 			port = Number.parseInt(nextArg, 10);
// 			if (!(port > 0 && port <= 65535)) {
// 				throw new ArgParserException(
// 					"The argument '--port' is not right range. Set the port to the correct range",
// 				);
// 			}
// 		}
// 		if (currentArg === "--bg-color") {
// 			const nextIndex: number = index + 1;
// 			if (nextIndex >= argsLength) {
// 				throw new ArgParserException(
// 					"No value specified for --bg-color",
// 				);
// 			}
// 			const nextArg = args[nextIndex];
// 			index++;

// 			let regExpBgColor: RegExp = new RegExp('^#[0-9a-fA-F]{6}$');
// 			let matchersArgPort: boolean = regExpBgColor.test(nextArg);
// 			if (!matchersArgPort) {
// 				throw new ArgParserException(`Wrong value ${nextArg} for argument --port`,
// 				);
// 			}
// 			background = nextArg;
// 		}
// 	}

// 	if (argsLength === 0) {
// 		throw new ArgParserException(
// 			"You didn't pass any arguments",
// 		);
// 	}

// 	if (port === null) {
// 		throw new ArgParserException(
// 			"No values specified for argument '--port'",
// 		);
// 	}

// 	if (background === null) {
// 		throw new ArgParserException(
// 			"No values specified for argument '--bg-color'",
// 		);
// 	}


// 	const setting = new Settings(port, background);
// 	return setting;
// }
export function parseSettings2(args: Array<string>): Settings {
	const parseConfig: ParseArgsConfig = {
		args,
		strict: true,
		options: {
			"port": {
				type: 'string',
				short: 'p',
			},
			"bg-color": {
				type: 'string',
				short: 'p',
			},
		}
	};
	try {
	const { values } = parseArgs(parseConfig);

	const portRaw = values["port"];
	const backgroundRaw = values["bg-color"];

	if (typeof portRaw !== "string") {
		throw new ArgParserException(
			"Bad type value specified for argument '--port'",
		);
	}

	if (typeof backgroundRaw !== "string") {
		throw new ArgParserException(
			"Bad type value specified for argument '--bg-color'",
		);
	}

	const port: number | null = Number.parseInt(portRaw);
	const background: string = backgroundRaw;

		let regExpPort: RegExp = new RegExp('^[0-9]{1,5}$');
		let matchersArgPort: boolean = regExpPort.test(portRaw);
		if (!matchersArgPort) {
			throw new ArgParserException(
				`Wrong value ${portRaw} for argument --port`,
			);
		}

		// const port: number = Number.parseInt(portRaw, 10);
		if (!(port > 0 && port <= 65535)) {
			throw new ArgParserException(
				"The argument '--port' is not right range. Set the port to the correct range",
			);
		}

		let regExpBgColor: RegExp = new RegExp('^#[0-9a-fA-F]{6}$');
		let matchersArgBgColor: boolean = regExpBgColor.test(backgroundRaw);
		if (!matchersArgBgColor) {
			throw new ArgParserException(`Wrong value ${backgroundRaw} for argument --bg-color`,
			);
		}

		const setting = new Settings(port, background);
		return setting;
	} catch {
		throw new ArgParserException("bbbt");
	}
}

export class ArgParserException extends Error {
	public readonly usage: string;

constructor(
	message: string,

) {
	super(message);

	this.usage = "--port (mandatory),    Set Web server listen port --bg-color (mandatory)    Set background color of HTML page"
}
}

// 	constructor(
// 		message: string,
// 		usage: string = "--port (mandatory),    Set Web server listen port --bg-color (mandatory)    Set background color of HTML page"
// 	) {
// 		super(message);

// 		this.usage = usage;
// 	}
// }
