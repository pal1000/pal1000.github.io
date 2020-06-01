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
         var list=window.location.protocol + '//' + window.location.hostname + window.location.pathname;
         var trimmed=0;
         if(trimmed == 0 && list.substring(list.length-11, list.length)=='/index.html') {
            list=list.substring(0, list.length-11);
            trimmed=1;
         }
         if(trimmed == 0 && list.substring(list.length-10, list.length)=='/index.htm') {
            list=list.substring(0, list.length-10);
            trimmed=1;
         }
         if(trimmed == 0 && list.substring(list.length-1, list.length)=='/') {
            list=list.substring(0, list.length-1);
            trimmed=1;
         }
         list="<li><a href='"+list+"/"+encodeURIComponent(filename);
         if (extension==null) list+="/index.html'>"+filename+"</a></li>";
         else list+="."+encodeURIComponent(extension)+"'>"+filename+"."+extension+"</a></li>";
         return list;
}

function embedcode(){
var embedcode="&lt;iframe src=&apos;"+window.location.href+"&isembedded=1&apos; width=&apos;"+width+"&apos; height=&apos;"+height+"&apos; allowfullscreen=&apos;true&apos;/&gt;";
return 'Embed code: <input type="text" size="'+window.screen.width/8+'" value="'+embedcode+'" readonly>';
}

async function file_get_contents(filename){
  var rawdownload=await fetch(filename);
  var content=await rawdownload.text();
  document.write(content);
}