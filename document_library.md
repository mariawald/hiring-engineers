#Introducing the node-dogstatsd library for Datadog

This library is a node.js client that implements the protocol DogStatsD. It enables you to send custom metrics into Datadog through the installed agent. Some of the benefits this library offers:

* It's easy to use and configure.
* It's compatible with old node versions.
* Supports datadog's histogram and tags features.

Learn more about the DogStatsD [here] (https://docs.datadoghq.com/developers/dogstatsd/).


##Installation

```Shell
$ npm install node-dogstatsd
```

##Usage

1. Import the StatsD class from the library:

	```JavaScript
	var StatsD = require('node-dogstatsd').StatsD
	
	```
2. Create a new client object using `StatsD`.

	You can use 4 paramenters:

	
	Parameter  | Definition
	------------- | -------------
	`host`  | Host where your Datadog agent is running. `localhost` is used by default
	`port`  | Port your Datadog agent is listening to. `8125` is used by default
	`socket`  | Optionally, you can provide a socket for the client to use. If you don't pass it, the client creates one internally.
	`options`  | Use `options` to specify a list of global task that are sent with each event by setting `options.global_tag` property to an array of tags


	**Example 1:**
	
	```JavaScript
	var client = new StatsD();
	
	```
	**Example 2:**
	
	```JavaScript
	var client = new StatsD('my-datadog-agent.myorg.com', 8125);
	
	```	
	**Example 3:**
	
	```JavaScript
	var options = {
		global_tags = ['global-tag-1:value1', 'global-tag2:value2']
	};
	
	var client = new StatsD('example.org', 8125, mySocket, options);
	
	```
3. Use your client to send your metrics. 

	Metric   | Examples
	----------------|--------------------------
	Increment a counter by 1| `client.increment('users.logins');`
	Increment a counter by a given amount| `client.incrementBy('accounts.created', 7);`
	Decrement a counter by 1| `client.decrement('users.logins');`
	Decrement a counter by a given amount| `client.decrementBy('accounts.created', 4);`
	Record a timing data point in milliseconds| `client.timing('page.load, 500');`
	Record an histogram data point | `client.timing('user.age', 31);`
	Record a set element | `client.set('order.items', 5);`

	It is posible to specify a list of tags each time you send a metric. To do so just pass them in an array of strings as the last argument.

	Examples:

	- `client.increment('users.logins', ['tag:value']);`
	- `client.decrement('users.logins', ['tag1:value1', 'tag2:value2']);`
	- `client.timing('user.age', 31, ['tag:value']);`

	_Tip: find out more about DogStatsD metrics [here] (https://docs.datadoghq.com/developers/dogstatsd/data_types/#metrics)_ 

##Error handling

Any errors occurring in the library will surface on your code. Catch them by subscribing to the error events in the socket. The socket is available as a property of your client object.

```JavaScript
client.socket.on('error', function (exception) {
	return console.log("error event in socket.send(): " + exception);
});
```
	
##License
node-statsd is licensed under the MIT license.

##Acknowledgements

* Thanks to Mr Bar and all the contributors who have made this library posible.
* Parts of this code are based off Steve Ivy's [node-statsd] (https://docs.datadoghq.com/developers/dogstatsd).





