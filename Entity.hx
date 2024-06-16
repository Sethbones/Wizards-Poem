class Entity extends h2d.Object{//the basic entity class, holds all basic information and functions
    public var Health:Int = 100;
    public var MaxHealth:Int = 200;
    public var Damage:Int = 10; //only used by enemies technically
    var Abilites:Array<h2d.Object> = [];
    var healthtext:h2d.Text;

    //entity abilites, should probably not be here but i don't know
    function playActiveBattleEffects() {

    }

    function playPreBattleEffects() {

    }

    function playPostBattleEffects() {

    }

    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 100;
    //     Health = MaxHealth;
    //     Damage = 10;
    // }
    public function Update(){
        if (Health <= 0) {//this is probably not the correct way but fuck it
            trace("estoy dead");
            //PlayDeathEffect();
        }
    }

    // public override function draw(ctx : h2d.RenderContext){
    //     //is it supposed to run per frame?. i don't like this lol, especially because i can get away with manually just drawing it once
    //     //there's probably no performance difference but still
    //     //the only point where i can see this being useful is if i need to change its asset in real time, with something else
    //     //but if i use a spritesheet, then drawing per frame is useless
    //     //and if i do it like this i can also have it as an init for the object
    //     //please correct me about this, i don't understand how this engine works
    //     //love2D by comparison has singular draw function that draws per frame and deletes per frame, and its clearly written 
    //     var asset = hxd.Res.ast._dummy;
    //     var assetdata = asset.toTile();
    //     var assetbmp = new h2d.Bitmap(assetdata,parent);
    //     trace(parent.parent);
    // }

    public function objDraw(parent:h2d.Object){
        //trace("its alive!");
        var asset = hxd.Res.ast._dummy;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        MaxHealth = 100;
        Health = MaxHealth;
        Damage = 10;
    }
}