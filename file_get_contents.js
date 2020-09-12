async function file_get_contents(filename){
  var rawdownload=await fetch(filename);
  return await rawdownload.text();
// call with await file_get_contents(filename).
// can only be called from another async function
}