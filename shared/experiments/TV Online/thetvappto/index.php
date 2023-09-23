<?php
$source=file_get_contents("https://185.155.103.23/tv",false,stream_context_create(['ssl'=>["verify_peer"=>false,"verify_peer_name"=>false]]));
$strposstart=strpos($source,"<ol ");
$strposend=strpos($source,'</ol>',$strposstart)+strlen('</ol>');
$source=substr($source,$strposstart,$strposend-$strposstart);
$source=str_replace('/tv/','thetvappto.php?chname=',$source);
$source=str_replace('<a ','<li><a ',$source);
$source=str_replace('</a>','</a></li>',$source);
echo $source;
?>