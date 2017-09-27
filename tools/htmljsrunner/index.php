<?php
$string='';
$string=$_POST['string'];
if($string==''){echo "<html>\n<head>\n<title>Enter HTML and Javascript code</title>\n</head>\n<body>\n<form action='index.php' method='POST'>\n Enter HTML and Javascript code:\n<textarea name='string'></textarea>\n<input type='submit' value='Submit'>\n</form><br><a href='../'>Exit</a>";}
else{ echo "<a href='index.php'>Restart</a><br><a href='../'>Exit</a><br>".$string;}
echo "</body>\n</html>"; 
?>
