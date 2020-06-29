<!DOCTYPE html>
<html>
<head>
    <style>

        .main-section{
	width: 460px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}        
    </style>
</head>
<body bgcolor= #E6E6FA>
<jsp:include page="header1.jsp" />
 

 
<table border='0' width='480px' cellpadding='0' cellspacing='0' align='center'>
<center><tr>
   <td><h1 align='center'>View Patients</h1></td>
</tr><center>
    <table border="1"cellpadding='0' cellspacing='0' width='480px' align='center' id="view_patients">
    
  </table>
  <tr> <td>&nbsp;</td> </tr>
  <tr> <td>&nbsp;</td> </tr>
  </body>
    <script>
    document.onready(viewPatient());
    function viewPatient()
    {
  	  
  			$.ajax({
				method : "get",
				url : "/patient?patId=-1",
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
						{var patient_data ='';
						$('#view_patients').html("");
							 patient_data+="<tr>"+
							      "<th>Patient ID</th>"+
							      "<th>Name</th>"+
							      "<th>Age</th>"+
							      "<th>Address</th>"+
							      "<th>Date of Admission</th>"+
							      "<th>Type of Room</th>"+
							    "</tr>";
								patient_details.forEach(user => 
								{
									 patient_data += '<tr>';
							            patient_data += '<td>'+user["patient_ID"]+'</td>';
							            patient_data += '<td>'+user["name"]+'</td>';
							            patient_data += '<td>'+user["age"]+'</td>';
							            patient_data += '<td>'+user["address"]+'</td>';
							            patient_data += '<td>'+user["DOA"]+'</td>';
							            patient_data += '<td>'+user["type_of_bed"]+'</td>';
							            patient_data += '</tr>';
							    });
							       $('#view_patients').append(patient_data);
									
								
						}
					}
					/* else {
							
							alert("Please Enter Valid Patient ID");
					} */
				         
				  }
  			});
	}
				    
    </script>
             
          
  </html>
