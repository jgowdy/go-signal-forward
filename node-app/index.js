var segfault_handler = require('segfault-handler');
var addon = require('addon');
segfault_handler.registerHandler("crash.log");
console.log(addon.add(1, 2));
segfault_handler.causeSegfault(); // Simulate a crash
