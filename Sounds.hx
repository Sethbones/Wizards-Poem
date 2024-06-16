import h2d.Object;
import Random;
class Sounds extends Object{

    public static function PlaySound(sound:hxd.res.Sound){
        sound.play();
    }

    public static function PlaySoundAtRandomPitch(sound:hxd.res.Sound){
        var playback = sound.play();
        var pitch = new hxd.snd.effect.Pitch(Random.float(0.9,1.1));
        playback.addEffect(pitch);
    }
}