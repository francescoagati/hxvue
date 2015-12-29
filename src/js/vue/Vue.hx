package js.vue;
import haxe.io.Path;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.html.HtmlElement;

/**
 * Vuejs externs
 * @author TiagoLr
 */
typedef ComponentOptions<T> = {
	data:T,
	?props: { },
	?methods: { },
	?computed: Array<EitherType<{get:Void->Dynamic,set:Dynamic->Dynamic},Void->Dynamic>>,
	
	// DOM
	?el:EitherType<String, EitherType<HtmlElement, Void->Dynamic>>,
	?template:String,
	?replace:Bool,		// only respected if the template option is also present.
	
	// Lifecycle
	?created:Void->Void,
	?beforeCompile:Void->Void,
	?compiled:Void->Void,
	?ready:Void->Void,
	?attached:Void->Void,
	?detached:Void->Void,
	?beforeDestroy:Void->Void,
	?destroyed:Void->Void,
	
	// Assets
	?directives: { },
	?elementDirectives: { },
	?filters: { },
	?components: { },
	?transitions: { },
	?partials: { },
	
	// Others
	?inherit:Bool, 		// false - Whether to inherit parent scope data.
	?events: { },
	?watch: { },
	?mixins: { },
	?name:String, 		// only respected when used in Vue.extend().
}

typedef VueConfig = {
	debug: Bool, // true, enable debug mode. 
	strict: Bool, // false,  enable strict mode. 
	prefix: String, // 'v-', attribute prefix for directives.
	delimiters: Array<String>, // ['{{', '}}'], interpolation delimiters for HTML interpolations, add 1 extra outer-most character.
	silent: Bool, // false suppress warnings?
	interpolate: Bool, // true, interpolate mustache bindings?
	async: Bool, // true, use async updates (for directives & watchers)?
	proto: Bool, // true, allow altering observed Array's prototype chain?
}
 
@:native('Vue')
extern class Vue<T> {
	
	static var config(default,null):VueConfig;
	
	@:native('$el')
	var el:HtmlElement;
	
	@:native('$data')
	var data:T;
	@:native('$options')
	var options:ComponentOptions<T>;
	@:native('$parent')
	var parent:Vue<{}>;
	@:native('$root')
	var root:Vue<{}>;
	@:native('$children')
	var children:Array<Vue<{}>>;
	@:native('$')
	var vrefs: Dynamic<Vue<Dynamic>>;
	@:native('$$')
	var velements: Dynamic;
	
	// for instances created with v-repeat only
	@:native('$index')
	var index:Int;
	@:native('$key')
	var key:String;
	@:native('$value')
	var value:Dynamic;
	//
	
	function new(options:ComponentOptions<T>);
	static function extend(options:ComponentOptions<{}>):Vue<{}>;
	static function nextTick(callback:Void->Void):Void;
	static function directive(id:String, ?definition:Dynamic):Dynamic;
	static function elementDirective(id:String, ?definition:Dynamic):Dynamic;
	static function filter(id:String, ?definition:Dynamic):Dynamic;
	static function component(id:String, ?definition:Dynamic):Dynamic;
	static function transition(id:String, ?definition:Dynamic):Dynamic;
	static function partial(id:String, ?definition:Dynamic):Dynamic;
	static function use(plugin:Dynamic, ?args:Dynamic):Void;
	static function util():Void;
	
	// Data
	@:native('$watch')
	function watch(expr:EitherType<String, Void->Dynamic>, callback:Dynamic->Dynamic->Void, ?options: { ?deep:Bool ,?immediate:Bool } ):Void;
	@:native('$get')
	function get(key:String):Dynamic;
	@:native('$set')
	function set(key:String, value:Dynamic):Void;
	@:native('$add')
	function add(key:String, value:Dynamic):Void;
	@:native('$delete')
	function delete(key:String, value:Dynamic):Void;
	@:native('$eval')
	function eval(expr:String):Dynamic;
	@:native('$interpolate')
	function interpolate(template:String):Dynamic;
	@:native('$log')
	function log(?key:String):Void;
	
	// Events
	@:native('$dispatch')
	function dispatch(event:String, ?args: { } ):Void;
	@:native('$broadcast')
	function broadcast(event:String, ?args: { } ):Void;
	@:native('$emit')
	function emit(event:String, ?args: { } ):Void;
	@:native('$on')
	function on(event:String, callback:Dynamic->Void ):Void;
	@:native('$once')
	function once(event:String, callback:Dynamic->Void ):Void;
	@:native('$off')
	function off(?event:String, ?callback:Dynamic->Void ):Void;
	
	// DOM
	@:native('$appendTo')
	function appendTo(el:EitherType<HtmlElement,String>, ?callback:Dynamic->Void):Void;
	@:native('$before')
	function before(el:EitherType<HtmlElement,String>, ?callback:Dynamic->Void):Void;
	@:native('$after')
	function after(el:EitherType<HtmlElement,String>, ?callback:Dynamic->Void):Void;
	@:native('$remove')
	function remove(?callback:Dynamic->Void):Void;
	@:native('$nextTick')
	function nextTick_(?callback:Dynamic->Void):Void;
	
	// Lifecycle
	@:native('$mount')
	function mount(?el:EitherType<HtmlElement,String>):Void;
	@:native('$destroy')
	function destroy(?remove:Bool):Void;
	@:native('$compile')
	function compile(el:HtmlElement):Void->Void;
	@:native('$addChild')
	function addChild(?options: { }, ?constructor:Void->Void->Dynamic ):Void;
	
}
