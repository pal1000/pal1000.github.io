<?php
error_reporting(E_ERROR | E_WARNING);
$sop=$_GET['sop'];
$width=$_GET['width'];
$height=$_GET['height'];
if($width==''){$width='100%';}
if($height==''){$height='90%';}

function picfit($pixel){
         $percent=substr($pixel,-1);
         if($percent=='%'){$len=strlen($pixel);$len--;$out=substr($pixel,0,$len);}
         else{ $out=$pixel;}
         $out=$out*(11/12);
         if($percent=='%'){$out.='%';}
         return $out;
}
echo "<html><head><title>Sopcast channel finder</title><head><body><a href='../'>Exit</a><br>
";
if($sop==''){
echo "<form action='index.php' method='GET'>
Enter web page adress that embeds sopcast plugin:<input type='text' name='sop' size='70'><br>
Player width (default to 100%):<input type='text' name='width'>
Player height (default to 90%):<input type='text' name='height'>
<input type='Submit' value='Submit'></form>";}
else{
    $opts = array('http'=>array('header' => "User-Agent:MyAgent/1.0\r\n"));
    $context = stream_context_create($opts);
    $c = file_get_contents($sop,false,$context);
    $pos=strpos($c,'sop://');
    $posf1=strpos($c,'&',$pos);if($posf1===false){$posf1=strlen($c);}
    $posf2=strpos($c,"'",$pos);if($posf2===false){$posf2=strlen($c);}
    $posf3=strpos($c,"`",$pos);if($posf3===false){$posf3=strlen($c);}
    $posf4=strpos($c,',',$pos);if($posf4===false){$posf4=strlen($c);}
    $posf5=strpos($c,';',$pos);if($posf5===false){$posf5=strlen($c);}
    $posf6=strpos($c,'#',$pos);if($posf6===false){$posf6=strlen($c);}
    $posf7=strpos($c,'<',$pos);if($posf7===false){$posf7=strlen($c);}
    $posf8=strpos($c,'>',$pos);if($posf8===false){$posf8=strlen($c);}
    $posf9=strpos($c,'"',$pos);if($posf9===false){$posf9=strlen($c);}
    $posf=min($posf1,$posf2,$posf3,$posf4,$posf5,$posf6,$posf7,$posf8,$posf9); 
    $dpos=$posf-$pos;
    $url=substr($c,$pos,$dpos);
    $len=strlen($url);$sopurl='';
    for($i=0;$i<$len;$i++){
        if($url[$i]!=' '){$sopurl.=$url[$i];}
    }   
    echo 'We were able to retrieve <a href="'.$sopurl.'">this channel link</a>
    from the webpage you supplied.
    <a href="index.php">Restart</a><br>';
    echo '<object id="SopPlayer" name="SopPlayer" 
    classid=clsid:8FEFF364-6A5F-4966-A917-A3AC28411659 height="'.$height.'" width="'.$width.'">
    <param name="AutoStart" value="1">
    <param name="SopAddress" value="'.$sopurl.'">
    <param name="ChannelName" value="Tv Online">
    <a target="_blank" href="http://sopcast.org" rel="nofollow">
    <img src="http://cool-tv.net/ch/atentie.gif" width="'.$width.'" border="0" height="'.picfit($height).'"></a></object>
    <center><a href="../VLC/vlc.php?MRL=http%3A%2F%2F127.0.0.1%3A8902" target="blank">
    <img src="http://cool-tv.net/ch/meniu-openvlc.gif"/></a></center>';
}
echo '</body></html>';
?>   