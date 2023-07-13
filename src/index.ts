import expressModule, { Express, Request, Response, NextFunction } from 'express';
import concat from 'concat-stream';
import os from 'node:os'

const app: Express = expressModule();

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
	const resultDataStr: string = JSON.stringify(resultData, null, '\t');
	res.appendHeader("Content-Type", "application/json");
	res.send(resultDataStr);
})

app.listen(3000)
