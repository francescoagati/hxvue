package a.b;

@:keep
@:build(vue.macro.builder.Component.build())
@:name("my-component")
@:template("
  <div v-on:click='increment'>{{counter}}</div>
")
class Foo extends js.vue.Vue<{counter:Int}>  {

  static var data_init = {counter:0};

  @:bind function increment(e) {
    data.counter = data.counter + 1;
  }


}
