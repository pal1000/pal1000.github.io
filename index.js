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

function formsubmit(parametters){
var submitURL=window.location.protocol + '//' + window.location.hostname + window.location.pathname+'?'+parametters[0]+'='+encodeURIComponent(document.getElementById(parametters[0]).value);
for (i=1;i<parametters.length;i++) submitURL+='&'+parametters[i]+'='+encodeURIComponent(document.getElementById(parametters[i]).value);
return submitURL;
}

function index(filename,extension){
         var list="<li><a href='"+encodeURIComponent(filename);
         if (extension==null) list+="/index.html'>"+filename+"</a></li>";
         else list+="."+encodeURIComponent(extension)+"'>"+filename+"."+extension+"</a></li>";
         return list;
}