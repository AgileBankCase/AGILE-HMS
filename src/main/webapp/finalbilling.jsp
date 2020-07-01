<!DOCTYPE html>
<html>
<head>
<style>
body {
	background: #ece6e6
}

.main-section {
	position: relative;
	color: black
}

.diagnostics {
	position: relative;
	color: black
}

.additional {
	position: relative;
	color: black
}
</style>
</head>
<body bgcolor=#E6E6FA>
	<jsp:include page="header1.jsp" />

	<div class="main-section">
		<br> <br> <br> <br>
		<center>
			<h1 align='center'>Patient Billing</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='480px'
				align='center' id="view_patients">
				<tr>
					<th>Patient ID</th>
					<th>Name</th>
					<th>Age</th>
					<th>Address</th>
					<th>DOJ</th>
					<th>Type of BED</th>
				</tr>
				<tr>
					<td><input id="patId" name='patId' pattern="[0-9]{9}"
						width='480px' required>
						<button onclick="display(event)" name="learn" value="myimage">
							<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
						</button> <input type="hidden" id="patId2"></td>
					<td><span id="name"></span></td>
					<td><span id="age"></span></td>
					<td><span id="address"></span></td>
					<td><span id="doj"></span></td>
					<td><span id="bed"></span></td>
				</tr>

			</table>
			<br> <span id="days"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
				id="bill"></span>
	</div>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<div class="medicine hide" id="meddiv">
		<center>
			<h1 align='center'>Pharmacy charges</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='320px'
				align='center' id="issuedMedicine">
				<tr>
					<th>Medicine</th>
					<th>Quantity</th>
					<th>Rate</th>
					<th>Amount</th>
				</tr>

			</table>
			<br>
			<tr>
				<span id="billpharma"></span>
			</tr>
			<br>
	</div>
	<div class="diagnostics hide" id="diagdiv">
		<center>
			<h1 align='center'>Diagnostics charges</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='320px'
				align='center' id="issuedDiagnostics">
				<tr>
					<th>Name of the test</th>
					<th>Amount</th>
				</tr>

			</table>
			<br>
			<tr>
				<span id="billdiagno"></span>
			</tr>
			<br>

			<table align="center">
				<tr>
					<td align='right'><span id="grandtot"></span></td>
				</tr>
				<tr>
					<td>
						<center>
							<button  onclick="billPost()" name="add" align='center'>Discharge</button>
						</center>
					</td>
					
				</tr>
			</table>
	</div>
	<script>
	var totBill=0;
  	function display(event){
  		event.preventDefault();
		$.ajax({
			method : "get",
			url : "/patient?genBill=true&patId=" + $("#patId").val(),
			success : function(data) {

				var json = JSON.parse(data);
				if (json["status"] != undefined) {
					alert(json["status"]);
				} else {
					var patient_details = [];
					patient_details = json["patient_details"];
					if (patient_details.length != 0) {
						var user = "";
						user = patient_details[0];
						$('#days').html("No.of days:"+user["no_of_days"]+" days");
						$('#bill').html("Bill for room: Rs."+user["bill_for_room"]);
						totBill+= parseInt(user["bill_for_room"]);
						$("#patId2").val(user["patient_ID"]);

						$("#name").html(user["name"]);

						$("#age").html(user["age"]);
						$("#doj").html(user["DOA"]);
						$("#bed").html(user["type_of_bed"]);
						$("#address").html(user["address"]);
						renderIssuedMedicines();
						renderIssuedDiagnostics();
						calcamount();
					} else {
						alert("Please Enter Valid Patient ID");
					}
				}
			}
		});
  	}
  	function renderIssuedMedicines(){
		$.ajax({
			method : "get",
			url : "/medicine?patId="+$('#patId2').val(),
			success : function(data)
			{
				
				var json = JSON.parse(data);
				if(json["status"]!=undefined){
					alert(json["status"]);
				}
				else {
					var patient_details=[];
					patient_details=json["Patient_Medicine_Details"];
					var patient_data ='';
					$('#issuedMedicine').html("");
					 patient_data+="<tr>"+
					      "<th>Medicine</th>"+
					      "<th>Quantity</th>"+
					      "<th>Rate</th>"+
					      "<th>Amount</th>"+
					    "</tr>";
					 $('#issuedMedicine').append(patient_data);

					if(patient_details.length!=0)
					{
						patient_data ='';
						patient_details.forEach(user => 
						{
							 patient_data += '<tr>';
					            patient_data += '<td>'+user["medicine_name"]+'</td>';
					            patient_data += '<td>'+user["issued_quantity"]+'</td>';
					            patient_data += '<td>'+user["rate"]+'</td>';
					            patient_data += '<td>'+user["amount"]+'</td>';
					            patient_data += '</tr>';
					    });
					       $('#issuedMedicine').append(patient_data);
							
						$("#meddiv").attr("class","medicine");
						
					}
					
				}
			}
      });

	}
  	function renderIssuedDiagnostics(){
		$.ajax({
			method : "get",
			url : "/diagno?patId="+$('#patId2').val(),
			success : function(data)
			{
				
				var json = JSON.parse(data);
				if(json["status"]!=undefined){
					alert(json["status"]);
				}
				else {
					var patient_details=[];
					patient_details=json["Patient_Diagnostic_Details"];
					var patient_data ='';
					$('#issuedDiagnostics').html("");
					 patient_data+="<tr>"+
					      "<th>Name of the test</th>"+
					      "<th>Amount</th>"+
					    "</tr>";
					 $('#issuedDiagnostics').append(patient_data);

					if(patient_details.length!=0)
					{
						patient_data ='';
						patient_details.forEach(user => 
						{
							 patient_data += '<tr>';
					            patient_data += '<td>'+user["test_name"]+'</td>';
					            patient_data += '<td>'+user["amount"]+'</td>';
					            patient_data += '</tr>';
					    });
					       $('#issuedDiagnostics').append(patient_data);
							
						$("#diagdiv").attr("class","medicine");
					}
					
				}
			}
      });

	}
  	function calcamount()
  	{
  		$.ajax
  		({
			method : "get",
			url : "/bill?patId="+$('#patId2').val(),
			success : function(data)
			{
				
				var json = JSON.parse(data);
				if(json["status"]!=undefined)
				{
					alert(json["status"]);
				}
				else
				{
					$('#billdiagno').html("Bill for Diagnostics: Rs."+json["diangnosticAmount"]);
					$('#billpharma').html("Bill for Pharmacy: Rs."+json["pharmaAmount"]);
					totBill+=(parseInt(json["diangnosticAmount"])+parseInt(json["pharmaAmount"]));
					$('#grandtot').html("Grand Total: Rs."+totBill);
					    							
				}
					
			}
			
      });
  	}
  	function billPost(){
  		event.preventDefault();
		$.ajax({
			method:"post",
			url:"/bill?patId=" + $("#patId2").val(),
			success:function (data){
				var json = JSON.parse(data);
				if(json["status"]!="Succesfully Registered!"){
					alert(json["status"]);
				}
				else {
					alert("Patient Succesfully Discharged");
					document.location.reload();
					
					
				}
			}
			});
  	}
  </script>
</body>
</html>