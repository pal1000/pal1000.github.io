<?php
$source=file_get_contents("https://thetvapp.to/tv");
$strposstart=strpos($source,"<ol ");
$strposstart=strpos($source,"<a ",$strposstart);
$strposend=strpos($source,'</ol>',$strposstart);
$source=substr($source,$strposstart,$strposend-$strposstart);
$source=substr($source,0,strlen($source)-strpos(strrev($source),">"));
$source=explode("\n",$source);
echo "#EXTM3U\n";
$baseurl=(empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]";
if($_SERVER['SERVER_PORT']!=80&&$_SERVER['SERVER_PORT']!=443) $baseurl.=":".$_SERVER['SERVER_PORT'];
$baseurl.=htmlentities($_SERVER['SCRIPT_NAME']);
$baseurl=substr($baseurl,0,strlen($baseurl)-strlen('index.php'));
for($i=0;$i<count($source);$i++){
  $minsrc=str_replace("'",'"',$source[$i]);
  $strposstart=strpos($minsrc,'href="')+strlen('href="');
  $strposend=strpos($minsrc,'"',$strposstart);
  $chlink=substr($minsrc,$strposstart,$strposend-$strposstart);
  $strposstart=strpos($minsrc,'>',$strposend)+1;
  $strposend=strpos($minsrc,'<',$strposstart);
  $chlabel=substr($minsrc,$strposstart,$strposend-$strposstart);
  echo "#EXTINF:-1,".$chlabel." (thetvapp.to)\n".$baseurl.str_replace("/","",str_replace('/tv/','thetvappto.php?chname=',$chlink));
  if(count($source)-$i>1) echo "\n\n";
}
?>