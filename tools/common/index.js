function $_GET(key, default_)
{
  if (default_==null) default_=""; 
  key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
  var qs = regex.exec(window.location.href);
  var ret = default_;
  if(qs == null) ret = default_
  else ret=qs[1]
  return ret;
}

function formsubmit(paramname, value, isfirst){
var sep='&';
if (isfirst == null) isfirst = false;
if (isfirst) sep='?';
return sep+paramname+'='+encodeURIComponent(value);
}

function readform(paramname){
return document.getElementById(paramname).value;
}