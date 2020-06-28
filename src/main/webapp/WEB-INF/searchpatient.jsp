<!DOCTYPE html>
<html>
<head>
    <style>
        .main-section{
	width: 460px;
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
  color:black
}
body{
    font-family: 'Lato', sans-serif;
	position: relative;
	background:#ece6e6;
	margin: 20px;
}
.header{
  margin-top:0%;
  min-height: 20%;
  width: 100%;
  color:rgb(10, 10, 9);
}
        
    </style>
</head>
<body>
  <div class="header">
    <h1 align='center'><strong>AGILE HOSPITAL MANAGEMENT</strong></h1>
</div>
<tr> <td>&nbsp;</td> </tr>

 <div class="main-section">
<table border='0' width='480px' cellpadding='0' cellspacing='0' align='center'>
<tr>
    <td align='center'>Patient Id</td>
    <td><input name='patid' pattern="[0-9]{9}"></td>
</tr><br> </br>
<table border='0' cellpadding='0' cellspacing='0' width='480px' align='center'>
    <tr>
        <td align='center'><button onclick="view()" name="view" value="View">View</button></td>
    </tr>
    </table>
     
    </table>
    </div>
</body>
   <script>
      function view()
      {
    $.ajax(
		{
				method : "get",
				url : "/patient",
				data : $('#search').serialize() + "&action=" + action,
				success : function(data){
					var json = JSON.parse(data);
					var patient_details=[];
					patient_details=json["User_Details"];
					if(patient_details.length!=0)
					{
						 if(action=="delete")
						 {
							patient_details.forEach(user => 
							{
								$("#ssnID").html(user["SSN_ID"]);
								$("#name").html(user["name"]);
								$("#age").html(user["age"]);
								$("#doj").html(user["DOA"]);
								$("#bed").html(user["type_of_bed"]);
								$("#addr").html(user["address"]);
								$("#city").html(user["city"]);
								$("#state").html(user["state"]);

							});
						}
          });

		}

</script>
 </html>