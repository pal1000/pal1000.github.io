<?php
$source=file_get_contents("https://thetvapp.to/tv/".$_GET['chname']);
$strposstart=strpos($source,"csrf-token");
$strposstart=strpos($source,"content",$strposstart)+strlen("content")+2;
$strposend=strpos($source,'"',$strposstart);
$token=substr($source,$strposstart,$strposend-$strposstart);
$strposstart=strpos($source,"/token/",$strposend)+strlen("/token/");
$strposend=strpos($source,'"',$strposstart);
$chid=substr($source,$strposstart,$strposend-$strposstart);
$strposstart=strpos(print_r($http_response_header,true),"XSRF-TOKEN");
$strposend=strpos(print_r($http_response_header,true),';',$strposstart);
$cookie_1=substr(print_r($http_response_header,true),$strposstart,$strposend-$strposstart);
$strposstart=strpos(print_r($http_response_header,true),"tvnow_session",$strposend);
$strposend=strpos(print_r($http_response_header,true),';',$strposstart);
$cookie_2=substr(print_r($http_response_header,true),$strposstart,$strposend-$strposstart);
header('Location: '.file_get_contents("https://thetvapp.to/token/".$chid,false,stream_context_create(['http'=>['method'=>"POST",'header'=>['X-CSRF-TOKEN: '.$token,'Cookie: '.$cookie_1.';'.$cookie_2]]])));
?>