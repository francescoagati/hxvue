package vue.macro;

#if (macro || neko)
  import haxe.macro.Expr;
  import haxe.macro.Context;
  import  haxe.macro.Type;

  using thx.macro.MacroExprs;
  using thx.macro.MacroFields;
  using tink.MacroApi;
  using thx.macro.MacroTypes;
  using thx.macro.MacroClassTypes;
  using StringTools;
  using haxe.macro.MacroStringTools;
  using haxe.macro.ExprTools;
#end

class Builder {

  #if macro
 static function get_one_param(cls: Null<haxe.macro.Ref<haxe.macro.ClassType>>,meta:String) {
    return try {
      cls.get().meta.get().getValues(meta)[0][0].getValue();
    } catch (e:Dynamic) {
      null;
    }
  }
  #end

  macro public static function build():Array<Field>  {

    var cls = Context.getLocalClass();
    if (cls.get().name == 'Component') return null;
    var fields = Context.getBuildFields();

    var element = get_one_param(cls,':el');
    var template = get_one_param(cls,':template');


    var methods = [
      for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':bind')) {
        var name = field.name;
        macro methods.$name = $i{name};
      }];

    var computed = [
      for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':computed')) {
        var name = field.name;
        macro computed.$name = $i{name};
      }];

    var watched = [
      for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':watch')) {
        var name = field.name;
        var meta_params = field.getMetaParams(':watch');
        var watch_path = meta_params[0].toString().replace("'","").replace("\"","");
        var watch_prop = Context.parseInlineString(meta_params[1].toString(),Context.currentPos());
        macro vue.watch($v{watch_path},$i{name},$e{watch_prop});
      }];


    var new_fields = (macro class  {


      inline function initialize(data) {


        var methods = untyped {};
        $b{methods};

        var computed = untyped {};
        $b{computed};



        vue = new js.vue.Vue({
          el: $v{element},
          template: $v{template},
          data: data,
          methods:methods,
          computed:untyped computed
        });

        $b{watched};

      }

    }).fields;

    for (field in new_fields) fields.push(field);

    return fields;

  }
}
