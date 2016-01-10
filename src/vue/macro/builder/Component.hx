package vue.macro.builder;

using StringTools;
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

using Component.BuilderTools;

class BuilderTools {
  public static inline function clean_template(s:String)
    return s.replace("\n","").replace("\r","").trim();
}

class Component {

  #if macro
    static function get_one_param(cls: Null<haxe.macro.Ref<haxe.macro.ClassType>>,meta:String):String {
      return try {
        cls.get().meta.get().getValues(meta)[0][0].getValue();
      } catch (e:Dynamic) {
        "";
      }
    }


    static inline function process_methods(fields:Array<Field>) {
      return [
        for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':bind')) {
          var name = field.name;
          macro methods.$name = untyped cls.prototype.$name;
        }
      ];
    }

    static inline function process_computed(fields:Array<Field>) {
      return [
        for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':computed')) {
          var name = field.name;
          macro computed.$name = $i{name};
        }];
    }


    static inline function process_watched(fields:Array<Field>) {

      return [
        for (field in fields) if (field.isMethod() && field.isInstance() && field.hasMeta(':watch')) {
          var name = field.name;
          var meta_params = field.getMetaParams(':watch');
          var watch_path = meta_params[0].toString().replace("'","").replace("\"","");
          var watch_prop = try {
            Context.parseInlineString(meta_params[1].toString(),Context.currentPos());
          } catch(e:Dynamic) {
            Context.parseInlineString('{}',Context.currentPos());
          }
          macro {
            untyped watched[$v{watch_path}] = $watch_prop;
            untyped watched[$v{watch_path}].handler = $i{name};
          }
      }];
    }

  #end

  macro public static function build():Array<Field>  {

    var cls = Context.getLocalClass();
    var cls_ref = cls.get();
    var class_path = cls.toString();

    var fields = Context.getBuildFields();

    var template = get_one_param(cls,':template').clean_template();
    var name = get_one_param(cls,':name');

    var methods = process_methods(fields);


    //var computed = process_computed(fields);
    //var watched = process_watched(fields);

    var new_fields = (macro class  {

      static function __init__() {
        var cls = $p{class_path.split(".")};
        var methods = untyped {};
        $b{methods}

        js.vue.Vue.component($v{name},js.vue.Vue.extend({
          data:untyped function() return  cls.data_init,
          template:$v{template},
          methods:methods
        }));

      }

    }).fields;

    for (field in new_fields) fields.push(field);

    return fields;

  }
}
