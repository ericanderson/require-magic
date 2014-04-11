# What is this?

Provides a means to load up modules that declare they implement some interface, as represented by a URI.

See [the first example](examples/first/) to understand.

# Example

You have a ton of widgets. You want to include them all in your app. Rather than declaring each one every time you add a new one,
you could use this plugin to define a magic.json file like so in one of your modules (written by you or pulled from bower)

```json
{
	"com.foo.widget": ["bar", "merp"]
}
```

and then you could get an array of those very require modules when you:

```javascript
require("magic!com.foo.widget", function(widgets){
	alert(widgets.length == 2);
})
```