function $_GET(key, default_)
{
  if (default_==null) default_="";
  key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
  var qs = regex.exec(window.location.href);
  if(qs == null) qs=default_;
  else qs=qs[1];
  return qs;
}

function formsubmit(paramname, isfirst){
var sep='&';
if (isfirst == null) isfirst = false;
if (isfirst) sep='?';
return sep+paramname+'='+encodeURIComponent(document.getElementById(paramname).value);
}

function index(filename,extension){
         var list="<li><a href='"+encodeURIComponent(filename);
         if (extension==null) list+="/index.html'>"+filename+"</a></li>";
         else list+="."+encodeURIComponent(extension)+"'>"+filename+"."+extension+"</a></li>";
         return list;
}