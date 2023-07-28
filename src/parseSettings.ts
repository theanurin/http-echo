import { Settings } from "./settings";

export function parseSettings(args: Array<string>): Settings {
	//

	const setting = new Settings(3000, "#FF0000");
	return setting;
}
