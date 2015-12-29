import js.vue.Vue;

typedef Data = {a:Int};


@:el("#demo")
@:template('ddeeeeddd')
class TestComponent extends vue.macro.Component<Data> {

  @:bind function click(e) {}
  @:computed function sum() return untyped vue.a + 1;
  @:watch("a.b.c",{immediate:true}) function pippa(old,new_value) {}

  public inline function new(data) {
    super(data);
    initialize(data);
  }


}
