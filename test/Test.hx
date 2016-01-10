import js.vue.Vue;
//import vue.macro.builder.Component;
import a.b.Foo;
//import vue.macro.Builder;
//import TestComponent;
/*

typedef Data = {
  b:Bool,
  a:Int,
  list:Array<Int>
}

class ComponentBase<T> extends Vue<T> implements vue.macro.IComponent<T> {


  function click(e) {
    trace(this);
  }


}

@:el("#demo")
@:template('

  <div class="container" @click="click2">
    <pippa></pippa>
    <div
      class="well  animated"
      v-show="b"
      transition="fade"
      v-for="el in list" track-by="$index">{{el}}</div>
  </div>


')
class ComponentA  extends ComponentBase<Data> {

  @:bind function click2(e:js.html.Event) {
    data.list = [for (el in data.list) el+1];
  }

  @:watch("a.b.c") function pippa2(old,new_value) {}
  @:watch("a.b.c",{immediate:true}) function pippa(old,new_value) {}

  public function new(data) {
    var vue_config = untyped get_vue_config(data);
    vue_config.transition = {};
    //trace(vue_config);
    //config.methods = untyped {};
    //config.methods.click = click;
    //config.methods.click2 = click2;
    //click(2);

    super(vue_config);
    var timer = new haxe.Timer(1000);
    timer.run = function() {
      this.data.b = true;
      untyped this.data.a = this.data.a+1;
    }
  }
}

@:keep
@:template('
  <span>HELLO</span>
')
class ComponentB  extends Vue<Dynamic> implements vue.macro.IComponent<Dynamic> {
  public function new(data) {
    var vue_config = get_vue_config(data);
    super(vue_config);
  }
}
*/


class A extends js.vue.Vue<Dynamic> {

  public function new() {
    var properties = {
      el: '#demo',
      template:"
        <div>{{a+2}}</div>
        <div>
            <my-pippa></my-pippa>
        </div>
      ",
      data: {a:1}
    };
    super(properties);
  }
}

@:keep
class B extends js.vue.Vue<{b:Int}> {

  public function click(e) {
    data.b = data.b + 1;
  }
  public static var template = '
    <div v-on:click="click">{{b+1}}</div>
  ';

  public static var data_init:Dynamic = untyped {b:2};

}


class Test {

  static function main() {
    js.vue.Vue.component('my-pippa',Vue.extend({
      data:untyped function() return  B.data_init,
      template:B.template,
      methods:{
        click:untyped B.prototype.click
      }
    }));
    new A();
/*
            Vue.transition('fade', {
              css: false,
              enter: function (el, done) {
                untyped $(el).addClass('slideInUp');
                done();
              },
              enterCancelled: function (el) {
                untyped $(el).stop();
              },
              leave: function (el, done) {
                untyped $(el).addClass('slideOutUp');
                done();              },
              leaveCancelled: function (el) {
                untyped $(el).stop();
              }
            });
*/

/*    Vue.component('pippa',ComponentB);
    new ComponentA({b:false,a:1,list:[1,2,3,4,5,6,7,8,9,10]});
*/


  }
}
