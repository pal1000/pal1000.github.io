<?php
error_reporting(E_ERROR);
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
echo "<html><head><title>Sopcast channel embedder</title><head><body><a href='../'>Exit</a><br>
";
if($sop==''){
echo "<form action='index.php' method='GET'>
Enter sopcast channel URL:<input type='text' name='sop'>
Player width (default to 100%):<input type='text' name='width'>
Player height (default to 100%):<input type='text' name='height'>
<input type='Submit' value='Submit'></form>";}
else{
echo '<a href="index.php">Restart</a><br>';
    echo '<object id="SopPlayer" name="SopPlayer" 
    classid=clsid:8FEFF364-6A5F-4966-A917-A3AC28411659 height="'.$height.'" width="'.$width.'">
    <param name="AutoStart" value="1">
    <param name="SopAddress" value="'.$sop.'">
    <param name="ChannelName" value="Tv Online">
    <a target="_blank" href="http://sopcast.org" rel="nofollow">
    <img src="http://cool-tv.net/ch/atentie.gif" width="'.$width.'" border="0" height="'.picfit($height).'"></a></object>
    <center><a href="../VLC/vlc.php?MRL=http%3A%2F%2F127.0.0.1%3A8902" target="blank">
    <img src="http://cool-tv.net/ch/meniu-openvlc.gif"/></a></center>';
}
echo '</body></html>';
?>   