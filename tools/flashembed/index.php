<?php
error_reporting(E_ERROR | E_WARNING | E_NOTICE);
$src='';if(array_key_exists('src',$_GET)){$src=$_GET['src'];}
$width='';if(array_key_exists('width',$_GET)){$width=$_GET['width'];}
$height='';if(array_key_exists('height',$_GET)){$height=$_GET['height'];}
if($width==''){$width='100%';}
if($height==''){$height='90%';}

echo "<html><head><title>Adobe Flash embedder</title><head><body><a href='../'>Exit</a><br>
";
if($src==''){
echo "<form action='index.php' method='GET'>
Enter iframe URL:<input type='text' name='src'>
Player width (default to 100%):<input type='text' name='width'>
Player height (default to 100%):<input type='text' name='height'>
<input type='Submit' value='Submit'></form>";}
else{
echo '<a href="index.php">Restart</a><br>';
    echo "<embed src='".$src."' width='".$width."' height='".$height."' allowfullscreen='true'/>";
}
echo '</body></html>';
?>   