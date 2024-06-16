import js.html.idb.Transaction;
import GameScene.GameController;

class Item extends h2d.Object{
    public var Type ={                                                            //Status
        OnRoundStart: 1, //Effect that starts when a new round starts             //Implemented
        OnRoundEnd: 2, //Effect that starts when a round ends                     //deprecated
        PreAttack: 3, //Effect that start right as the attack button is pressed   //deprecated
        PostAttack: 4, //Effect that starts after all attacks have been executed  //Implemented
        OnHit :5, //Effect that starts when taking damage                         //Implemented
        OnPlayerDeath: 6, //effect that starts when the player dies               //Implemented
        OnEnemyDeath: 7, //effect that starts when an enemy dies                  //implemented
        OnTurnSkip: 8//starts on turn skip                                        //implemented
    }
    public var ItemType:Int = 5;

    /**if this is false, Hide Item from Item List, to be used by biome effects as an invisible items **/
    public var Visible:Bool = true;

    var player:Player.Player;

    var enemy:Enemy.Enemy; //depending on the situation these value are not always used

    public var DisplayName:String = "Test";
        
    public var DisplayDescription = "Note if you somehow manage\nto see this,then that means\nit's a bug,\nplease report to the developer";

    public var ItemAsset:hxd.res.Image;

    public var assetbmp:h2d.Bitmap;
    public var NameText:h2d.Text;
    public var DescriptionText:h2d.Text;

    override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "DUMMY";
        DisplayDescription = "Note if you somehow manage\nto see this,then that means\nit's a bug,\nplease report to the developer";
    }
    

    public function Effect(p:Player.Player, e:Enemy.Enemy, ?AttackType:Int){
        player = p;
        enemy = e;

        if (AttackType == Type.OnRoundStart){
            OnRoundStart();
        }
        else if (AttackType == Type.OnRoundEnd){
            OnRoundEnd();
        }
        else if (AttackType == Type.PreAttack){
            OnPreAttack();
        }
        else if (AttackType == Type.PostAttack){
            OnPostAttack();
        }
        else if (AttackType == Type.OnHit){
            OnHit();
        }
        else if (AttackType == Type.OnPlayerDeath){
            OnPlayerDeath();
        }
        else if (AttackType == Type.OnEnemyDeath){
            OnEnemyDeath();
        }
        else if (AttackType == Type.OnTurnSkip){
            OnTurnSkip();
        }
        else{
            trace("what was the plan there exactly?");
        }
    }

    public function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        
        var getparent = if (parent!= null) parent else GameController.CurrentScene; //doing if statements in variables, what about it?, i love that i can do this
        var getimage = if (image != null) image else hxd.Res.ast.placeholderItem;

        if (visible){
            var asset = getimage;
            var assetdata = asset.toTile();
            assetbmp = new h2d.Bitmap(assetdata, getparent );
            NameText = new h2d.Text(GameController.NewFont, getparent );
            DescriptionText = new h2d.Text(GameController.NewFont, getparent);
            NameText.text = DisplayName;
            assetbmp.x = 16;
            assetbmp.y = 300;
            NameText.x = 125;
            NameText.y = 305;
            NameText.scale(0.75);
            NameText.color = new h3d.Vector4(1,1,1,1);
            NameText.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xFF000000}
            DescriptionText.text = DisplayDescription;
            DescriptionText.x = 125;
            DescriptionText.y = 330;
            DescriptionText.scale(0.5);
            DescriptionText.color = new h3d.Vector4(1,1,1,1);
            DescriptionText.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xFF000000}

        }
        
        
        
        
    }

    public function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        
        var getparent = if (parent!= null) parent else GameController.CurrentScene; //doing if statements in variables, what about it?, i love that i can do this
        var getimage = if (image != null) image else hxd.Res.ast.placeholderItem;

        if (visible){
            var asset = getimage;
            var assetdata = asset.toTile();
            var assetbmp = new h2d.Bitmap(assetdata, getparent );
            NameText = new h2d.Text(GameController.NewFont, getparent );
            NameText.text = DisplayName;
            assetbmp.y = 0;
            NameText.x = 18;
            NameText.y = 130;
            NameText.scale(0.5);
            NameText.color = new h3d.Vector4(1,1,1,1);
            NameText.dropShadow = {dx: 2, dy: 2, alpha: 1, color: 0xff000000};
        }
        
    }

    function OnRoundStart(){

    }

    function OnRoundEnd(){

    }

    function OnPreAttack(){

    }

    function OnPostAttack(){

    }

    function OnHit(){
        
    }

    function OnPlayerDeath(){

    }

    function OnEnemyDeath(){

    }

    function OnTurnSkip(){

    }


}

//----BIOME-EFFECTS----//
//effects here are invisible in game
class GrasslandsPassive extends Item{
    //the soul rune heals 20 hp on enemy death

    override function OnRoundStart() {
        player.Health += 25;
    }
}
class GraveyardPassive extends Item{
    //the background has a moon that cycles through 5 states
    //to put simply
    // / /- /---\ -\ \
    // | | |     | | |
    // \ \_ \___/ _/ /
    //if the moon is full that turn, enemies get specfic abilities like the wolf dealing double damage or the bat splitting into 5 bats instead of 2
    //will likely end up unfinished alongside the entire second biome
}



//----ITEMS----//
class MysticShield extends Item{//Finished
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Mystic Shield";
        DisplayDescription = "Protects against\n3 attacks\nevery round";
    }
    //Mystic Shield uses 2 Item Types
    //5 when the player gets hit
    //1 to check the beginning of a new round

    //it's a hacky implementation, and honestly it might stay that way
    //this is done to avoid creating extra stats just so that one item can use them
    var CurrentUsesLeft:Int = 3;
    var UsesLeft:Int = 3;

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Mystic_Shield);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Mystic_Shield);
    }


    override function OnHit() {
        if(CurrentUsesLeft > 0){
            player.MaxHealth += enemy.Damage;
            player.Health += enemy.Damage;
            player.MaxHealth -= enemy.Damage;
            trace("blocked lol");
            CurrentUsesLeft -= 1;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Mystic_Block);
        }
        
    }

    override function OnTurnSkip() {
        if(CurrentUsesLeft > 0){
            player.MaxHealth += enemy.Damage;
            player.Health += enemy.Damage;
            player.MaxHealth -= enemy.Damage;
            trace("blocked lol");
            CurrentUsesLeft -= 1;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Mystic_Block);
        }
        
    }

    override function OnRoundStart() {
        CurrentUsesLeft = UsesLeft;
    }
}

class SoulRune extends Item{//Finished
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Soul Rune";
        DisplayDescription = "Heals 10 HP on kill";
    }
    //the soul rune heals 10 hp on enemy death

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Soul_Rune);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Soul_Rune);
    }

    override function OnEnemyDeath() {
        player.Health += 10;
        Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Soul_Steal);
    }
}

class SheepStaff extends Item{//unimplemented
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Sheep Staff";
        DisplayDescription = "5% Chance to turn\na random enemy into\na helpless Sheep ";
    }
    //Sheep Staff is a meme item that has a 5% Chance to turn an enemy into a 5HP Sheep after attacking

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Sheep_Staff);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Sheep_Staff);
    }


    override function OnPostAttack() {
        var SelectedNumber = Random.int(1,100);
        if (SelectedNumber <= 5){
            var fool = Random.int(0, GameController.EnemyList.length - 1);
            if (GameController.EnemyList[fool].Health > 0){
                if (std.Type.getClassName(std.Type.getClass(GameController.EnemyList[fool])) != "Sheep"){
                    GameController.SpawnEnemy(new Enemy.Sheep(GameController.CurrentScene) );
                    GameController.RemoveEnemy(GameController.EnemyList[fool]);
                    trace(GameController.EnemyList);
                    Sounds.PlaySound(hxd.Res.snd.Sheep_baah);
                    for (index => i in GameController.EnemyList ){
                        i.x = 540 + (index * 160);
                    }
                }

            }
            
        }

    }


    override function OnTurnSkip() {
        var SelectedNumber = Random.int(1,100);
        if (SelectedNumber <= 3){
            var fool = Random.int(0, GameController.EnemyList.length - 1);
            if (GameController.EnemyList[fool].Health > 0){
                if (std.Type.getClassName(std.Type.getClass(GameController.EnemyList[fool])) != "Sheep"){
                    GameController.SpawnEnemy(new Enemy.Sheep(GameController.CurrentScene) );
                    GameController.RemoveEnemy(GameController.EnemyList[fool]);
                    Sounds.PlaySound(hxd.Res.snd.Sheep_baah);
                    trace(GameController.EnemyList);
                    for (index => i in GameController.EnemyList ){
                        i.x = 540 + (index * 160);
                    }
                }

            }
            
        }

    }

}

class SkippingStone extends Item{//Finished
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Skipping Stone";
        DisplayDescription = "Deals 20 damage\non Turn Skip";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Skipping_Stone);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Skipping_Stone);
    }
    //Skipping Turns always deals a minimum of 20 damage 
    var chance:Int = 5;


    override function OnTurnSkip() {
        enemy.Health -= 20;
        Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Stone_Chuck);
    }
}

class Steak extends Item{//Finished
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Steak";
        DisplayDescription = "+100 MaxHP and \n+25 to per round\nhealing";
    }
    
    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Steak);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Steak);
    }
    
    
    //+100 MAXHP and +25 to healing per round
    var BeefActive:Bool = false;


    override function OnRoundStart() {
        if (!BeefActive){
            player.MaxHealth += 100;
            player.Health += 100;
            BeefActive = true;
            trace("Beef");
        }
        else{
            player.Health += 25;
            trace("yum");
        }
    }

}

class ScrollOfPiercing extends Item{
    //attacks have a chance to attack the enemy behind as well
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Scroll of Piercing";
        DisplayDescription = "Attacks have a chance\nto hit the enemy\nbehind it";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Scroll_of_piercing);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Scroll_of_piercing);
    }


    override function OnPostAttack() {
        var SelectedNumber = Random.int(1,100);
        for (index => e in GameController.EnemyList){
            if (GameController.EnemyList.length > 1){
                if (enemy == e){
                    if (SelectedNumber <= 50){
                        GameController.EnemyList[index + 1].Health -= GameController.GetWordDamage();
                    }
                }
            }
            
        }
    }
}

class OrbOfChaos extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Orb of Chaos";
        DisplayDescription = "29% Chance to Oneshot\na random enemy,\n70% To do nothing,\n1% Chance for\ninstant death";
    }
    //29% chance to oneshot a random enemy
    //70% chance to do nothing
    //1%  chance to instantly die

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Orb_of_Chaos);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Orb_of_Chaos);
    }

    override function OnPostAttack() {
        var SelectedNumber = Random.int(1,100);
        if (SelectedNumber <= 29){
            var fool = Random.int(0, GameController.EnemyList.length - 1);
            GameController.EnemyList[fool].Health -= GameController.EnemyList[fool].MaxHealth;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Chaos_Sound);
        }
        else if (SelectedNumber == 30){
            player.Health -= player.MaxHealth;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Chaos_Sound);
        }
    }

    override function OnTurnSkip() {
        var SelectedNumber = Random.int(1,100);
        if (SelectedNumber <= 29){
            var fool = Random.int(0, GameController.EnemyList.length - 1);
            GameController.EnemyList[fool].Health -= GameController.EnemyList[fool].MaxHealth;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Chaos_Sound);
        }
        else if (SelectedNumber == 30){
            player.Health -= player.MaxHealth;
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Chaos_Sound);
        }
    }
}

class ThornMail extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Thorn Mail";
        DisplayDescription = "Reflects half damage\ntaken";
    }
    //Thorn Mail reflects half damage taken

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Thorn_Mail);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Thorn_Mail);
    }


    override function OnHit() {
        enemy.Health -= Math.ceil(enemy.Damage/2);
    }
}

class LoadedDice extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Loaded Dice";
        DisplayDescription = "25% Chance for a\nCritical hit dealing\n3 times the damage";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Loaded_Dice);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Loaded_Dice);
    }


    //attacking has a 25% chance to crit for 3 times the damage
    var SelectedNumber:Int;


    override function OnPostAttack() {
        SelectedNumber = Random.int(1,100);
        if (SelectedNumber <= 25){
            enemy.Health -= GameController.GetWordDamage() * 2; //3 attacks in total
            Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Crit_Sound);
        }
    }
}

class GodsStaff extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "God's Staff";
        DisplayDescription = "Cheat death, Once.";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.God_Staff);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.God_Staff);
    }



    //Revives on death once
    var Revived:Bool = false;


    override function OnPlayerDeath() {
        if (!Revived){
            player.Health = player.MaxHealth;
            Sounds.PlaySound(hxd.Res.snd.godstaff_choir);
            Revived = true;
        }
    }
}

class StrengthPotion extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Strength Potion";
        DisplayDescription = "+20 Damage ";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Strength_Potion);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Strength_Potion);
    }
    //+20 to damage dealt


    override function OnPostAttack() {
        enemy.Health -= 20;
    }
}

class Backstabber extends Item{
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Backstabber";
        DisplayDescription = "Also deals damage\non the farthest enemy";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Backstabber);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Backstabber);
    }


    //also deals damage to the enemy in the far back
    //this has the added benefit of doing double damage when there's only one enemy


    override function OnPostAttack() {
        GameController.EnemyList[GameController.EnemyList.length - 1].Health -= GameController.GetWordDamage();
        Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.Backstab);
    }
}

class DysonOrb extends Item{//abstract ass idea
    public override function new( ?parent : h2d.Object ){
        super();
        DisplayName = "Dyson Orb";
        DisplayDescription = "All enemies take\n10 damage\nevery turn";
    }

    public override function init(?parent:h2d.Scene, ?visible:Bool = true, ?image:hxd.res.Image){
        super.init(parent, visible, hxd.Res.ast.Dyson_Orb);
    }

    public override function DrawIcon(?parent:h2d.Object, ?visible:Bool = true, ?image:hxd.res.Image){//stats are to be initiated here
        super.DrawIcon(parent, visible, hxd.Res.ast.Dyson_Orb);
    }



    //-10 HP to all enemies every turn


    override function OnPostAttack() {
        for (e in GameController.EnemyList){
            e.Health -= 10;
        }
    }

    override function OnTurnSkip() {
        for (e in GameController.EnemyList){
            e.Health -= 10;
        }
    }
}