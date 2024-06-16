import Ending.EndScreen;
import GlobalFuncs.Global;
import hxd.res.Resource;
import h3d.scene.World;
import Player;
import Entity.Entity;


//current issues
//finding words to make a letter longer than 3 words is very difficult, either that or i'm very dumb
//leaning towards very dumb currently
//
//game feels a bit off to play, trying to compare to bookworm adventures as much as possible, and i either observed some mechanics or hallucinated them:
//from a glance i think bookworm adventures does the following:
//A: check if a word combined from the available letters list is of a specific length, if not, keep rerolling until a word of that length is found
//B: have a specfic word it want's you to have and slow drip feeds its words down as it goes
//C: drop the words downwards after an attack so that it refreshes your brain into looking for more words
//D: items such as the bow of zyx alter the word pool to make those words more common
//the current plans are:
//add a skip turn button under the letter runes, so that the letters all randomize at the cost of taking damage

class GameController extends h2d.Object{
    //bad practice 101, make the entire game's logic global
    //it should be created as needed and manipulated from there but my problem is that it's less easy to deal with that way.
    public static var PlayerParty:Array<Player.Player> = [];
    public static var ItemList:Array<Item.Item> = [];
    public static var EnemyList:Array<Enemy.Enemy> = [];
    public static var FinalPoem:Array<String> = []; //compile all the successful words at the end into one jumbled mess for people to share
    //note should probably be done in javascript so that the text can be copied outside the game
    //also note, this feature might end up being scrapped, the lack of time will tell
    public static var attackbutton:h2d.Interactive;
    public static var CurrentScene:h2d.Scene; //this is silly but it'll make more sense when everything is not static
    public static var NewFont:h2d.Font;
    

    //word manipulation
    public static var WordsAvailable:Array<WordBox> = [];//get all the words on screen
    public static var WordList:Array<WordBox> = [];
    //public static var WordListWatcher:Array<WordBox> = []; //watches Wordlist for Changes, broken
    
    //word detection
    public static var WordDictionary:Resource;
    public static var WordDictionaryList:Array<String> = [];

    //Gameplay Loop
    public static var Round:Int = 0;
    // public static var PlayerDeathTimer:Float = 0; //this is idiotic but i know it will work, basically i need to check if the player is dead
    // //but i can't check for item effects if the player is already dead 

    //UI
    public static var attackassetbmp:h2d.Bitmap;

    public static var CurrentLongestWord:String = "";


    //these functions are all basics to test variable while being visualless
    public static function SpawnPlayer(parent: h2d.Object){
        var insert = new Player.Wizard(parent);
        PlayerParty.push(insert);
        insert.objDraw(insert);
    } 
    
    public static function SpawnEnemy(EnemyToSpawn:Enemy.Enemy){
        EnemyToSpawn.objDraw(EnemyToSpawn);
        EnemyList.push(EnemyToSpawn);
        for (index => i in EnemyList ){
            i.x = 500 + (index * 160);
        }
        //EnemyToSpawn.x = 360;
        trace(EnemyToSpawn.x);
    }
    public static function SpawnEnemyFromString(string:String){//i spent five hours on this shit
        var classget = Type.resolveClass( string );
        var Classinst = cast(Type.createInstance(classget, [CurrentScene]), Enemy.Enemy); //fuck this function
        Classinst.objDraw(Classinst);
        EnemyList.push(Classinst);
        for (index => i in EnemyList ){
            i.x = 500 + (index * 128);
        }
    }

    public static function AddToWordList(letter:WordBox){
        //currently words can go offscreen
        trace("checking");
        trace(WordList);
        if (WordList.contains(letter)){
            trace("hold on pardner i'm gonna need your ID");
            letter.x = letter.ogX;
            letter.y = letter.ogY;
            WordList.remove(letter);
            for (index => i in WordList){
                i.x = 300 + (index * 58);
                i.y = 50;
            }
        }
        else{
            WordList.push(letter);
            for (index => i in WordList){
                trace("word not there, adding");
                i.x = 300 + (index * 58);
                i.y = 50;
            }
        }
        
    }

    public static function CreateAttackButton(render:h2d.Scene){
        var attackasset = hxd.Res.ast.Attack_Graphic;
        attackassetbmp = new h2d.Bitmap(attackasset.toTile(), CurrentScene);
        attackbutton = new h2d.Interactive(294,64,render);
        //attackbutton.backgroundColor = 0xFF5B4B4B;
        var tf = new h2d.Text(NewFont, attackbutton);
        tf.text = "attack";
        tf.scale(1.75);
        tf.color = new h3d.Vector4(0,0,0,1);
        tf.dropShadow = {dx: 1, dy: 1, alpha: 1,color: 0xff343434};
        tf.x = 60;
        tf.y = 20;
        attackbutton.x = 960 /2 - 294/2;
        attackbutton.y = 200;
        attackassetbmp.x = (960/2) - 294/2;
        attackassetbmp.y = 215;
        attackbutton.onClick = function (action){
            PlayerAttack();
            RemoveAttackButton();
        }
    }

    public static function RemoveAttackButton(){
        attackassetbmp.remove();
        attackbutton.remove();
    }

    public static function RedrawAttackButton(render:h2d.Scene){
        RemoveAttackButton();
        CreateAttackButton(render);
    }

    public static function PlayerAttack(){
        if (IsWordValid()){
            trace("Player Attacks!");
            for (p in PlayerParty){
                EnemyList[0].Health -= GetWordDamage();
                Sounds.PlaySoundAtRandomPitch(hxd.Res.snd.ChaosHit);
                CheckLongestWord();
                EnemyAttack();
            }
            trace(EnemyList[0].Health);
            trace(EnemyList[0]);
            for (index => i in WordList){
                i.x = i.ogX;
                i.y = i.ogY;
                //randomize text
                cast(i.getChildAt(1), h2d.Text).text = Global.RandomLetter().toUpperCase();
            }
            if (ItemList.length >= 1){
                for(item in ItemList){
                    item.Effect(PlayerParty[0],EnemyList[0],item.Type.PostAttack);
                }
            }

            ResetWordList();

        }
        else{
            trace("attack not valid");
            //ResetWordList();
        }
        
    }

    public static function SkipTurn() {
        EnemyAttack();
        ScrambleWords();

        if (ItemList.length >= 1){
            for(item in ItemList){
                item.Effect(PlayerParty[0],EnemyList[0],item.Type.OnTurnSkip);
            }
        }
        
    }

    public static function ResetWordList(){
        WordList = [];
    }

    public static function ScrambleWords(){
        for (index => i in WordsAvailable){
            i.x = i.ogX;
            i.y = i.ogY;
            //randomize text
            cast(i.getChildAt(1), h2d.Text).text = Global.RandomLetter().toUpperCase();
            ResetWordList();
            RemoveAttackButton();
        }
    }

    public static function Update(){


        WaveController();

        // if (WordList != WordListWatcher){ //this doesn't work normally, for some reason it completely skips everything except the final wordlistwatcher = wordlist 
        //     //this makes no sense, it works but it doesn't but it works but it doesn't.
        //     //WordListWatcher = WordList;
        //     // trace("Watcher Updated");
        //     // if(IsWordValid()){
        //     //     trace("weewooweewoo");
        //     // }
        //     // else{
        //     //     trace("well shit lol");
        //     // }
        //     trace("haxe what the fuck");
        //     WordListWatcher = [];
        //     //WordListWatcher = WordList;
        //     //trace(WordListWatcher);
        // }
        //trace(WordListWatcher);

        //AttackButtonLogic();

    }
    
    //shitty damage table, i know i can probably reduce this down, but like this suffices for now
    public static function GetWordDamage(){
        

        if (WordList.length >= 1){
            trace("10 or smaller");
            return WordList.length * 10;
        }
        else if (WordList.length <= 0){
            return 0;
        }
        return 0;
        //i think damage is a bit of difficult subject
        //its hard to make it so you deal enough damage to feel meaningful but not enough to throw balance out of it orbit
        //to be looked after the jam for a potential steam release
    }
    
    public static function WordDetectInit(){
        //obtained from here: https://github.com/dwyl/english-words
        //there's a fuck load of junk words, and shortend words, and what i believe to be slangs, and somehow its to be used for auto-completion
        //in what dimension would i need "lh" as a suggestion for auto-completion
        //needs to be manually altered, that list is absolute garbo and needs a lot of tweaking
        WordDictionary = hxd.Res.text.words_alpha;
        //public static var WordDictionaryList:Array<String> = [];
        
        var wordString = WordDictionary.entry.getText(); //shortcut to string
        WordDictionaryList = wordString.split("\r\n"); //this took me like 3 hours to figure out, the python script i converted this from only checked for \n so that's fun
        //basically the \r stayed and it caused issues
        //trace(WordDictionaryList[0] + WordDictionaryList[1]);
    }

    public static function IsWordValid():Bool{
        var combinedWord:String = "";
        //trace(cast(GameController.WordsAvailable[0].getChildAt(1), h2d.Text).text);
        //trace(WordList[0].getChildAt(0));
        for (index => i in WordList){
            combinedWord = combinedWord+cast(WordList[index].getChildAt(1), h2d.Text).text;
        }
        //trace(combinedWord);
        if (WordList.length >= 2){
            trace(WordList);
            for (i in WordDictionaryList){
                //trace((combinedWord + "\n") == i);
                if (combinedWord.toLowerCase() == i){
                    trace(i);
                    trace("this word is valid, go kick some ass");
                    return true;
                }
            }
        }
        
        //trace("your english sucks lol");
        return false;
    }


    public static function CheckLongestWord(){
        var combinedWord:String = "";
        for (index => i in WordList){
            combinedWord = combinedWord+cast(WordList[index].getChildAt(1), h2d.Text).text;
        }
        if (combinedWord.length > CurrentLongestWord.length){
            CurrentLongestWord = combinedWord;
        }
    }


    //Gameloop Bullshit
    public static function WaveController(){
        CheckPlayerDeath();
        CheckEnemyDeath();
        
        if (EnemyList.length == 0){
            //SpawnEnemy(new Enemy.Tree(CurrentScene));
            trace("bring forth next round");
            if (Round != 10){
                getNextWave();
            }
            else{
                getNextWave();
                LoadEndScreen();
            }
        }
    }

    public static function getNextWave(){
        if (Round % 4 == 0 && Round != 0){
            SpawnItems( Global.GetRandomItem(), Global.GetRandomItem(), Global.GetRandomItem() );
        }
        if (Round != 10){
            Round += 1;
        }
        var xmlstring = XMLParse.XMLParser.getRoundNumber("normal", Round);
        var xmlarray:Array<String> = [];
        xmlarray = xmlstring.split(",");
        var classget = Type.getClass("Enemy.Enemy");
        //trace(classget);
        //Type.createInstance();
        //trace(xmlarray);
        for (i in xmlarray){
            SpawnEnemyFromString(i);
        }

        for (p in PlayerParty){
            p.Health += 25;
        }
        if (ItemList.length >= 1){
            for (p in PlayerParty){
                for(item in ItemList){
                    item.Effect(p,EnemyList[0],item.Type.OnRoundStart);
                }
            }
        }
    }

    public static function LoadEndScreen(){
        var ending = new EndScreen(GameController.CurrentScene);
        ending.endscreen();
    }

    public static function SpawnItems(Item1:Item.Item,Item2:Item.Item,Item3:Item.Item){
        var ItemA = new WordBox(128,128, CurrentScene);
        var ItemB = new WordBox(128,128, CurrentScene);
        var ItemC = new WordBox(128,128, CurrentScene);

        ItemA.CreateItemBox(Item1,CurrentScene,220,0);
        ItemA.onClick = function(action){
            GiveItem(Item1);
            //DisplayItem(Item1);
            ItemA.remove();
            ItemB.remove();
            ItemC.remove();
        }

        ItemB.CreateItemBox(Item2,CurrentScene,220+128,0);
        ItemB.onClick = function(action){
            GiveItem(Item2);
            ItemA.remove();
            ItemB.remove();
            ItemC.remove();
        }

        ItemC.CreateItemBox(Item3,CurrentScene,220+128+128,0);
        ItemC.onClick = function(action){
            GiveItem(Item3);
            ItemA.remove();
            ItemB.remove();
            ItemC.remove();
        }

    }

    public static function GiveItem(item:Item.Item){
        ItemList.push(item);
        item.init();
        for (index => item in ItemList){
            item.assetbmp.y = 300 + (128 * index);
            item.NameText.y = 305 + (128 * index);
            item.DescriptionText.y = 330 + (128 * index);
        }
    }

    public static function RemoveEnemy(enemytoremove: Enemy.Enemy){
        enemytoremove.remove();
        EnemyList.remove(enemytoremove);
    }

    public static function CheckEnemyDeath(){
        for (e in EnemyList){
            if (e.Health <= 0){
                e.remove();
                EnemyList.remove(e);
                if (ItemList.length >= 1){
                    for (p in PlayerParty){
                        for(item in ItemList){
                            item.Effect(p,e,item.Type.OnEnemyDeath);
                        }
                    }
                }
            }
        }
    }

    public static function CheckPlayerDeath(){
        for (p in PlayerParty){
            if (p.Health <= 0){
                if (ItemList.length >= 1){
                    for (p in PlayerParty){
                        for(item in ItemList){
                            item.Effect(p,EnemyList[0],item.Type.OnPlayerDeath);
                        }
                        if (p.Health <= 0){
                            p.remove();
                            PlayerParty.remove(p);
                        }
                    }
                }
                //p.remove(); //this is a problem, might need to put player death on a very short timer and then check again, just so that the effect can play in time
            }
        }
    }


    //all item related functions that are called before other things
    static function EnemyAttack(){
        for (p in PlayerParty){
            for (e in EnemyList){
                if (e.Health >= 1){
                    if (ItemList.length >= 1){
                        for(item in ItemList){
                            item.Effect(p,e,item.Type.OnHit);
                        }
                    }
                    PlayerParty[0].Health -= e.Damage; //BS protection
                    
                }
            }
        }
    }

    public static function InitFont(){
        NewFont = hxd.Res.fnt.Welcome_Magic_ttf.build(32, {chars: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:?*/,.+-%'1234567890 ", antiAliasing: true, kerning: true});
    }

}