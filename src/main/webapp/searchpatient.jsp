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
 <jsp:include page="header1.jsp" />
  
<tr> <td>&nbsp;</td> </tr>

 <div class="main-section">
<table border='0' width='480px' cellpadding='0' cellspacing='0' align='center'>
<tr>
    <td align='center'>Patient Id</td>
    <td><input id='patId' pattern="[0-9]{9}"></td>
    <td><button onclick="view()" name="view" value="View">View</button></td>
</tr><br> </br>
    </table>
    </div>
    <div id="patient_details" style="display:none">
    <table border='1' width='700px' cellpadding='4' cellspacing='0' align='center'>
    <tr>
    <th>Patient Id</th>
    <th>Patient SSN ID</th>
    <th>Name</th>
    <th>Age</th>
    <th>Date of Admission</th>
    <th>Type of bed</th>
    <th>Address</th>
    <th>City</th>
    <th>State</th>
    <th>Status</th>
    </tr>
    <tr>
    <td><span id='patId2'></span></td>
     <td><span id='ssnId'></span></td>
      <td><span id='name'></span></td>
       <td><span id='age'></span></td>
        <td><span id='doa'></span></td>
         <td><span id='bed'></span></td>
          <td><span id='address'></span></td>
           <td><span id='city'></span></td>
            <td><span id='state'></span></td>
            <td><span id='status'></span></td>
          
    </tr>
    </table>
    </div>
</body>
   <script>
      function view()
      {
    	  
    $.ajax({
				method : "get",
				url : "/patient?patId="+$('#patId').val(),
				success : function(data)
				{
					
					var json = JSON.parse(data);
					if(json["status"]!=undefined){
						alert(json["status"]);
					}
					else {
						var patient_details=[];
						patient_details=json["patient_details"];
						if(patient_details.length!=0)
						{
							 
								patient_details.forEach(user => 
								{
									$("#patId2").html(user["patient_ID"]);
									$("#ssnId").html(user["SSN_ID"]);
									$("#name").html(user["name"]);
									$("#age").html(user["age"]);
									$("#doa").html(user["DOA"]);
									$("#bed").html(user["type_of_bed"]);
									$("#address").html(user["address"]);
									$("#city").html(user["city"]);
									$("#state").html(user["state"]);
									$("#status").html(user["status"]);
									
								});
							$("#patient_details").css("display","block");
						}
						else {
							
							alert("Please Enter Valid Patient ID");
						}
					}
				}
          });

		}

</script>
 </html>