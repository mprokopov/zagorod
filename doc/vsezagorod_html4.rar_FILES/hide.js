dom = (document.getElementById)? true : false;
nn4 = (document.layers)? true : false;
ie4 = (document.all && !dom)? true : false;

function show(elemId){ 
if (dom) document.getElementById(elemId).style.display = "block";
else if (ie4) document.all[elemId].style.display = "block";
}

function hide(elemId){ 
if (dom) document.getElementById(elemId).style.display = "none";
else if (ie4) document.all[elemId].style.display = "none";
}

function checkWho(value) {
if (value==1) {show('owner'); hide('agent');}
 else {show('agent'); hide('owner');}
 return true;
}