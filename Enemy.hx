import GameScene.GameController;

class Enemy extends Entity.Entity{//i need to think this through, in general this is just a tag as its own class
    
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 100;
    //     Health = MaxHealth;
    //     Damage = 10;
    // }

    function attackplayer(){

    }

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.placeholder_slime;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(hxd.res.DefaultFont.get(), parent);
        healthtext.text = "0/0";
        healthtext.x = 16;
        healthtext.y = -6;
        healthtext.scale(4);
        healthtext.color = new h3d.Vector4(0,0,0,1);
        MaxHealth = 100;
        Health = MaxHealth;
        Damage = 10;
    }


    public override function Update(){
        healthtext.text = ( Std.string(Health) + "/" + Std.string(MaxHealth) );
    }
}

class Boss extends Enemy{//i need to think this through, in general this is just a tag as its own class
    
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 100;
    //     Health = MaxHealth;
    //     Damage = 10;
    // }

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.placeholder_slime;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(hxd.res.DefaultFont.get(), parent);
        healthtext.text = "0/0";
        healthtext.x = 16;
        healthtext.y = -6;
        healthtext.scale(4);
        healthtext.color = new h3d.Vector4(0,0,0,1);
        MaxHealth = 100;
        Health = MaxHealth;
        Damage = 10;
    }


    public override function Update(){
        healthtext.text = ( Std.string(Health) + "/" + Std.string(MaxHealth) );
    }
}

class Blob extends Enemy{//blobs are weak, frail, and are designed to be the most generic enemy in the game

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.Blob;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(GameController.NewFont, parent);
        healthtext.text = "0/0";
        healthtext.x = 256/2 - 48;
        healthtext.y = 96;
        healthtext.scale(1);
        healthtext.color = new h3d.Vector4(1,1,1,1);
        healthtext.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000}
        MaxHealth = 25;
        Health = MaxHealth;
        Damage = 15;
    }
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 25;
    //     Health = MaxHealth;
    //     Damage = 5;
    // }
}


class Tree extends Enemy{//trees are much bulkier but deal much less damage

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.Tree;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(GameController.NewFont, parent);
        healthtext.text = "0/0";
        healthtext.x = 256/2 - 48;
        healthtext.y = 96;
        healthtext.scale(1);
        healthtext.color = new h3d.Vector4(1,1,1,1);
        healthtext.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000}
        MaxHealth = 100;
        Health = MaxHealth;
        Damage = 5;
        //healthtext.dropShadow = {dx: 1, dy: 1,color:0xFFFFFFFF, alpha:1};
    }
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 25;
    //     Health = MaxHealth;
    //     Damage = 5;
    // }
}

class TreeGolem extends Enemy{//trees are much bulkier but deal much less damage
    //bosses are not meant to deal a lot of damage by themselves
    //they're meant to summon allies that slowly make 

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.Tree;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        assetbmp.scale(1.75);
        assetbmp.y = -200;
        healthtext = new h2d.Text(GameController.NewFont, parent);
        healthtext.text = "0/0";
        healthtext.x = 256/2;
        healthtext.y = 24;
        healthtext.scale(1);
        healthtext.color = new h3d.Vector4(1,1,1,1);
        healthtext.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000}
        MaxHealth = 400;
        Health = MaxHealth;
        Damage = 10;
    }
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 25;
    //     Health = MaxHealth;
    //     Damage = 5;
    // }
}

class Sheep extends Enemy{//it's a sheep

    public override function objDraw(parent:h2d.Object){//would be better if it was named init or something
        //trace("its alive!");
        var asset = hxd.Res.ast.Sheep;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,parent);
        trace(parent.parent);
        healthtext = new h2d.Text(GameController.NewFont, parent);
        healthtext.text = "0/0";
        healthtext.x = 256/2 - 48;
        healthtext.y = 96;
        healthtext.scale(1);
        healthtext.color = new h3d.Vector4(1,1,1,1);
        healthtext.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000}
        MaxHealth = 5;
        Health = MaxHealth;
        Damage = 0;
        //healthtext.dropShadow = {dx: 1, dy: 1,color:0xFFFFFFFF, alpha:1};
    }
    // public function new(){//set initial stats
    //     super();
    //     MaxHealth = 25;
    //     Health = MaxHealth;
    //     Damage = 5;
    // }
}