import GameScene.GameController;

class EndScreen extends h2d.Object{
    public override function new( ?parent : h2d.Object ){
        super(parent);
    }

    public function endscreen(){
        var endbox = new h2d.Interactive(960,540,this);
        endbox.backgroundColor = 0xff000000;
        var endtext = new h2d.Text(GameController.NewFont, endbox);
        endtext.text = "thank very much for playing my silly little game,\ni hope that it at least was enjoyable.\n\nSorry that there isn't much here\nThe whole joke of the game was supposed to be that,\nat the end of the run you'll see the all the words created being\nmerged together into a 'poem',\nbut in the end i didn't have enough time to implement it";
    }
}