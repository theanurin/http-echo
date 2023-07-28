require("../src/index.js");




// const express = require('express');
// const app = express();
// const PORT = 3000;
 
// app.get('/', function (req, res) {
//     console.log(req.get('Accept'));
//     console.log(req.accepts('text/plain'));
//     res.end();
// });
 
// app.listen(PORT, function (err) {
//     if (err) console.log(err);
//     console.log("Server listening on PORT", PORT);
// });

async function gracefulShutdown(signal) {
	console.log('Got a kill signal. Trying to exit gracefully.');
	process.exit(0);
}

process.on('SIGINT', gracefulShutdown);
process.on('SIGTERM', gracefulShutdown);
