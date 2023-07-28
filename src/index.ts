import expressModule, { Express, Request, Response, NextFunction } from 'express';
import concat from 'concat-stream';
import os from 'node:os';
import morgan from 'morgan';

import { Settings } from "./settings";
import { parseSettings } from "./parseSettings";



const mySettings: Settings = parseSettings(process.argv.splice(2));

const app: Express = expressModule();

// const args: string [] = process.argv;
// console.log(args);

// const options: {
// 	: {

// 	}
// }

// print('Serving at http://${server.address.host}:${server.port}');
console.log(
	'   _   _   _____   _____   ____      _____   ____    _   _    ___  \n',
	' | | | | |_   _| |_   _| |  _ \\    |____|  /____|  | | | | /  _  \\  \n',
	' | |_| |   | |     | |   | |_) |   |  _|   | |     | |_| | | | | |  \n',
	' |  _  |   | |     | |   |  __/    | |___  | |___  |  _  | | |_| |  \n',
	' |_| |_|   |_|     |_|   |_|       |_____|  \\____| |_| |_|  \\___/   \n'
);
console.log('HTTP Echo Service v1.0.0');
console.log('');
console.log('Using custom background color for HTML page: http://${server.address.host}');
console.log('');
console.log('Listening for incoming HTTP requests on a port ${server.port}');
console.log('');

function resolveHtmlRequested(acceptHeaderValue: string | undefined): boolean {
	if (acceptHeaderValue !== undefined) {
		let acceptArray: string[] = acceptHeaderValue.split(",");
		for (let i = 0; i < acceptArray.length; i++) {
			if (acceptArray[i] === "text/html") {
				return true;
			}
		}
		return false;
	} else {
		return false;
	}
}
app.use(function (req: Request, res: Response, next: NextFunction) {
	req.pipe(concat(function (data: Buffer): void {
		req.body = data.toString('utf8');
		next();
	}));
});



app.all('*', function (req: Request, res: Response) {
	const resultData: any = {
		path: req.path,
		headers: req.headers,
		method: req.method,
		body: req.body,
		fresh: req.fresh,
		hostname: req.hostname,
		ip: req.ip,
		protocol: req.protocol,
		httpVersion: req.httpVersion,
		query: req.query,
		os: {
			hostname: os.hostname()
		},
		client: {
			localPort: req.socket.localPort,
			remoteAddress: req.socket.remoteAddress,
			remotePort: req.socket.remotePort,
		}
	};

	const isHtmlRequested: boolean = resolveHtmlRequested(req.headers["accept"]);

	const resultDataStr: string = JSON.stringify(resultData, null, '\t');
	if (isHtmlRequested === false) {
		res.appendHeader("Content-Type", "application/json");
		res.send(resultDataStr);
	} else {
		res.appendHeader("Content-Type", "text/html");
		res.send('<html><body><pre style="background-color:red; word-wrap: break-word; white-space: pre-wrap;">' + resultDataStr + "</pre></body></html>");
	}

})

app.listen(mySettings.port)

// args.forEach((value:string,index:number) => {
// 	console.log(`${index} -> ${value})
// });
