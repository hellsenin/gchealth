function getCheckedValue(radioObj) 
{
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) 
	{
		if(radioObj[i].checked) 
		{
			return radioObj[i].value;
		}
	}
	return "";
}

function checkSatisfactionForm(form)
{
	var statusVal = getCheckedValue(form.status);
	if(!statusVal)
	{
		alert("사용자 만족도 평가를 선택하세요.");
		//(document.getElementById("status3")).focus();
		return false;			
	}
	if(!form.opinion.value)
	{
		alert("한줄의견을 입력해주세요.");
		//form.opinion.focus();
		(document.getElementById("opinion")).style.backgroundImage="url(none)";
		return false;			
	}
	return true;
}