import js.vue.Vue;
//import vue.macro.Builder;
//import TestComponent;

class Component extends Vue<Dynamic> {

  function click(e) {
    trace(this);
  }

  public function new(config) {
    config.methods = untyped {};
    config.methods.click = click;
    super(config);
  }

}


class Test {

  static function main() {
    new Component(untyped {
      el: '#demo',
      template:'
        <div id="demo" @click="click">
          <p>{{message}}</p>
          <input v-model="message">
        </div>
      ',
      data: {
        message: 'Hello Vue.js!'
      }
    });
  }
}
