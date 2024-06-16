import GameScene.GameController;
import h2d.Scene;

class WordBox extends h2d.Interactive{

    var asset:hxd.res.Image;
    public var ogX = 0;
    public var ogY = 0;
    
    
    public function CreateBox(letter:String, rendertarget:Scene, xPos:Int, yPos:Int ){
        asset = hxd.Res.ast.TextBox;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,this);
        var tf = new h2d.Text(GameController.NewFont, this);
        tf.text = letter.toUpperCase();
        tf.x = 10;
        tf.y = 0;
        tf.scale(1.75);
        tf.color = new h3d.Vector4(0,0,0,1);
        this.x = xPos;
        this.y = yPos;
        ogX = xPos;
        ogY = yPos;
    }

    public function CreateItemBox(ItemToPreview:Item.Item, rendertarget:Scene, xPos:Int, yPos:Int ){
        asset = hxd.Res.ast.ItemSelect;
        var assetdata = asset.toTile();
        var assetbmp = new h2d.Bitmap(assetdata,this);
        ItemToPreview.DrawIcon(assetbmp);
        this.x = xPos;
        this.y = yPos;
    }
}