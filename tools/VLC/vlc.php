<html>
<title>VLC Play</title>
<body>
<?php
$browser=$_SERVER['HTTP_USER_AGENT'];
$url=$_GET['MRL'];
$pg=file_get_contents('http://www.videolan.org/vlc/');
$pos=strpos($pg,'get.videolan.org/vlc');
$e1=strpos($pg,'"',$pos);
$e2=strpos($pg,"'",$pos);
$end=min($e1,$e2);
$diff=$end-$pos;
$pluginlink='http://'.substr($pg,$pos,$diff);
$s1=strpos($browser,'Trident');
$s2=strpos($browser,'MSIE');
if($s1==false&&$s2==false){
echo '<embed id="vlc" 
type="application/x-vlc-plugin" pluginspage="'.$pluginlink.'" 
width="100%" height="85%" events="True"AutoLoop="1" AutoPlay="1" Toolbar="1" MRL="'.$url.'" Visible="1" Volume="85" 
StartTime="0" BaseURL="'.$url.'" BackColor="1" ShowControls="true"/>';}
else{
echo '<OBJECT id=vlc codeBase="'.$pluginlink.'" classid=clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921 width="100%" height="85%" events="True">
<PARAM NAME="AutoLoop" VALUE="1">
<PARAM NAME="AutoPlay" VALUE="1">
<PARAM NAME="Toolbar" VALUE="1">
<PARAM NAME="MRL" VALUE="'.$url.'">
<PARAM NAME="Visible" VALUE="1">
<PARAM NAME="Volume" VALUE="85">
<PARAM NAME="StartTime" VALUE="0">
<PARAM NAME="BaseURL" VALUE="'.$url.'">
<PARAM NAME="BackColor" VALUE="1">
<param name="ShowControls" value="true">
</OBJECT>';}
?>
<script language="Javascript">
<!--
var vlc = document.getElementById("vlc");
function doChangeAspectRatio(arValue)
{
 if( vlc.input.state && vlc.input.hasVout )
 {
 vlc.video.aspectRatio = arValue;
 }
 aspectRatio = arValue;
};
//!-->
</script><br>
<a href='javascript:vlc.playlist.play();'>Play</a>&nbsp;
<a href='javascript:vlc.audio.toggleMute();'>Mute</a>&nbsp;
<a href='javascript:vlc.playlist.stop();'>Stop</a>&nbsp;
<a href='javascript:vlc.video.toggleFullscreen();'>Fullscreen</a>&nbsp;
<a href='javascript:doChangeAspectRatio("4:3");'>4:3</a>&nbsp;
<a href='javascript:doChangeAspectRatio("16:9");'>16:9</a>&nbsp;
<a href='index.html'>Back</a>&nbsp;
<a href='../'>Exit</a>
</body>
</html>