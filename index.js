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

function formsubmit(paramname, isfirst){
var sep='&';
if (isfirst == null) isfirst = false;
if (isfirst) sep='?';
return sep+paramname+'='+encodeURIComponent(document.getElementById(paramname).value);
}

function index(filename,extension){
         var list='';
         if (extension==null) list="<li><a href='"+encodeURIComponent(filename)+"/index.html'>"+filename+"</a></li>";
         else list="<li><a href='"+encodeURIComponent(filename)+"."+encodeURIComponent(extension)+"'>"+filename+"."+extension+"</a></li>";
         return list;
}