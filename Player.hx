import GameScene.GameController;

class Player extends Entity.Entity{
    var items:Array<h2d.Object> = []; //to be used eventually

    function AttackEnemy(){

    }


    //word damage scaling

    //1 - need to check for 1 letter words because technically a and i can count as words - 5
    //2 - 10
    //3 - 15
    //4 - 20
    //5 - 25
    //6 - 30
    //7 - 35
    //8 - 40
    //9 - 45
    //10 - 50
    //11 - 60
    //12 - 70
    //13 - 80
    //14 - 90
    //15 - 100
    //16 - 110 i don't think it's even possible, should probably give an achivement for that one lol
    //for a example sauce is 5 words words and deals 25 damage
    //and a word like nonaffluent is 11 words and deals 60 damage
    //if any of that makes sense
}


class Wizard extends Player{
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 200;
    //     Health = MaxHealth;
    // }

    public function init(){

    }

    public override function objDraw(parent:h2d.Object){
        //trace("its alive!");
        var asset = hxd.Res.ast.Wizard;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(GameController.NewFont, parent);
        healthtext.text = "0/0";
        healthtext.x = 256/2 - 48;
        healthtext.y = 32;
        healthtext.scale(1);
        healthtext.color = new h3d.Vector4(1,1,1,1);
        healthtext.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000}
        MaxHealth = 300;
        Health = MaxHealth;
    }

    public override function Update(){
        if (Health <= 0) {//this is probably not correct
            trace("estoy dead");
            //PlayDeathEffect();
        }
        if (Health > MaxHealth) {//this is probably not correct
            Health = MaxHealth;
        }
        healthtext.text = ( Std.string(Health) + "/" + Std.string(MaxHealth) );
    }
}