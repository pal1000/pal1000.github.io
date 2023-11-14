<?php
$source=file_get_contents("https://thetvapp.to/tv/".$_GET['chname']);
$strposstart=strpos($source,'source:');
if($strposstart===false) $strposstart=strpos($source,'file:');
$strposstart=strpos($source,'http',$strposstart);
$strposend=strpos($source,',',$strposstart)-1;
header('User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0');
header('Origin: https://thetvapp.to');
header('Referer: https://thetvapp.to/');
header('Location: '.substr($source,$strposstart,$strposend-$strposstart));
?>