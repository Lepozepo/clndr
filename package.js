Package.describe({
	name:"lepozepo:clndr",
	summary: "A better date picker / calendar interface",
	version:"1.0.0",
	git:"https://github.com/Lepozepo/clndr"
});

Package.on_use(function (api) {
	api.use(["underscore@1.0.0","coffeescript@1.0.0"], "client");
	api.use(["mrt:moment@2.8.1"], ["client","server"]);
	api.use(["ui@1.0.0","templating@1.0.0","spacebars@1.0.0","reactive-var@1.0.3","reactive-dict@1.0.0"], "client");

	// Client
	api.add_files("client/helpers.coffee", "client");
	api.add_files("client/clndr.coffee", "client");
});
