import GameScene.GameController;

class Global extends h2d.Object{
    public static function RandomLetter():String{//this is here because i can weight letters if needed to make some letters more common than others
        //words like j, z, and q should be way less common, intentionally because they don't have many words to them
        //q only has 1792
        return Random.string(1,"aaaaabbbcddeeeeefgghiiiiklllmmnnnooopprrrssstttuuvwxyz");
        //words removed for the sake of gameplay: Q, J, reason: they basically have no words
        //old weight return Random.string(1,"aaaabcdeeeefghiiijkllmnnoopqrrrssttuvwxyz");
        //oldest weight return Random.string(1,"aaaaabcdeeeeefghiiiijkllmnnooopqrrrrrssttuvwxyz");
    }

    public static var ItemPool:Array<Item.Item> = [
        new Item.MysticShield(GameController.CurrentScene),
        new Item.SoulRune(GameController.CurrentScene),
        new Item.SheepStaff(GameController.CurrentScene),
        new Item.SkippingStone(GameController.CurrentScene),
        new Item.Steak(GameController.CurrentScene),
        new Item.ScrollOfPiercing(GameController.CurrentScene),
        new Item.OrbOfChaos(GameController.CurrentScene),
        new Item.ThornMail(GameController.CurrentScene),
        new Item.LoadedDice(GameController.CurrentScene),
        new Item.GodsStaff(GameController.CurrentScene),
        new Item.StrengthPotion(GameController.CurrentScene),
        new Item.Backstabber(GameController.CurrentScene),
        new Item.DysonOrb(GameController.CurrentScene),
    ];

    public static function GetRandomItem():Item.Item{
        return ItemPool[Random.int(0, ItemPool.length -1)];
    }
}