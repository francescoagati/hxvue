(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var A = function() {
	var properties = { el : "#demo", template : "\r\n        <div>{{a+2}}</div>\r\n        <div>\r\n            <my-pippa></my-pippa>\r\n        </div>\r\n      ", data : { a : 1}};
	Vue.call(this,properties);
};
A.__super__ = Vue;
A.prototype = $extend(Vue.prototype,{
});
var B = function(options) {
	Vue.call(this,options);
};
B.__super__ = Vue;
B.prototype = $extend(Vue.prototype,{
	click: function(e) {
		this.$data.b = this.$data.b + 1;
	}
});
var Test = function() { };
Test.main = function() {
	Vue.component("my-pippa",Vue.extend({ data : function() {
		return B.data_init;
	}, template : B.template, methods : { click : B.prototype.click}}));
	new A();
};
var a_b_Foo = function(options) {
	Vue.call(this,options);
};
a_b_Foo.__super__ = Vue;
a_b_Foo.prototype = $extend(Vue.prototype,{
	increment: function(e) {
		this.$data.counter = this.$data.counter + 1;
	}
});
var cls = a_b_Foo;
var methods = { };
methods.increment = cls.prototype.increment;
Vue.component("my-component",Vue.extend({ data : function() {
	return cls.data_init;
}, template : "<div v-on:click='increment'>{{counter}}</div>", methods : methods}));
B.template = "\r\n    <div v-on:click=\"click\">{{b+1}}</div>\r\n  ";
B.data_init = { b : 2};
a_b_Foo.data_init = { counter : 0};
Test.main();
})(typeof console != "undefined" ? console : {log:function(){}});
