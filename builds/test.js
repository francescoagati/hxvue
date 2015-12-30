(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var vue_macro_IComponent = function() { };
var ComponentBase = function(options) {
	Vue.call(this,options);
};
ComponentBase.__interfaces__ = [vue_macro_IComponent];
ComponentBase.__super__ = Vue;
ComponentBase.prototype = $extend(Vue.prototype,{
});
var ComponentA = function(data) {
	var _g = this;
	var vue_config = (function($this) {
		var $r;
		var methods = { };
		methods.click2 = $bind($this,$this.click2);
		var computed = { };
		var watched = { };
		{
			watched["a.b.c"] = { };
			watched["a.b.c"].handler = $bind($this,$this.pippa2);
			watched["a.b.c"] = { immediate : true};
			watched["a.b.c"].handler = $bind($this,$this.pippa);
		}
		$r = { el : "#demo", template : "<div class=\"container\" @click=\"click2\">    <div      class=\"well  animated\"      v-show=\"b\"      transition=\"fade\"      v-for=\"el in list\" track-by=\"$index\">{{el}}</div>  </div>", data : data, methods : methods, computed : computed, watched : watched};
		return $r;
	}(this));
	vue_config.transition = { };
	ComponentBase.call(this,vue_config);
	var timer = new haxe_Timer(1000);
	timer.run = function() {
		_g.$data.b = true;
		_g.$data.a = _g.$data.a + 1;
	};
};
ComponentA.__super__ = ComponentBase;
ComponentA.prototype = $extend(ComponentBase.prototype,{
	click2: function(e) {
		var tmp;
		var _g = [];
		var _g1 = 0;
		var _g2 = this.$data.list;
		while(_g1 < _g2.length) {
			var el = _g2[_g1];
			++_g1;
			_g.push(el + 1);
		}
		tmp = _g;
		this.$data.list = tmp;
	}
	,pippa2: function(old,new_value) {
	}
	,pippa: function(old,new_value) {
	}
});
var Test = function() { };
Test.main = function() {
	Vue.transition("fade",{ css : false, enter : function(el,done) {
		$(el).addClass("slideInUp");
		done();
	}, enterCancelled : function(el1) {
		$(el1).stop();
	}, leave : function(el2,done1) {
		$(el2).addClass("slideOutUp");
		done1();
	}, leaveCancelled : function(el3) {
		$(el3).stop();
	}});
	new ComponentA({ b : false, a : 1, list : [1,2,3,4,5,6,7,8,9,10]});
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.prototype = {
	run: function() {
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
Test.main();
})(typeof console != "undefined" ? console : {log:function(){}});
