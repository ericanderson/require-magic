requirejs.config({
    paths: {
        magic: '../../src/magic'
    }
});
require(['magic!com.test.foo'], function(MagicFoo) {
    console.log(MagicFoo);
});