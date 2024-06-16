import h2d.Text.Align;
import Player.Wizard;
import h3d.Vector4;
import hxd.res.BitmapFont;
import h2d.Object;
import h2d.Scene;
import hxd.res.Image;
import h2d.Bitmap;
import hxd.res.DefaultFont;
import hxd.Key;
import h2d.Layers;
import h3d.Vector;
import hxd.Pixels.PixelsFloatRGBA;
import hxd.Window;
//honestly the more i work on this the more it feels like i'm making my own game engine
import GlobalFuncs.Global;
import GameScene.GameController;


class Main extends hxd.App {
    var bmp : h2d.Bitmap;
    public static var console:h2d.Console = null;
    var consoleVisible = false;
    public static var level:Image = null;
    public static var Language:String = "english";

    //Stat Updates


    public static var StatRound:h2d.Text;
    public static var StatTillBoss:h2d.Text;
    public static var StatLongestWord:h2d.Text;



    public function new() {//i'm gonna have to assume this is what happens pre init, like awake in unity
        super();
    }
    
    override function init() {
        s2d;
        s2d;
        //trace(s2d.name);
        hxd.Res.initEmbed(); //this is needed for graphics
        Window.getInstance().resize(960,540);
        //s2d.scaleMode = ScaleMode.Zoom(2);
        GameController.InitFont();
        
        var Back = hxd.Res.ast.Background;
        var Backdata = Back.toTile();
        var Backbmp = new h2d.Bitmap(Backdata,s2d);
        
        var gui = hxd.Res.ast.UI;
        var guidata = gui.toTile();
        var guibmp = new h2d.Bitmap(guidata,s2d);

        GameController.CurrentScene = s2d;
        // GameController.SpawnItems( Global.GetRandomItem(), Global.GetRandomItem(), Global.GetRandomItem() ); //testing testing
        // GameController.SpawnItems( Global.GetRandomItem(), Global.GetRandomItem(), Global.GetRandomItem() ); //testing testing testing
        //var testbox = new Ending.EndScreen(s2d);
        //testbox.endscreen();
        //well this is just to make sure the attack button variable is not empty
        GameController.CreateAttackButton(s2d);
        GameController.RemoveAttackButton();
        //its dumb and needs to be removeds

        GameController.SpawnPlayer(s2d);
        GameController.WordDetectInit();

        //set up word rows
        //will need changing, cause good lord this is big
        //it can definitely be shrunken down a do just one portion
        var row1:Array<String> = [Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter()];
        var row2:Array<String> = [Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter()];
        var row3:Array<String> = [Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter()];
        var row4:Array<String> = [Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter(),Global.RandomLetter()];
        
        engine.backgroundColor = 0x323232; //this is really only here so i can see the edges of the screen
        
        //wall of text incoming
        for (index => l in row1){
            var Box = new WordBox(58,58, s2d);
            Box.CreateBox(l, s2d, 300 + 32, 262 + (index * 58));
            Box.onClick = function(action){
                GameController.AddToWordList(Box);
                trace(GameController.WordList);
                Sounds.PlaySound(hxd.Res.snd.selectionSound);
                if (GameController.IsWordValid()){
                    GameController.RedrawAttackButton(s2d);
                }
                else{
                    GameController.RemoveAttackButton();
                }
            }
            Box.onRelease = function (action) {//had a use at some point, not right now though

            };
            GameController.WordsAvailable.push(Box);
        }
        for (index => l in row2){
            var Box = new WordBox(58,58, s2d);
            Box.CreateBox(l, s2d, 320 + 32 + 58, 270 + (index * 58));
            Box.onClick = function(action){
                GameController.AddToWordList(Box);
                Sounds.PlaySound(hxd.Res.snd.selectionSound);
                trace(GameController.WordList);
                if (GameController.IsWordValid()){
                    GameController.RedrawAttackButton(s2d);
                }
                else{
                    GameController.RemoveAttackButton();
                }
            }
            Box.onRelease = function (action) {

            };
            GameController.WordsAvailable.push(Box);
        }
        for (index => l in row3){
            var Box = new WordBox(58,58, s2d);
            Box.CreateBox(l, s2d, 345 + 32 + 58+58, 270 + (index * 58));
            Box.onClick = function(action){
                GameController.AddToWordList(Box);
                trace(GameController.WordList);
                Sounds.PlaySound(hxd.Res.snd.selectionSound);
                if (GameController.IsWordValid()){
                    GameController.RedrawAttackButton(s2d);
                }
                else{
                    GameController.RemoveAttackButton();
                }
            }
            Box.onRelease = function (action) {

            };
            GameController.WordsAvailable.push(Box);
        }
        for (index => l in row4){
            var Box = new WordBox(58,58, s2d);
            Box.CreateBox(l, s2d, 365 + 32 + 58+58+58, 262 + (index * 58));
            Box.onClick = function(action){
                GameController.AddToWordList(Box);
                trace(GameController.WordList);
                Sounds.PlaySound(hxd.Res.snd.selectionSound);
                if (GameController.IsWordValid()){
                    GameController.RedrawAttackButton(s2d);
                }
                else{
                    GameController.RemoveAttackButton();
                }
            }
            Box.onRelease = function (action) {

            };
            GameController.WordsAvailable.push(Box);
        }


        //temporary Skip Turn Button
        var TurnSkip = new h2d.Interactive(128,32, s2d);
        //TurnSkip.backgroundColor = 0xFF805F5F;
        var tf = new h2d.Text(GameController.NewFont, TurnSkip);
        var whitedice:hxd.res.Image;
        var dicebmp:h2d.Bitmap;
        TurnSkip.x = 960 /2 - TurnSkip.width/2;
        TurnSkip.y = 540-32;
        TurnSkip.onClick = function (action){
            GameController.SkipTurn();
        }
        TurnSkip.onOver = function (action){
            whitedice = hxd.Res.ast.SkipHover   ;
            var assetdata = whitedice.toTile();
            dicebmp = new h2d.Bitmap(assetdata,s2d);
            dicebmp.x = (960 / 2) - 10 ;
            dicebmp.y = 520;
        }
        TurnSkip.onOut = function (action){
            dicebmp.remove();
        }


        //these do nothingg
        //temporary Stat Text
        //Current Biome
        var StatBiome = new h2d.Text(GameController.NewFont, s2d);
        StatBiome.text = "Stats";
        StatBiome.textAlign = Align.Center;
        StatBiome.scale(2);
        StatBiome.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatBiome.x = 800;
        StatBiome.y = 255;
        
        var InBiome = new h2d.Text(GameController.NewFont, s2d);
        InBiome.text = "Biome: Grasslands";
        StatBiome.textAlign = Align.Center;
        InBiome.scale(1);
        InBiome.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        InBiome.x = 670;
        InBiome.y = 310;

        //Round Display:
        StatRound = new h2d.Text(GameController.NewFont, s2d);
        StatRound.text = "Round 0/10";
        StatBiome.textAlign = Align.Center;
        StatRound.scale(1);
        StatRound.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatRound.x = 720;
        StatRound.y = 350;

        StatTillBoss = new h2d.Text(GameController.NewFont, s2d);
        StatTillBoss.text = "7 Till Boss";
        StatBiome.textAlign = Align.Center;
        StatTillBoss.scale(1);
        StatTillBoss.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatTillBoss.x = 720;
        StatTillBoss.y = 380;

        //Longest Word:
        var StatLongWord = new h2d.Text(GameController.NewFont, s2d);
        StatLongWord.text = "Longest Word";
        StatBiome.textAlign = Align.Center;
        StatLongWord.scale(1);
        StatLongWord.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatLongWord.x = 700;
        StatLongWord.y = 420;

        StatLongestWord = new h2d.Text(GameController.NewFont, s2d);
        StatLongestWord.text = "";
        StatBiome.textAlign = Align.Center;
        StatLongestWord.scale(1);
        StatLongestWord.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatLongestWord.x = 670;
        StatLongestWord.y = 460;

        //Item Display
        var StatItems = new h2d.Text(GameController.NewFont, s2d);
        StatBiome.textAlign = Align.Center;
        StatItems.text = "Items";
        StatItems.scale(1.75);
        StatItems.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xffffffff};
        StatItems.x = 90;
        StatItems.y = 252;

        
    }
    


    // on each frame
    override function update(dt:Float) {
        //GameLayer.DelayedDraw(dt);
        
        // if (Key.isPressed(Key.ENTER)){
        //     GameController.PlayerAttack();

        // }
        // if (Key.isPressed(Key.BACKSPACE)){
        //     GameController.ResetWordList();
        //     trace(GameController.WordList);
        // }
        if (Key.isPressed(Key.TAB)){
            trace(8 % 4);
        }


        // public static var CurrentRound:String = "0/10";
        // public static var RoundsTillBoss:String = "10";
        // public static var CurrentLongestWord:String = ""; 
        StatRound.text = (Std.string("Round: "+  GameController.Round) + "/" + "10");
        StatTillBoss.text = (Std.string(10 % GameController.Round) + " till boss");
        StatLongestWord.text = GameController.CurrentLongestWord;
        
        
        if (Key.isPressed(49)){
            if (consoleVisible == false){
                console.show();
                consoleVisible = true;
            }
            else{
                console.hide();
                consoleVisible = false;
            }
        }

        GameController.Update();
        //for things that should be moved eventually
        for (i in GameController.EnemyList){
            cast(i,Enemy).Update();
        }
        for (i in GameController.PlayerParty){
            cast(i,Wizard).Update();
        }

        // if (Key.isPressed(50)){ //log all objects
        //     //this feels inefficient
        //     for (index => i in GameLayer.GetAllLayers()){
        //         for (obj in i){
        //             if (Std.isOfType(obj, GridObject)){
        //                 var gridobj = cast(obj, GridObject);
        //                 console.log("object of class: " + gridobj + " in Layer: " + index + " at tile: " + gridobj.TileX + "," + gridobj.TileY);
        //             }
        //         }
        //     }
        // }
    }
    static function main() {
        new Main();
    }
}