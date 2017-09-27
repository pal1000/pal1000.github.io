<?php
$input=$_GET['input'];
$title=$_GET['title'];

function urlfix($inputd){
if(($inputd[0]=='W'||$inputd[0]=='w')&&($inputd[1]=='W'||$inputd[1]=='w')&&($inputd[2]=='W'||$inputd[2]=='w')){
$protocolstandard='http://';
$crinput=$protocolstandard.$inputd;
$inputd=$crinput;
}
return $inputd;
}

if($input==''){
echo("<html><head><title>Enter file URL</title><body>");
echo("<form action='index.php'>Enter URL:<input type='text' name='input'><br>");
echo("Enter title(optional):<input type='text' name='title'><br>");
echo("<input type='submit' value='submit'></form><br>");
echo("This tool allows you to download files from Internet instead of opening them with ");
echo("possibly unwanted programs.This goes for pdf documents or shockwave flash objects");
echo(" for example. The title allows to speciffy a title of the file (for media files most ");
echo("probably; this will be used instead of the URL.");
}
else{
if($title==''){
$input=urlfix($input);
echo("<html><head><title>");
echo($input);
echo("</title><body>Right click on this <a href='");
echo($input);
echo("'>");
echo("link");
echo("</a> and select save target as or equivalent, specify the name of the file and ");
echo("if you want to change the type, specify the extension and for save as type choose ");
echo("All files.");
echo "<br><a href='index.php'>Restart</a> ";
}
else{
$input=urlfix($input);
echo("<html><head><title>");
echo($title);
echo("</title><body>Right click on this <a href='");
echo($input);
echo("'>");
echo("link");
echo("</a> and select save target as or equivalent, specify the name of the file and ");
echo("if you want to change the type, specify the extension and for save as type choose ");
echo("All files.");
echo "<br><a href='index.php'>Restart</a> ";
}
}

echo "<br><a href='../'>Exit</a></body></html>";
?>
  

