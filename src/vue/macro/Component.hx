package vue.macro;

class Component<T> implements IComponent<T> {
  public var vue:js.vue.Vue<T> = null;

  public function new(data:T) {}

}
