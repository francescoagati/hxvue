(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var A = function() {
	var properties = { el : "#demo", template : "\n        <div>{{a+2}}</div>\n        <div>\n            <my-pippa></my-pippa>\n        </div>\n      ", data : { a : 1}};
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
B.template = "\n    <div v-on:click=\"click\">{{b+1}}</div>\n  ";
B.data_init = { b : 2};
Test.main();
})(typeof console != "undefined" ? console : {log:function(){}});
