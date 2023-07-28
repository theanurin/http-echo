// npx tsc && npx mocha


const { parseSettings } = require("../src/parseSettings");

var assert = require('assert');


describe('Testing parseSettings function', function () {
	it('Test 1', function () {
		const args = ["--port", "8080", "--background", "#FF0000"];
		const settings = parseSettings(args);

		assert.equal(settings.background, "#FF0000");
		assert.equal(settings.port, 8080);
	});

	it('Test 2', function () {
		const args = ["--port", "5000", "--background", "#00FF00"];
		const settings = parseSettings(args);

		assert.equal(settings.background, "#00FF00");
		assert.equal(settings.port, 5000);
	});
});
