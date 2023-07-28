export class Settings {
	public readonly port: number;
	public readonly background: string;

	public constructor(port: number, background: string) {
		this.background = background;
		this.port = port;
	}
}
