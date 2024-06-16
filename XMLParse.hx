import haxe.xml.Parser;
import h2d.Object;

class XMLParser extends Object{
    // public function new(){//mendatory bullshit
    //     super();
    // }

    public static function getRoundNumber(Difficulty:String, Round:Int):String{
        //haxedocs result
        // var xml = Xml.parse('<root>Haxe is great!</root>').firstElement().firstChild().nodeValue;
        // trace(xml);

        //the gist of what's needed:
        var xmlfile = hxd.Res.waves.waves; //the localization file
        var xmlaccess = new haxe.xml.Access(Parser.parse(xmlfile.entry.getText())); //access to the xml file
        var nodetext = xmlaccess.node.gamerounds; //directing it where the game text is
        var leveltext = nodetext.node.resolve(Difficulty).node.resolve("R" + Std.string(Round));
        
        var result = Xml.parse(Std.string(leveltext)).firstElement().firstChild().nodeValue;
        return result;
    }  
    public static function Swooce(){//i forgot what this was for lol, don't do programming in the middle of the night everyone
        trace("watch me swooce right in");
        trace("swooce,swooce");
    }
}