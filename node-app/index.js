var bad_stack_trace = process.env.BAD_STACK_TRACE.toLocaleLowerCase() === 'true' || process.env.BAD_STACK_TRACE === '1';

if (bad_stack_trace) {
    var segfault_handler = require('segfault-handler');
    function handleSegfault() {
        console.error('\nSegfault handler\n');
        console.dir(arguments);
        console.error('\n');
        process.exit(1);
    }
    segfault_handler.registerHandler(handleSegfault);
    var addon = require('addon');
    console.log("Result: " + addon.add(1, 2) + "\n\n");
    segfault_handler.causeSegfault(); // Simulate a crash
} else {
    var addon = require('addon');
    console.log("Result: " + addon.add(1, 2) + "\n\n");
    var segfault_handler = require('segfault-handler');
    function handleSegfault() {
        console.error('\nSegfault handler\n');
        console.dir(arguments);
        console.error('\n');
        process.exit(1);
    }
    segfault_handler.registerHandler(handleSegfault);
    segfault_handler.causeSegfault(); // Simulate a crash
}
