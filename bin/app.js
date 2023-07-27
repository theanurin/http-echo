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
const shutdownSignals = Object.freeze(["SIGTERM", "SIGINT"]);

async function gracefulShutdown(signal) {
	process.exit(0);
}
shutdownSignals.forEach((signal) => process.on(signal, () => gracefulShutdown(signal)));

