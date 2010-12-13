function cancelApply()
{
	var condition = false;
	if(confirm("신청을 취소하시겠습니까?"))
	{
		condition =  true;
	}
	return condition;
}

function getCheckedCount(obj_name)
{
	var cnt = 0;
	var obj_array = obj_name.split("|");

	// checkbox의 갯수만큼 ROOP

	var l1 = obj_array.length;
	
	for (i=0;i<l1;i++)
	{
		// 입력된 obj_name을 객체로 변환
		if (obj_array[i] != "") // 객체명이 공백인지 검사
		{
			checkbox_obj = eval("document.all." + obj_array[i]);
		
			if(checkbox_obj != null) //생성된 객체의 존재유무 검사
			{
				if (checkbox_obj.length != null) // 생성된 객체가 다수 인지 한개 인지 검사
				{
					// 생성된 객체가 다수일 경우	

					// 객체로 변환된 checkbox버튼의 갯수 
					 l2 = checkbox_obj.length;
		
					 for(j=0;j<l2;j++)
					 {						
						if(checkbox_obj.item(j).checked)
							cnt++;
					 }
				}
				else
				{
					//생성된 객체가 하나인 경우
					if(checkbox_obj.checked)
						cnt++;				}
			}
		}
	}
	
	return cnt;
}

function checkbox_toggle(obj_name, status)
{

	//   제목   :  CheckBox Clear
	//
	//   사용법
	//
	//   obj_name : Clear시킬 checkbox의 Name (여러개의 checkbox을 동시에 Clear시킬수 있으며 
	// 		이때는 각 checkbox의 Name를 " | "로 구분하여 obj_name에 입력한다.
	//


	// 입력된 obj_name을 각각의 checkbox의 Name로 분리

	obj_array = obj_name.split("|");

	// checkbox의 갯수만큼 ROOP

	l1 = obj_array.length;
	
	for (i=0;i<l1;i++)
	{
		// 입력된 obj_name을 객체로 변환
		if (obj_array[i] != "") // 객체명이 공백인지 검사
		{
			checkbox_obj = eval("document.all." + obj_array[i]);
		
			if(checkbox_obj != null) //생성된 객체의 존재유무 검사
			{
				if (checkbox_obj.length != null) // 생성된 객체가 다수 인지 한개 인지 검사
				{
					// 생성된 객체가 다수일 경우	

					// 객체로 변환된 checkbox버튼의 갯수 
					 l2 = checkbox_obj.length;
		
					 for(j=0;j<l2;j++)
					 {
						//각각의 checkbox의 체크를 해제

						checkbox_obj.item(j).checked = status;
					 }
				}
				else
				{
					//생성된 객체가 하나인 경우
					//각각의 checkbox의 체크를 해제

					checkbox_obj.checked = status;		
				}
			}
		}
	}
}
